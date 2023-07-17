import 'dart:convert';

import 'package:cap_countdown/main.dart';
import 'package:cap_countdown/src/exam/question_record.dart';
import 'package:cap_countdown/src/exam/question_rich_content.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'question_choice.dart';

part 'optional_question.g.dart';

@JsonSerializable(explicitToJson: true)
class OptionalQuestion {
  final int number;
  final String? description;
  final String? image;

  final String? audio;
  @JsonKey(name: 'passing_rate')
  final double? passingRate;
  @JsonKey(name: 'discrimination_index')
  final double? discriminationIndex;
  final List<QuestionChoice> choices;
  @JsonKey(name: 'correct_answer')
  final QuestionAnswer correctAnswer;
  final String? explanation;
  @JsonKey(name: 'explanation_image')
  final String? explanationImage;
  @JsonKey(name: 'rich_content')
  final List<QuestionRichContent>? richContents;

  @JsonKey(includeFromJson: false, includeToJson: false)
  QuestionChoice? selectedChoice;

  @JsonKey(includeFromJson: false, includeToJson: false)
  List<bool> crossOutItems = [];

  OptionalQuestion({
    required this.number,
    this.description,
    this.image,
    this.richContents,
    this.audio,
    required this.passingRate,
    required this.discriminationIndex,
    required this.choices,
    required this.correctAnswer,
    this.explanation,
    this.explanationImage,
  }) {
    crossOutItems = List.generate(choices.length, (_) => false);
  }

  bool get isCorrect => correctAnswer == selectedChoice?.answer;

  void makeAsAnswered() {
    final selectedAnswer = selectedChoice?.answer;
    if (selectedAnswer == null) return;

    final records = localStorage.questionRecords;

    QuestionRecord? record = records[hash];
    final history = AnswerHistory(
        date: DateTime.now(),
        selectedAnswer: selectedAnswer,
        isCorrect: isCorrect);

    if (record != null) {
      record =
          record.copyWith(answerHistory: record.answerHistory..add(history));
      records[hash] = record;
      return;
    }

    records[hash] = QuestionRecord(answerHistory: [history]);

    localStorage.questionRecords = records;
  }

  bool get isAnswered => localStorage.questionRecords.containsKey(hash);

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
          explanation == other.explanation &&
          explanationImage == other.explanationImage &&
          listEquals(richContents, other.richContents);

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
      explanation.hashCode ^
      explanationImage.hashCode ^
      richContents.hashCode;
}

enum QuestionAnswer { A, B, C, D }
