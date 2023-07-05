from models.optional_question import OptionalQuestion
from models.subject_question import SubjectQuestion, QuestionType


class SingleChoiceQuestion(SubjectQuestion, OptionalQuestion):
    @property
    def question_type(self) -> QuestionType:
        return QuestionType.SINGLE_CHOICE

    def to_dict(self):
        result = {
            "type": self.question_type.value,
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
