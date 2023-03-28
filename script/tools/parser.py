import re

from fitz import Document
from fitz.utils import get_text


def parse_exam_paper(file_path: str):
    doc = Document(file_path)
    page_text: str = ""

    for page_index, page in enumerate(doc.pages()):
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
        if filtered_questions.__len__() + 1 != question_number:
            filtered_questions[filtered_questions.__len__() - 1] += match.group(0)
        else:
            filtered_questions.append(match.group(0))

    for i, q in enumerate(filtered_questions):
        choices_pattern = r'\([A-D]\)[^()]+'

        q_num = re.search(r'^\d+\.', q).group(0)
        q_choices = re.findall(choices_pattern, q)
        q_description = re.sub(choices_pattern, '', q).replace(q_num, '', 1).strip()
        print(f"Question {i + 1}: {q_num} {q_description} {q_choices}")
