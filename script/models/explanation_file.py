from models.cap_subject import CAPSubject
import requests


class ExplanationFile:
    def __init__(self, file_id: str, subject: CAPSubject):
        self.file_id = file_id
        self.subject = subject

    def download(self, path: str):
        url = "https://docs.google.com/uc?export=download"
        session = requests.Session()

        def get_confirm_token(response) -> str | None:
            for key, value in response.cookies.items():
                if key.startswith("download_warning"):
                    return value

            return None

        response = session.get(url, params={"id": self.file_id}, stream=True)
        token = get_confirm_token(response)

        if token:
            params = {"id": id, "confirm": token}
            response = session.get(url, params=params, stream=True)

        with open(path, "wb") as f:
            for chunk in response.iter_content(32768):
                if chunk:
                    f.write(chunk)
