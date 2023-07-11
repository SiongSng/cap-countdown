import abc
import enum


class QuestionType(enum.Enum):
    # 單選題
    SINGLE_CHOICE = "singleChoice"
    # 題組
    GROUP_CHOICE = "groupChoice"


class SubjectQuestion(abc.ABC):
    @property
    @abc.abstractmethod
    def question_type(self) -> QuestionType:
        pass

    @abc.abstractmethod
    def to_dict(
        self,
    ) -> dict[str, str | int | float | list[dict[str, str | int | float]] | None]:
        pass
