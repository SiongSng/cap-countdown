import requests


class Downloader:
    @staticmethod
    def download_file(url: str, file_path: str, retry: int = 0):
        if retry > 3:
            print("Failed to download the file after 3 retries: " + url)
            return

        response = requests.get(url)
        if response.status_code != 200:
            return Downloader.download_file(
                url.replace(".pdf", "-2.pdf"), file_path, retry + 1
            )

        with open(file_path, "wb") as f:
            f.write(response.content)
