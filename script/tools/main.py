import os
import requests

base_url = "https://cap.rcpet.edu.tw/exam/"

start_year = 103
end_year = 111
special_years = [105, 106, 108, 109]
subjects = ["Chinese", "English", "Nature", "Society", "Math"]


def download_file(url: str, file_path: str, retry: int = 0):
    if retry > 3:
        print("Failed to download the file after 3 retries: " + url)
        return

    response = requests.get(url)
    if response.status_code != 200:
        return download_file(url.replace(".pdf", "-2.pdf"), file_path, retry + 1)

    with open(file_path, "wb") as f:
        f.write(response.content)


# Create a directory to store the downloaded files
if not os.path.exists("temp"):
    os.makedirs("temp")

for year in range(start_year, end_year + 1):
    for subject in subjects:
        if year in special_years:
            url = f"{base_url}{year}/{year}P_{subject}150DPI.pdf"
        else:
            url = f"{base_url}{year}/{year}P_{subject}.pdf"

        file_path = os.path.join("temp", str(year) + "_" + subject + ".pdf")

        download_file(url, file_path)
