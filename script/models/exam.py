from models.exam_subject import ExamSubject


class Exam:
    def __init__(self, year: int, name: str, subjects: list[ExamSubject]):
        self.year = year
        self.name = name
        self.subjects = subjects

    def to_dict(self):
        return {
            "year": self.year,
            "name": self.name,
            "subjects": [subject.to_dict() for subject in self.subjects]
        }
