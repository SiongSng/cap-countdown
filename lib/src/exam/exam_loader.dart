import 'dart:convert';
import 'dart:math';

import 'package:cap_countdown/src/exam/exam.dart';
import 'package:cap_countdown/src/exam/example_question.dart';
import 'package:cap_countdown/src/exam/subject_question.dart';
import 'package:flutter/services.dart';

class ExamLoader {
  static late final List<Exam> exams;

  static Future<void> load() async {
    final jsonString = await rootBundle.loadString('assets/cap_exams.json');
    final List json = jsonDecode(jsonString);

    exams = json.map((e) => Exam.fromJson(e)).toList().cast<Exam>();
  }

  static List<SubjectQuestion> _getAllQuestions() {
    return exams.expand((e) => e.subjects.expand((s) => s.questions)).toList();
  }

  static SubjectQuestion getRandomQuestion() {
    final allQuestions =
        _getAllQuestions().where((q) => q is! ExampleQuestion).toList();
    final index = Random().nextInt(allQuestions.length);

    return allQuestions[index];
  }

  static SubjectQuestion? getQuestionByHash(String hash) {
    try {
      return _getAllQuestions().firstWhere((q) => q.hash == hash);
    } on StateError {
      return null;
    }
  }
}
