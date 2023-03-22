import 'package:cap_countdown/src/exam/subject_question.dart';
import 'package:json_annotation/json_annotation.dart';

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

  Map<String, dynamic> toJson() => _$QuestionChoiceToJson(this);
}
