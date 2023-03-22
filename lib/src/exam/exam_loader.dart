import 'dart:convert';
import 'dart:math';

import 'package:cap_countdown/src/exam/exam.dart';
import 'package:cap_countdown/src/exam/subject_question.dart';
import 'package:flutter/services.dart';

class ExamLoader {
  static late final List<Exam> exams;

  static Future<void> load() async {
    final jsonString = await rootBundle.loadString('assets/exams.json');
    final Map json = jsonDecode(jsonString);
    final List<Map<String, dynamic>> examsJson =
        json['exams'].cast<Map<String, dynamic>>();

    exams = examsJson.map((e) => Exam.fromJson(e)).toList().cast<Exam>();
  }

  static SubjectQuestion getRandomQuestion() {
    final allQuestions =
        exams.expand((e) => e.subjects.expand((s) => s.questions)).toList();
    final index = Random().nextInt(allQuestions.length);

    return allQuestions[index];
  }
}
