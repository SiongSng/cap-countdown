from models.subject_question import SubjectQuestion


class ExamSubject:
    def __init__(
        self,
        name: str,
        duration: int,
        subject_id: str,
        questions: list[SubjectQuestion],
    ):
        self.name = name
        self.duration = duration
        self.subject_id = subject_id
        self.questions = questions

    def to_dict(self):
        return {
            "name": self.name,
            "duration": self.duration,
            "grade_markings": {},
            "subject_id": self.subject_id,
            "questions": [question.to_dict() for question in self.questions],
        }
