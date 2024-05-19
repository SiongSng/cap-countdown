from models.cap_subject import CAPSubject
from models.explanation_file import ExplanationFile

CAP_BASE_URL: str = "https://cap.rcpet.edu.tw/exam/"
CAP_START_YEAR: int = 104
CAP_END_YEAR: int = 113

CAP_EXPLANATION_FILES: dict[int, list[ExplanationFile]] = {
    112: [
        ExplanationFile(
            file_id="1dxpLuVA8X-9wMv5iK_K2c8AmfZ0Pgz9D",
            subject=CAPSubject.CHINESE,
        ),
        ExplanationFile(
            file_id="1SDTOVNmX3UqJIXiRZiKxh7Pl9f0me5Fg",
            subject=CAPSubject.ENGLISH_Reading,
        ),
        ExplanationFile(
            file_id="1oO4j39xfMMracV5jT4HNmXTsZEpW7XGU",
            subject=CAPSubject.MATH,
        ),
        ExplanationFile(
            file_id="1QSjEnBstAA2fCZ7u9wdICHw7FvhgywkB",
            subject=CAPSubject.SOCIETY,
        ),
        ExplanationFile(
            file_id="1jcAH0HTMyvSH9QXSyANq6upNuU-AdGBh",
            subject=CAPSubject.NATURE,
        ),
    ]
}
