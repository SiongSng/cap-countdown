import 'package:cap_countdown/src/exam/subject_question.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'optional_question.dart';
import 'question_choice.dart';

part 'single_choice_question.g.dart';

@JsonSerializable()
class SingleChoiceQuestion extends OptionalQuestion with SubjectQuestion {
  @override
  @JsonKey(includeToJson: true)
  QuestionType get type => QuestionType.singleChoice;

  SingleChoiceQuestion(
      {required super.number,
      super.description,
      super.audio,
      super.image,
      required super.passingRate,
      required super.discriminationIndex,
      required super.choices,
      required super.correctAnswer,
      required super.explanation});

  factory SingleChoiceQuestion.fromJson(Map<String, dynamic> json) =>
      _$SingleChoiceQuestionFromJson(json);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SingleChoiceQuestion &&
        other.type == type &&
        other.number == number &&
        other.description == description &&
        other.image == image &&
        other.passingRate == passingRate &&
        other.discriminationIndex == discriminationIndex &&
        listEquals(other.choices, choices) &&
        other.correctAnswer == correctAnswer &&
        other.explanation == explanation;
  }

  @override
  int get hashCode =>
      type.hashCode ^
      number.hashCode ^
      description.hashCode ^
      image.hashCode ^
      passingRate.hashCode ^
      discriminationIndex.hashCode ^
      choices.hashCode ^
      correctAnswer.hashCode ^
      explanation.hashCode;

  @override
  Map<String, dynamic> toJson() => _$SingleChoiceQuestionToJson(this);
}
