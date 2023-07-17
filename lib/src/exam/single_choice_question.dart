import 'package:cap_countdown/src/exam/subject_question.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'optional_question.dart';
import 'question_choice.dart';
import 'question_rich_content.dart';

part 'single_choice_question.g.dart';

@JsonSerializable(explicitToJson: true)
class SingleChoiceQuestion extends OptionalQuestion with SubjectQuestion {
  @override
  @JsonKey(includeToJson: true)
  QuestionType get type => QuestionType.singleChoice;

  SingleChoiceQuestion(
      {required super.number,
      super.description,
      super.audio,
      super.image,
      super.richContents,
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
        listEquals(other.richContents, richContents) &&
        other.passingRate == passingRate &&
        other.discriminationIndex == discriminationIndex &&
        listEquals(other.choices, choices) &&
        other.correctAnswer == correctAnswer &&
        other.explanation == explanation;
  }

  @override
  int get hashCode => Object.hash(
      type,
      number,
      description,
      image,
      richContents,
      passingRate,
      discriminationIndex,
      choices,
      correctAnswer,
      explanation);

  @override
  Map<String, dynamic> toJson() => _$SingleChoiceQuestionToJson(this);
}
