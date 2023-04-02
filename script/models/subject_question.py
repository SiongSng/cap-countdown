from enum import Enum


class QuestionAnswer(Enum):
    A = "A"
    B = "B"
    C = "C"
    D = "D"


class QuestionChoice:
    def __init__(self, description: str | None, answer: QuestionAnswer):
        self.description = description
        self.answer = answer

    def to_dict(self):
        result = {
            "answer": self.answer.value
        }

        if self.description is not None:
            result["description"] = self.description

        return result


class QuestionType(Enum):
    # 單選題
    SINGLE_CHOICE = "singleChoice"
    # 題組
    Group_CHOICE = "groupChoice"


class SubjectQuestion:
    def __init__(self, number: int, question_type: QuestionType, description: str, choices: list[QuestionChoice],
                 correct_answer: QuestionAnswer, passing_rate: float, discrimination_index: float):
        self.number = number
        self.question_type = question_type
        self.description = description
        self.choices = choices
        self.correct_answer = correct_answer
        self.passing_rate = passing_rate
        self.discrimination_index = discrimination_index

    def to_dict(self):
        return {
            "number": self.number,
            "type": self.question_type.value,
            "description": self.description,
            "choices": [choice.to_dict() for choice in self.choices],
            "correct_answer": self.correct_answer.value,
            "passing_rate": self.passing_rate,
            "discrimination_index": self.discrimination_index
        }
