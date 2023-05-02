import 'dart:convert';

import 'package:cap_countdown/main.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
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

  void makeAsAnswered() {
    final questions = localStorage.answeredQuestions;
    questions.add(hash);
    localStorage.answeredQuestions = questions.toSet().toList();
  }

  bool get isAnswered => localStorage.answeredQuestions.contains(hash);

  String get hash {
    var bytes = utf8.encode(toJson().toString());
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  factory OptionalQuestion.fromJson(Map<String, dynamic> json) =>
      _$OptionalQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$OptionalQuestionToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OptionalQuestion &&
          runtimeType == other.runtimeType &&
          number == other.number &&
          description == other.description &&
          image == other.image &&
          audio == other.audio &&
          passingRate == other.passingRate &&
          discriminationIndex == other.discriminationIndex &&
          listEquals(choices, other.choices) &&
          correctAnswer == other.correctAnswer &&
          explanation == other.explanation;

  @override
  int get hashCode =>
      number.hashCode ^
      description.hashCode ^
      image.hashCode ^
      audio.hashCode ^
      passingRate.hashCode ^
      discriminationIndex.hashCode ^
      choices.hashCode ^
      correctAnswer.hashCode ^
      explanation.hashCode;
}

enum QuestionAnswer { A, B, C, D }
