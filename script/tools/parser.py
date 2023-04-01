import json
import re

import fitz
from fitz import Document, Page
from fitz.utils import get_text, search_for

from models.subject import CAPSubject
from models.subject_question import SubjectQuestion, QuestionType, QuestionChoice, QuestionAnswer
from tools.pdf import parse_document_table


# TODO: Support image and table parsing
def parse_exam_paper(file_path: str, subject: CAPSubject, answers: dict[CAPSubject, list[QuestionAnswer]]) \
        -> list[SubjectQuestion]:
    doc = Document(file_path)
    pages: list[Page] = doc.pages()
    page_text: str = ""

    for page_index, page in enumerate(pages):
        # Skip the CAP exam instructions page
        if page_index == 0:
            continue

        page_text += get_text(page, sort=True)

    matches = re.finditer(r"(\d+)\..*?(?=\d+\.|試題結束|請閱讀以下短文|第二部分:非選擇題)", page_text, flags=re.DOTALL)

    filtered_questions: list[str] = []

    for index, match in enumerate(matches):
        question_number = int(match.group(1))

        """
        Handle the case that the question has additional information.
        For example:
        Which idea is talked about in the first paragraph of the reading?
        (A) ...
         paragraph 段落 (This is additional information.)
        (B) ...
        (C) ...
        (D) ...
        """
        if len(filtered_questions) + 1 != question_number:
            filtered_questions[len(filtered_questions) - 1] += match.group(0)
        else:
            filtered_questions.append(match.group(0))

    questions: list[SubjectQuestion] = []

    for i, q in enumerate(filtered_questions):
        choices_pattern = r"\([A-D]\)[^()]+"

        q_num = int(re.search(r"^\d+\.", q).group(0).replace(".", ""))
        q_choices: list[str] = re.findall(choices_pattern, q)
        q_description = fix_text(re.sub(choices_pattern, "", q).replace(str(q_num), "", 1).replace(".", "", 1))

        choices: list[QuestionChoice] = []

        for choice in q_choices:
            description = fix_text(re.sub(r"\([A-D]\)", "", choice))
            answer = re.search(r"\([A-D]\)", choice).group(0).replace("(", "").replace(")", "")
            choices.append(QuestionChoice(description if description != "" else None, QuestionAnswer(answer)))

        question = SubjectQuestion(q_num, QuestionType.SINGLE_CHOICE, q_description, choices,
                                   answers[subject][q_num - 1])
        questions.append(question)

    return questions


def parse_exam_answer(file_path: str) -> dict[CAPSubject, list[QuestionAnswer]]:
    doc = Document(file_path)
    pages: list[Page] = list(doc.pages())
    year = int(re.search(r"(\d+)年|(\d+) 年", get_text(pages[0], sort=True)).group(0).replace("年", "").strip())
    sorted_table: list[str] = []
    result: dict[CAPSubject, list[QuestionAnswer]] = {}

    new_curriculum_guidelines = year >= 111
    # Each subject has different question number range.
    english_listening_end = 21
    math_end = 26 if year in [106, 107, 108, 109, 110] else 25
    english_reading_end = 43 if new_curriculum_guidelines else (40 if year == 104 else 41)
    chinese_end = 43 if new_curriculum_guidelines else 48
    nature_end = 50 if new_curriculum_guidelines else 54

    # Initialize the result dict
    for subject in CAPSubject:
        result[subject] = []

    for page in pages:
        table_top: fitz.Rect = search_for(page, "閱讀", hit_max=1)[0]

        table = parse_document_table(page, [0, table_top.y1, 99999, 99999])
        # Flatten the table.
        table = [item for sublist in table for item in sublist]
        # Sort the table by the question number.
        for answer_index, item in enumerate(table):
            question_number = (answer_index if page.number == 0 else answer_index + 30) + 1
            if question_number + 1 > nature_end:
                sorted_table.append(item)
            elif len(item) == 1:
                sorted_table.append(item + table[answer_index + 1])
            elif len(table[answer_index - 1]) != 1:
                sorted_table.append(item)

    # Remove the question number and space.
    sorted_table = [re.sub(r"\d+| ", "", item) for item in sorted_table]
    sorted_table = [item for item in sorted_table if item != ""]

    def handle_answer(answer_list: list[str], subjects: list[CAPSubject]):
        for i, subject in enumerate(subjects):
            result[subject].append(QuestionAnswer(answer_list[i]))

    for index, answers in enumerate(sorted_table):
        # R.O.C 108 Curriculum Guidelines.
        question_number = index + 1
        answers_list = list(answers)

        if question_number <= english_listening_end:
            subjects = [CAPSubject.CHINESE, CAPSubject.ENGLISH_Reading, CAPSubject.ENGLISH_LISTENING, CAPSubject.MATH,
                        CAPSubject.SOCIETY, CAPSubject.NATURE]

            # Due to the severity of the COVID-19 epidemic in ROC 109 (2020), the English listening exam was suspended.
            if year == 109:
                subjects.remove(CAPSubject.ENGLISH_LISTENING)

            handle_answer(answers_list, subjects)
        elif question_number <= math_end:
            subjects = [CAPSubject.CHINESE, CAPSubject.ENGLISH_Reading, CAPSubject.MATH, CAPSubject.SOCIETY,
                        CAPSubject.NATURE]
            handle_answer(answers_list, subjects)
        elif question_number <= english_reading_end:
            subjects = [CAPSubject.CHINESE, CAPSubject.ENGLISH_Reading, CAPSubject.SOCIETY, CAPSubject.NATURE]

            if new_curriculum_guidelines and question_number > 42:
                subjects.remove(CAPSubject.CHINESE)

            handle_answer(answers_list, subjects)
        elif question_number <= chinese_end:
            subjects = [CAPSubject.CHINESE, CAPSubject.SOCIETY, CAPSubject.NATURE]
            handle_answer(answers_list, subjects)
        elif question_number <= nature_end:
            subjects = [CAPSubject.SOCIETY, CAPSubject.NATURE]
            handle_answer(answers_list, subjects)
        else:
            handle_answer(answers_list, [CAPSubject.SOCIETY])

    return result


def save_parse_result(questions: list[SubjectQuestion]):
    json_str = json.dumps([q.to_dict() for q in questions], ensure_ascii=False)
    with open("temp/cap_exams.json", "w") as f:
        f.write(json_str)


def fix_text(text: str) -> str:
    text = re.sub(r"(\w+)\n(\w+)", r"\1\2", text)
    text = re.sub(r"(\w+)\d\n請翻頁繼續作答", r"\1", text)
    text = re.sub(r" \n\d請翻頁繼續作答", r"", text)

    return text.strip()
