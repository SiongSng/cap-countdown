import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'optional_question.dart';
import 'subject_question.dart';
import 'question_rich_content.dart';

part 'group_choice_question.g.dart';

@JsonSerializable(explicitToJson: true)
class GroupChoiceQuestion extends SubjectQuestion {
  @override
  @JsonKey(includeToJson: true)
  QuestionType get type => QuestionType.groupChoice;
  final String? description;
  final String? image;
  final List<OptionalQuestion> options;
  @JsonKey(name: 'rich_content')
  final List<QuestionRichContent>? richContents;

  GroupChoiceQuestion({
    this.description,
    this.image,
    this.richContents,
    required this.options,
  });

  factory GroupChoiceQuestion.fromJson(Map<String, dynamic> json) =>
      _$GroupChoiceQuestionFromJson(json);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GroupChoiceQuestion &&
        other.type == type &&
        other.description == description &&
        other.image == image &&
        listEquals(other.richContents, richContents) &&
        listEquals(other.options, options);
  }

  @override
  int get hashCode =>
      Object.hash(type, description, image, richContents, options);

  @override
  Map<String, dynamic> toJson() => _$GroupChoiceQuestionToJson(this);
}
