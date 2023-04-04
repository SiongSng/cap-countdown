import 'package:cap_countdown/main.dart';

import 'example_question.dart';
import 'group_choice_question.dart';
import 'single_choice_question.dart';

abstract class SubjectQuestion {
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
