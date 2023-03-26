import os

from config import *
from models.subject import CAPSubject
from tools.downloader import Downloader

special_years = [105, 106, 108, 109]

# Create a directory to store the downloaded files
if not os.path.exists("temp"):
    os.makedirs("temp")

for year in range(CAP_START_YEAR, CAP_END_YEAR + 1):
    for subject in CAPSubject:
        url = f"{CAP_BASE_URL}{year}/{year}P_{subject.value}.pdf"
        if year in special_years:
            url = url.replace(".pdf", "150DPI.pdf")

        file_path = os.path.join("temp", f"{year}_{subject.value}.pdf")
        Downloader.download_file(url, file_path)
