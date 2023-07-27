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
        result = {"answer": self.answer.value}

        if self.description is not None:
            result["description"] = self.description

        return result


class OptionalQuestion:
    def __init__(
        self,
        number: int,
        description: str,
        choices: list[QuestionChoice],
        correct_answer: QuestionAnswer,
        passing_rate: float | None,
        discrimination_index: float | None,
        explanation: str | None,
    ):
        self.number = number
        self.description = description
        self.choices = choices
        self.correct_answer = correct_answer
        self.passing_rate = passing_rate
        self.discrimination_index = discrimination_index
        self.explanation = explanation

    def to_dict(self):
        result = {
            "number": self.number,
            "description": self.description,
            "passing_rate": self.passing_rate,
            "discrimination_index": self.discrimination_index,
            "choices": [choice.to_dict() for choice in self.choices],
            "correct_answer": self.correct_answer.value,
        }

        if self.explanation is not None:
            result["explanation"] = self.explanation

        return result
