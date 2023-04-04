import 'package:json_annotation/json_annotation.dart';

import 'question_choice.dart';

part 'optional_question.g.dart';

@JsonSerializable()
class OptionalQuestion {
  final int number;
  final String? description;
  final String? image;
  final String? audio;
  @JsonKey(name: 'passing_rate')
  final double passingRate;
  @JsonKey(name: 'discrimination_index')
  final double discriminationIndex;
  @JsonKey(
      fromJson: QuestionChoice.choicesFromJson,
      toJson: QuestionChoice.choicesToJson)
  final List<QuestionChoice> choices;
  @JsonKey(name: 'correct_answer')
  final QuestionAnswer correctAnswer;
  final String? explanation;

  @JsonKey(includeFromJson: false, includeToJson: false)
  QuestionChoice? selectedChoice;

  OptionalQuestion({
    required this.number,
    this.description,
    this.image,
    this.audio,
    required this.passingRate,
    required this.discriminationIndex,
    required this.choices,
    required this.correctAnswer,
    this.explanation,
  });

  bool get isCorrect => correctAnswer == selectedChoice?.answer;

  factory OptionalQuestion.fromJson(Map<String, dynamic> json) =>
      _$OptionalQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$OptionalQuestionToJson(this);
}

enum QuestionAnswer { A, B, C, D }
