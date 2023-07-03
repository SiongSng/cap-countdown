import json
import re
from typing import NewType

from fitz import Document, Page
from fitz.utils import get_text, search_for

from models.cap_subject import CAPSubject
from models.exam import Exam
from models.optional_question import QuestionChoice, QuestionAnswer
from models.single_choice_question import SingleChoiceQuestion
from models.subject_question import SubjectQuestion

ANSWERS_TYPE = NewType("ANSWERS_TYPE", dict[CAPSubject, list[QuestionAnswer]])
EXAM_INDICATOR = NewType("EXAM_INDICATOR", dict[CAPSubject, float])


# TODO: Support image and table parsing
def parse_exam_paper(
    file_path: str,
    subject: CAPSubject,
    answers: ANSWERS_TYPE,
    passing_rates: EXAM_INDICATOR,
    discrimination_indexes: EXAM_INDICATOR,
) -> list[SubjectQuestion]:
    """
    Parse the exam paper and return a list of exam result.
    Args:
        file_path (str): The exam paper file path.
        subject (CAPSubject): The exam subject.
        answers (ANSWERS_TYPE): The correct answers of the exam paper. Can be obtained by calling parse_exam_answer().
        passing_rates (EXAM_INDICATOR): The exam passing rates. Can be obtained by calling parse_exam_indicator().
        discrimination_indexes (EXAM_INDICATOR): The exam discrimination indexes.
            Can be obtained by calling parse_exam_indicator().

    Returns:
        list[SubjectQuestion]: A list of exam result.
    """
    doc = Document(file_path)

    doc_text: str = ""
    result: list[SubjectQuestion] = []

    for page in doc:
        # Skip the CAP exam instructions page.
        if page.number == 0:
            continue

        doc_text += get_text(page, sort=True)

    matches = re.finditer(
        r"(\d+)\..*?(?=\d+\.|試題結束|請閱讀以下短文|第二部分:非選擇題)", doc_text, flags=re.DOTALL
    )

    filtered_questions: list[str] = []

    for match in matches:
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

    for question in filtered_questions:
        choices_pattern = r"\([A-D]\)[^()]+"

        number = int(re.search(r"^\d+\.", question).group(0).replace(".", ""))
        choices: list[str] = re.findall(choices_pattern, question)
        description = fix_question_text(
            re.sub(choices_pattern, "", question)
            .replace(str(number), "", 1)
            .replace(".", "", 1)
        )
        correct_answer = answers[subject][number - 1]
        passing_rate = passing_rates[subject][number - 1]
        discrimination_index = discrimination_indexes[subject][number - 1]

        parsed_choices: list[QuestionChoice] = []

        for choice in choices:
            choice_description = fix_question_text(re.sub(r"\([A-D]\)", "", choice))
            choice_answer = (
                re.search(r"\([A-D]\)", choice)
                .group(0)
                .replace("(", "")
                .replace(")", "")
            )
            parsed_choices.append(
                QuestionChoice(
                    choice_description if choice_description != "" else None,
                    QuestionAnswer(choice_answer),
                )
            )

        question = SingleChoiceQuestion(
            number,
            description,
            parsed_choices,
            correct_answer,
            passing_rate,
            discrimination_index,
        )
        result.append(question)

    return result


def parse_tabular_file(
    file_path: str,
    is_indicator: bool,
) -> dict[CAPSubject, list[str]]:
    doc = Document(file_path)
    pages: list[Page] = list(doc.pages())
    year = int(
        re.search(r"(\d+)年|(\d+) 年", get_text(pages[0], sort=True))
        .group(0)
        .replace("年", "")
        .strip()
    )
    result: dict[CAPSubject, list[str]] = {}

    # R.O.C 108 Curriculum Guidelines.
    new_curriculum_guidelines = year >= 111
    # Each subject has different question number range.
    english_listening_end = 21
    math_end = 26 if year in [106, 107, 108, 109, 110] else 25
    english_reading_end = (
        43 if new_curriculum_guidelines else (40 if year == 104 else 41)
    )
    chinese_end = 43 if new_curriculum_guidelines else 48
    nature_end = 50 if new_curriculum_guidelines else 54

    # Initialize the result dict.
    for subject in CAPSubject:
        result[subject] = []

    table: list[list[str]] = []
    for page in pages:
        page_text: list[str] = get_text(page, sort=True).split("\n")
        last_question_number: int | None = None

        for text in page_text:
            striped_text = text.strip()
            if striped_text == "":
                continue

            is_valid_value = striped_text.isdigit() or striped_text.isascii()

            if re.match(r"^\d+$", striped_text):
                last_question_number = int(striped_text)
            elif is_valid_value and last_question_number is not None:
                if len(table) < last_question_number:
                    table.append([striped_text])
                else:
                    table[last_question_number - 1].append(striped_text)

    def handle_values(_values: list[str], _subjects: list[CAPSubject]):
        for i, _subject in enumerate(_subjects):
            result[_subject].append(_values[i])

    for index, values in enumerate(table):
        # R.O.C 108 Curriculum Guidelines.
        question_number = index + 1

        # Handle question number range.
        if question_number <= english_listening_end:
            subjects = [subject for subject in CAPSubject]

            if is_indicator:
                subjects = [
                    CAPSubject.CHINESE,
                    CAPSubject.ENGLISH_LISTENING,
                    CAPSubject.ENGLISH_Reading,
                    CAPSubject.MATH,
                    CAPSubject.SOCIETY,
                    CAPSubject.NATURE,
                ]

            # Due to the severity of the COVID-19 epidemic in ROC 109 (2020), the English listening exam was suspended.
            # See also: https://cap.rcpet.edu.tw/PressRelease1090422.html
            if year == 109:
                subjects.remove(CAPSubject.ENGLISH_LISTENING)

            handle_values(values, subjects)
        elif question_number <= math_end:
            subjects = [
                CAPSubject.CHINESE,
                CAPSubject.ENGLISH_Reading,
                CAPSubject.MATH,
                CAPSubject.SOCIETY,
                CAPSubject.NATURE,
            ]
            handle_values(values, subjects)
        elif question_number <= english_reading_end:
            subjects = [
                CAPSubject.CHINESE,
                CAPSubject.ENGLISH_Reading,
                CAPSubject.SOCIETY,
                CAPSubject.NATURE,
            ]

            if new_curriculum_guidelines and question_number > 42:
                subjects.remove(CAPSubject.CHINESE)

            handle_values(values, subjects)
        elif question_number <= chinese_end:
            handle_values(
                values, [CAPSubject.CHINESE, CAPSubject.SOCIETY, CAPSubject.NATURE]
            )
        elif question_number <= nature_end:
            handle_values(values, [CAPSubject.SOCIETY, CAPSubject.NATURE])
        else:
            handle_values(values, [CAPSubject.SOCIETY])

    return result


def parse_exam_answer(file_path: str) -> ANSWERS_TYPE:
    # Remove the question number and space.
    parsed_result = parse_tabular_file(file_path, False)
    result = ANSWERS_TYPE({})

    for subject in parsed_result:
        result[subject] = [QuestionAnswer(answer) for answer in parsed_result[subject]]

    return result


def parse_exam_indicator(file_path: str) -> EXAM_INDICATOR:
    """
    Parse the exam indicator file.

    An indicator stands for the passing rate or discrimination index of the question.
    Args:
        file_path: The path of the exam indicator file.

    Returns:
        A dict with the subject as the key and the list of indicators as the value by the order of the question number.
    """
    result = EXAM_INDICATOR({})

    parsed_result = parse_tabular_file(file_path, True)

    for subject in parsed_result:
        result[subject] = []

        for value in parsed_result[subject]:
            # The first question in the English listening exam of the year 112 (2023) is missing an indicator in the exam indicator file.
            if value == "--":
                result[subject].append(None)
            else:
                result[subject].append(float(value))

    return result


def save_parse_result(exams: list[Exam]):
    json_str = json.dumps([exam.to_dict() for exam in exams], ensure_ascii=False)
    with open("temp/cap_exams.json", "w") as f:
        f.write(json_str)


def fix_question_text(text: str) -> str:
    text = re.sub(r"(\w+)\n(\w+)", r"\1\2", text)
    text = re.sub(r"(\w+)\d\n請翻頁繼續作答", r"\1", text)
    text = re.sub(r" \n\d請翻頁繼續作答", r"", text)

    return text.strip()
