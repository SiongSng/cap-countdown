from enum import Enum


class CAPSubject(Enum):
    CHINESE = "Chinese"
    ENGLISH_Reading = "English"
    ENGLISH_LISTENING = "Listening"
    MATH = "Math"
    NATURE = "Nature"
    SOCIETY = "Society"

    def get_chinese_name(self) -> str:
        match self:
            case self.CHINESE:
                return "國文科"
            case self.ENGLISH_Reading:
                return "英文科 (閱讀)"
            case self.ENGLISH_LISTENING:
                return "英文科 (聽力)"
            case self.MATH:
                return "數學科"
            case self.NATURE:
                return "自然科"
            case self.SOCIETY:
                return "社會科"
