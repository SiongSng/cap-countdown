import 'package:cap_countdown/src/exam/subject_question.dart';
import 'package:json_annotation/json_annotation.dart';

part 'example_question.g.dart';

@JsonSerializable()
class ExampleQuestion extends SubjectQuestion {
  @override
  @JsonKey(includeToJson: true)
  QuestionType get type => QuestionType.example;

  final String? description;
  final String? image;
  final String? audio;

  ExampleQuestion({
    required this.description,
    required this.image,
    required this.audio,
  });

  @override
  Map<String, dynamic> toJson() => _$ExampleQuestionToJson(this);

  factory ExampleQuestion.fromJson(Map<String, dynamic> json) =>
      _$ExampleQuestionFromJson(json);
}
