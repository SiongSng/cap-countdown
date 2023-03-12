import 'package:cap_countdown/exam/question_choice.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subject_question.g.dart';

@JsonSerializable()
class SubjectQuestion {
  final int index;
  final QuestionType type;
  final String? description;
  final String? image;
  final List<QuestionChoice> choices;
  @JsonKey(name: 'correct_answer')
  final QuestionAnswer correctAnswer;
  final String explanation;

  @JsonKey(includeFromJson: false, includeToJson: false)
  QuestionChoice? selectedChoice;

  SubjectQuestion({
    required this.index,
    required this.type,
    this.description,
    this.image,
    required this.choices,
    required this.correctAnswer,
    required this.explanation,
  });

  factory SubjectQuestion.fromJson(Map<String, dynamic> json) =>
      _$SubjectQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectQuestionToJson(this);
}

enum QuestionType {
  /// 單選題
  singleChoice,

  /// 題組
  groupChoice,
}

enum QuestionAnswer { A, B, C, D }
