import 'package:json_annotation/json_annotation.dart';

import 'package:cap_countdown/src/exam/question_choice.dart';

part 'subject_question.g.dart';

@JsonSerializable()
class SubjectQuestion {
  final int index;
  final QuestionType type;
  final String? description;
  final String? image;
  @JsonKey(name: 'passing_rate')
  final double passingRate;
  @JsonKey(name: 'discrimination')
  final double discrimination;
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
    required this.passingRate,
    required this.discrimination,
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
