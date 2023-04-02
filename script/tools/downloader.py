import logging
import os

import requests

from config import CAP_BASE_URL
from models.cap_subject import CAPSubject
from models.file_type import ExamFileType

logger = logging.getLogger(__name__)


def __download_file(url: str, file_path: str, retry: int = 0):
    """
    Download a file from the given URL.
    Args:
        url: The URL of the file to download.
        file_path: The path to save the downloaded file.
        retry:  The number of retries to download the file. It will retry 3 times at most.
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
        year (int): The R.O.C year of the exam paper to download.
        subject (CAPSubject): The subject of the exam paper to download.
    """
    logger.info(f"Downloading the {subject.value.lower()} exam paper ({year})...")
    special_years = [105, 106, 108, 109]

    url = f"{CAP_BASE_URL}{year}/{year}P_{subject.value}.pdf"
    if year in special_years:
        url = url.replace(".pdf", "150DPI.pdf")

    __download_file(url, get_paper_file_path(year, subject))


def download_exam_answer(year: int):
    """
    Download the CAP exam answer file for a given year.

    Args:
        year (int): The R.O.C year of the file to download.
    """
    logger.info(f"Downloading the exam answer file ({year})...")

    url = f"{CAP_BASE_URL}{year}/{year}P_Answer.pdf"

    __download_file(url, get_exam_file_path(year, ExamFileType.Answer))


def download_exam_passing_rate(year: int):
    """
    Download the CAP exam passing rate file for a given year.

    Args:
        year (int): The R.O.C year of the file to download.
    """
    logger.info(f"Downloading the exam passing rate file ({year})...")

    url = f"{CAP_BASE_URL}{year}/{year}各科通過率.pdf"
    if year <= 106:
        url = url.replace("各科通過率", "年國中教育會考各題通過率")

    __download_file(url, get_exam_file_path(year, ExamFileType.Passing_Rate))


def download_exam_discrimination_index(year: int):
    """
    Download the CAP exam discrimination index file for a given year.

    Args:
        year (int): The R.O.C year of the file to download.
    """
    logger.info(f"Downloading the exam discrimination index file ({year})...")

    url = f"{CAP_BASE_URL}{year}/{year}各科鑑別度.pdf"
    if year <= 106:
        url = url.replace("各科鑑別度", "年國中教育會考各題鑑別度")

    __download_file(url, get_exam_file_path(year, ExamFileType.DISCRIMINATION_INDEX))


def get_paper_file_path(year: int, subject: CAPSubject):
    return os.path.join("temp", f"{year}_{subject.value}.pdf")


def get_exam_file_path(year: int, file_type: ExamFileType):
    """
    Get the path of the various exam files.

    Args:
        year (int): The R.O.C year of the file.
        file_type (ExamFileType): The type of the file to get the path.
    """
    return os.path.join("temp", f"{year}_{file_type.value.title()}.pdf")
