import 'package:json_annotation/json_annotation.dart';

import 'optional_question.dart';
import 'subject_question.dart';

part 'group_choice_question.g.dart';

@JsonSerializable()
class GroupChoiceQuestion extends SubjectQuestion {
  @override
  @JsonKey(includeToJson: true)
  QuestionType get type => QuestionType.singleChoice;
  final String? description;
  final String? image;
  final List<OptionalQuestion> options;

  GroupChoiceQuestion({
    this.description,
    this.image,
    required this.options,
  });

  factory GroupChoiceQuestion.fromJson(Map<String, dynamic> json) =>
      _$GroupChoiceQuestionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GroupChoiceQuestionToJson(this);
}
