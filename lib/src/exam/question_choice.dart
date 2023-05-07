import 'package:json_annotation/json_annotation.dart';

import 'optional_question.dart';

part 'question_choice.g.dart';

@JsonSerializable()
class QuestionChoice {
  final QuestionAnswer answer;
  final String? description;

  QuestionChoice({
    required this.answer,
    this.description,
  });

  factory QuestionChoice.fromJson(Map<String, dynamic> json) =>
      _$QuestionChoiceFromJson(json);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuestionChoice &&
        other.answer == answer &&
        other.description == description;
  }

  @override
  int get hashCode => Object.hash(answer, description);

  Map<String, dynamic> toJson() => _$QuestionChoiceToJson(this);
}
