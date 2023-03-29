import json
import re

from fitz import Document, Page
from fitz.utils import get_text

from models.subject_question import SubjectQuestion, QuestionType, QuestionChoice, QuestionAnswer


# TODO: Support image and table parsing
def parse_exam_paper(file_path: str) -> list[SubjectQuestion]:
    doc = Document(file_path)
    pages: list[Page] = doc.pages()
    page_text: str = ""

    for page_index, page in enumerate(pages):
        # Skip the CAP exam instructions page
        if page_index == 0:
            continue

        page_text += get_text(page, sort=True)

    matches = re.finditer(r'(\d+)\..*?(?=\d+\.|試題結束)', page_text, flags=re.DOTALL)

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
        choices_pattern = r'\([A-D]\)[^()]+'

        q_num = re.search(r'^\d+\.', q).group(0).replace('.', '')
        q_choices: list[str] = re.findall(choices_pattern, q)
        q_description = fix_text(re.sub(choices_pattern, '', q).replace(q_num, '', 1).replace('.', '', 1))

        choices: list[QuestionChoice] = []

        for choice in q_choices:
            description = fix_text(re.sub(r'\([A-D]\)', '', choice))
            answer = re.search(r'\([A-D]\)', choice).group(0).replace('(', '').replace(')', '')
            choices.append(QuestionChoice(description, QuestionAnswer(answer)))

        questions.append(SubjectQuestion(int(q_num), QuestionType.SINGLE_CHOICE, q_description, choices))

    return questions


def save_parse_result(questions: list[SubjectQuestion]):
    json_str = json.dumps([q.to_dict() for q in questions], ensure_ascii=False)
    with open("temp/cap_exams.json", "w") as f:
        f.write(json_str)


def fix_text(text: str) -> str:
    text = re.sub(r'(\w+)\n(\w+)', r'\1\2', text)
    text = re.sub(r'(\w+)\d\n請翻頁繼續作答', r'\1', text)
    text = re.sub(r' \n\d請翻頁繼續作答', r'', text)

    return text.strip()
