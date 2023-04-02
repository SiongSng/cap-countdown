import time
from concurrent.futures import ThreadPoolExecutor

from config import *
from models.subject_question import SubjectQuestion
from tools.downloader import *
from tools.parser import parse_exam_paper, save_parse_result, parse_exam_answer, parse_exam_indicator

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

years = [year for year in range(CAP_START_YEAR, CAP_END_YEAR + 1)]
# TODO: Support English Listening.
subjects = [s for s in CAPSubject if s != CAPSubject.ENGLISH_LISTENING]


def download_exam_papers():
    start_time = time.time()

    with ThreadPoolExecutor(max_workers=10) as executor:
        for year in years:
            for subject in subjects:
                executor.submit(download_exam_paper, year, subject)

    elapsed_time = time.time() - start_time
    logger.info(
        f"Finished downloading CAP exam papers in about {elapsed_time:.2f} seconds."
    )


def download_exam_answers_and_indicators():
    start_time = time.time()

    with ThreadPoolExecutor(max_workers=10) as executor:
        for year in years:
            executor.submit(download_exam_answer, year)
            executor.submit(download_exam_passing_rate, year)
            executor.submit(download_exam_discrimination_index, year)

    elapsed_time = time.time() - start_time
    logger.info(
        f"Finished downloading CAP exam answers in about {elapsed_time:.2f} seconds."
    )


def parse_exam_papers():
    start_time = time.time()

    all_questions: list[SubjectQuestion] = []

    for year in years:
        for subject in subjects:
            answers = parse_exam_answer(get_exam_file_path(year, ExamFileType.Answer))
            passing_rate = parse_exam_indicator(get_exam_file_path(year, ExamFileType.Passing_Rate))
            discrimination_index = parse_exam_indicator(get_exam_file_path(year, ExamFileType.DISCRIMINATION_INDEX))
            questions = parse_exam_paper(get_paper_file_path(year, subject), subject, answers, passing_rate,
                                         discrimination_index)

            all_questions.extend(questions)
        logger.info(f"Parsed CAP exam papers for year {year}.")

    save_parse_result(all_questions)

    elapsed_time = time.time() - start_time
    logger.info(f"Finished parsing CAP exam papers in about {elapsed_time:.2f} seconds.")


def start():
    start_time = time.time()

    # Create a directory to store the downloaded files.
    if not os.path.exists("temp"):
        os.makedirs("temp")

    download_exam_papers()
    download_exam_answers_and_indicators()
    parse_exam_papers()

    elapsed_time = time.time() - start_time
    logger.info(f"Finished all tasks in about {elapsed_time:.2f} seconds.")


if __name__ == "__main__":
    start()
