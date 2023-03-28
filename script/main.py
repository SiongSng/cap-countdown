import logging
import os
import time
from concurrent.futures import ThreadPoolExecutor

from config import *
from models.subject import CAPSubject
from tools.downloader import download_exam_paper, get_file_path
from tools.parser import parse_exam_paper

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


def download_exam_papers():
    start_time = time.time()

    # Create a directory to store the downloaded files
    if not os.path.exists("temp"):
        os.makedirs("temp")

    with ThreadPoolExecutor() as executor:
        years = [year for year in range(CAP_START_YEAR, CAP_END_YEAR + 1)]
        subjects = CAPSubject.__members__.values()
        executor.map(download_exam_paper, years, subjects)

    elapsed_time = time.time() - start_time
    logger.info(
        f"Finished downloading CAP exam papers in about {elapsed_time:.2f} seconds."
    )


def parse_exam_papers():
    start_time = time.time()

    parse_exam_paper(get_file_path(111, CAPSubject.CHINESE))
    # for year in range(CAP_START_YEAR, CAP_END_YEAR + 1):
    #     for subject in CAPSubject:
    #         parse_exam_paper(get_file_path(year, subject))

    elapsed_time = time.time() - start_time
    logger.info(f"Finished parsing CAP exam papers in about {elapsed_time:.2f} seconds.")


if __name__ == "__main__":
    # download_exam_papers()
    parse_exam_papers()
