import logging
import os
import requests

from config import CAP_BASE_URL
from models.subject import CAPSubject

logger = logging.getLogger(__name__)


def __download_file(url: str, file_path: str, retry: int = 0):
    """
    Download a file from a URL and save it to a local file path.

    Args:
        url (str): The URL of the file to download.
        file_path (str): The local file path to save the downloaded file.
        retry (int): The number of times to retry downloading the file if it fails.
    """
    if retry > 3:
        print("Failed to download the file after 3 retries: " + url)
        return

    response = requests.get(url)
    if response.status_code != 200:
        return __download_file(url.replace(".pdf", "-2.pdf"), file_path, retry + 1)

    with open(file_path, "wb") as f:
        f.write(response.content)


def download_exam_paper(year: int, subject: CAPSubject):
    """
    Download the CAP exam paper for a given year and subject.

    Args:
        year (int): The ROC year of the exam paper to download.
        subject (CAPSubject): The subject of the exam paper to download.
    """
    logger.info(f"Downloading the {subject.value.lower()} exam paper({year})...")
    special_years = [105, 106, 108, 109]

    url = f"{CAP_BASE_URL}{year}/{year}P_{subject.value}.pdf"
    if year in special_years:
        url = url.replace(".pdf", "150DPI.pdf")

    file_path = os.path.join("temp", f"{year}_{subject.value}.pdf")
    __download_file(url, file_path)
