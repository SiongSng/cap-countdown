from models.optional_question import OptionalQuestion
from models.subject_question import SubjectQuestion, QuestionType


class GroupChoiceQuestion(SubjectQuestion):
    def __init__(self, description: str | None, image: str | None, options: list[OptionalQuestion]):
        self.description = description
        self.image = image
        self.options = options

    @property
    def question_type(self) -> QuestionType:
        return QuestionType.GROUP_CHOICE

    def to_dict(self) -> dict[str, any]:
        return {
            "type": self.question_type.value,
            "description": self.description,
            "image": self.image,
            "options": [option.to_dict() for option in self.options]
        }
