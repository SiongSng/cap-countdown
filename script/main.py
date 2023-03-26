from concurrent.futures import ThreadPoolExecutor
import logging
import os
import time

from config import *
from models.subject import CAPSubject
from tools.downloader import download_exam_paper

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


if __name__ == "__main__":
    start_time = time.time()

    # Create a directory to store the downloaded files
    if not os.path.exists("temp"):
        os.makedirs("temp")

    with ThreadPoolExecutor() as executor:
        for year in range(CAP_START_YEAR, CAP_END_YEAR + 1):
            for subject in CAPSubject:
                executor.submit(download_exam_paper, year, subject)

    spent_time = time.time() - start_time
    logger.info(
        f"Finished downloading CAP exam papers in about {spent_time:.2f} seconds."
    )
