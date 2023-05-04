import 'dart:convert';

import 'package:cap_countdown/main.dart';
import 'package:cap_countdown/src/exam/question_meta.dart';
import 'package:crypto/crypto.dart';

import 'exam_loader.dart';
import 'example_question.dart';
import 'group_choice_question.dart';
import 'single_choice_question.dart';

abstract mixin class SubjectQuestion {
  QuestionType get type;

  Map<String, dynamic> toJson();

  void addToFavorite() {
    final questions = localStorage.favoriteQuestions;
    questions.add(this);
    localStorage.favoriteQuestions = questions;
  }

  void removeFromFavorite() {
    final questions = localStorage.favoriteQuestions;
    questions.remove(this);
    localStorage.favoriteQuestions = questions;
  }

  String get questionNumber {
    final question = this;
    final String questionNumber;

    if (question is SingleChoiceQuestion) {
      questionNumber = question.number.toString();
    } else if (question is GroupChoiceQuestion) {
      questionNumber =
          '${question.options.first.number}~${question.options.last.number}';
    } else if (question is ExampleQuestion) {
      questionNumber = '示例題';
    } else {
      throw Exception('Unknown question type');
    }

    return questionNumber;
  }

  QuestionMeta get meta {
    final exams = ExamLoader.exams;
    final subject = exams
        .expand((e) => e.subjects)
        .firstWhere((s) => s.questions.contains(this));

    final exam = exams.firstWhere((e) => e.subjects.contains(subject));
    final int questionIndex = subject.questions.indexOf(this);

    return QuestionMeta(
        year: exam.year,
        subjectId: subject.subjectId,
        questionIndex: questionIndex,
        questionNumber: questionNumber);
  }

  String get hash {
    var bytes = utf8.encode(toJson().toString());
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubjectQuestion && other.type == type;
  }

  @override
  int get hashCode => type.hashCode;

  static SubjectQuestion fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;

    switch (type) {
      case 'singleChoice':
        return SingleChoiceQuestion.fromJson(json);
      case 'groupChoice':
        return GroupChoiceQuestion.fromJson(json);
      case 'example':
        return ExampleQuestion.fromJson(json);
      default:
        throw Exception('Unknown question type: $type');
    }
  }
}

enum QuestionType {
  /// 單選題
  singleChoice,

  /// 題組
  groupChoice,

  /// 示例題（英文聽力）
  example
}
