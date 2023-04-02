from models.exam_subject import ExamSubject


class Exam:
    def __init__(self, name: str, subjects: list[ExamSubject]):
        self.name = name
        self.subjects = subjects

    def to_dict(self):
        return {
            "name": self.name,
            "subjects": [subject.to_dict() for subject in self.subjects]
        }
