import re

import fitz
from fitz import Document, Page
from fitz.utils import get_text

excluded_keywords = ["請翻頁繼續作答"]


def parse_exam_paper(file_path: str):
    doc: Document = fitz.open(file_path)
    pages: list[Page] = doc.pages()
    lines: list[str] = []

    for page_index, page in enumerate(pages):
        if page_index == 0:
            continue

        text = get_text(page, sort=True)
        if text == "":
            continue

        lines.extend(re.split(r'\d+\.', text))

    all_questions = filter_questions(lines)

    for i, q in enumerate(all_questions):
        description = q.split("(A)")[0]
        # q_num = re.search(r'^\d+\.', q).group(0)
        # q_text = re.split(r'^\d+\.\s+', q)[1]
        # q_choices = re.findall(r'\(\w\)[^()]+', q)
        # print(f"Question {i + 1}: {description}")
        print(f"Question {i + 1}: {q}")


def filter_questions(questions: list[str]):
    filtered: list[str] = []

    questions.pop(0)
    additional_information = False

    for question in questions:
        text = question.strip()
        for keyword in excluded_keywords:
            if text.__contains__(keyword):
                text = text.replace(keyword, "")

        if text == "":
            continue

        # if text.__contains__("子規："):
        #     pass

        if text.endswith(""):
            additional_information = True
            filtered.append(text.replace("", ""))
            continue

        if text.__contains__("") or additional_information:
            additional_information = False
            if filtered.__len__() == 0:
                filtered.append(text)
            else:
                filtered[filtered.__len__() - 1] += text
            continue

        filtered.append(text)

    return filtered
