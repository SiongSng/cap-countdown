from models.subject_question import SubjectQuestion


class ExamSubject:
    def __init__(self, name: str, questions: list[SubjectQuestion]):
        self.name = name
        self.questions = questions

    def to_dict(self):
        return {
            "name": self.name,
            "questions": [question.to_dict() for question in self.questions]
        }
