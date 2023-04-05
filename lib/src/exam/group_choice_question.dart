import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'optional_question.dart';
import 'subject_question.dart';

part 'group_choice_question.g.dart';

@JsonSerializable()
class GroupChoiceQuestion extends SubjectQuestion {
  @override
  @JsonKey(includeToJson: true)
  QuestionType get type => QuestionType.groupChoice;
  final String? description;
  final String? image;
  @JsonKey(toJson: _optionsToJson)
  final List<OptionalQuestion> options;

  GroupChoiceQuestion({
    this.description,
    this.image,
    required this.options,
  });

  factory GroupChoiceQuestion.fromJson(Map<String, dynamic> json) =>
      _$GroupChoiceQuestionFromJson(json);

  static List<Map<String, dynamic>> _optionsToJson(
      List<OptionalQuestion> options) {
    return options.map((e) => e.toJson()).toList();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GroupChoiceQuestion &&
        other.type == type &&
        other.description == description &&
        other.image == image &&
        listEquals(other.options, options);
  }

  @override
  int get hashCode => Object.hash(type, description, image, options);

  @override
  Map<String, dynamic> toJson() => _$GroupChoiceQuestionToJson(this);
}
