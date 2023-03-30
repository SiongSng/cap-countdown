import logging
import os
import time
from concurrent.futures import ThreadPoolExecutor

from config import *
from models.subject import CAPSubject
from models.subject_question import SubjectQuestion
from tools.downloader import download_exam_paper, get_paper_file_path, download_exam_answer
from tools.parser import parse_exam_paper, save_parse_result

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


def download_exam_papers():
    start_time = time.time()

    with ThreadPoolExecutor(max_workers=10) as executor:
        years = [year for year in range(CAP_START_YEAR, CAP_END_YEAR + 1)]
        for year in years:
            for subject in CAPSubject:
                executor.submit(download_exam_paper, year, subject)

    elapsed_time = time.time() - start_time
    logger.info(
        f"Finished downloading CAP exam papers in about {elapsed_time:.2f} seconds."
    )


def download_exam_answers():
    start_time = time.time()

    with ThreadPoolExecutor(max_workers=10) as executor:
        years = [year for year in range(CAP_START_YEAR, CAP_END_YEAR + 1)]
        for year in years:
            executor.submit(download_exam_answer, year)

    elapsed_time = time.time() - start_time
    logger.info(
        f"Finished downloading CAP exam answers in about {elapsed_time:.2f} seconds."
    )


def parse_exam_papers():
    start_time = time.time()

    all_questions: list[SubjectQuestion] = []

    for year in range(CAP_START_YEAR, CAP_END_YEAR + 1):
        for subject in CAPSubject:
            questions = parse_exam_paper(get_paper_file_path(year, subject))
            all_questions.extend(questions)
        logger.info(f"Parsed CAP exam papers for year {year}.")

    save_parse_result(all_questions)

    elapsed_time = time.time() - start_time
    logger.info(f"Finished parsing CAP exam papers in about {elapsed_time:.2f} seconds.")


if __name__ == "__main__":
    # Create a directory to store the downloaded files
    if not os.path.exists("temp"):
        os.makedirs("temp")

    download_exam_papers()
    download_exam_answers()
    parse_exam_papers()
