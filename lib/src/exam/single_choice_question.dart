import 'package:cap_countdown/src/exam/question_choice.dart';
import 'package:cap_countdown/src/exam/subject_question.dart';
import 'package:json_annotation/json_annotation.dart';

import 'optional_question.dart';

part 'single_choice_question.g.dart';

@JsonSerializable()
class SingleChoiceQuestion extends OptionalQuestion with SubjectQuestion {
  @override
  @JsonKey(includeToJson: true)
  QuestionType get type => QuestionType.singleChoice;

  SingleChoiceQuestion(
      {required super.number,
      super.description,
      super.image,
      required super.passingRate,
      required super.discriminationIndex,
      required super.choices,
      required super.correctAnswer,
      required super.explanation});

  factory SingleChoiceQuestion.fromJson(Map<String, dynamic> json) =>
      _$SingleChoiceQuestionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SingleChoiceQuestionToJson(this);
}
