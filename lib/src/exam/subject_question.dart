abstract class SubjectQuestion {
  QuestionType get type;

  Map<String, dynamic> toJson();
}

enum QuestionType {
  /// 單選題
  singleChoice,

  /// 題組
  groupChoice,
}
