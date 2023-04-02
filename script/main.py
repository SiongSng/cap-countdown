import time
from concurrent.futures import ThreadPoolExecutor

from config import *
from models.exam import Exam
from models.exam_subject import ExamSubject
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

    exams: list[Exam] = []

    for year in years:
        exam_subjects: list[ExamSubject] = []

        for subject in subjects:
            answers = parse_exam_answer(get_exam_file_path(year, ExamFileType.Answer))
            passing_rate = parse_exam_indicator(get_exam_file_path(year, ExamFileType.Passing_Rate))
            discrimination_index = parse_exam_indicator(get_exam_file_path(year, ExamFileType.DISCRIMINATION_INDEX))
            questions = parse_exam_paper(get_paper_file_path(year, subject), subject, answers, passing_rate,
                                         discrimination_index)

            exam_subjects.append(ExamSubject(subject.get_chinese_name(), questions))

        exam = Exam(f"{year} 年國中教育會考", exam_subjects)
        exams.append(exam)
        logger.info(f"Parsed CAP exam papers for year {year}.")

    save_parse_result(exams)

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
