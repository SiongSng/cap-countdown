import 'package:cap_countdown/src/exam/group_choice_question.dart';
import 'package:cap_countdown/src/exam/subject_question.dart';
import 'package:json_annotation/json_annotation.dart';

import 'single_choice_question.dart';

part 'exam_subject.g.dart';

@JsonSerializable(createFactory: false)
class ExamSubject {
  final String name;

  @JsonKey(toJson: _questionsToJson)
  final List<SubjectQuestion> questions;

  ExamSubject({
    required this.name,
    required this.questions,
  });

  factory ExamSubject.fromJson(Map<String, dynamic> json) {
    final questions = json['questions'] as List<dynamic>;
    final subjectQuestions = questions.map((question) {
      final type = question['type'] as String;

      switch (type) {
        case 'singleChoice':
          return SingleChoiceQuestion.fromJson(question);
        case 'groupChoice':
          return GroupChoiceQuestion.fromJson(question);
        default:
          throw Exception('Unknown question type: $type');
      }
    }).toList();

    return ExamSubject(
      name: json['name'] as String,
      questions: subjectQuestions.cast<SubjectQuestion>(),
    );
  }

  static List<Map<String, dynamic>> _questionsToJson(
      List<SubjectQuestion> questions) {
    return questions.map((e) => e.toJson()).toList();
  }

  Map<String, dynamic> toJson() => _$ExamSubjectToJson(this);
}
