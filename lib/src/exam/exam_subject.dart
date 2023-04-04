import 'package:cap_countdown/src/exam/group_choice_question.dart';
import 'package:cap_countdown/src/exam/optional_question.dart';
import 'package:cap_countdown/src/exam/subject_question.dart';
import 'package:json_annotation/json_annotation.dart';

import 'single_choice_question.dart';

part 'exam_subject.g.dart';

@JsonSerializable(createFactory: false)
class ExamSubject {
  final String name;

  // Each exam has a different test time, and you can't continue to answer when the time is up.
  final Duration duration;

  @JsonKey(name: 'grade_markings')
  final Map<String, double> gradeMarkings;

  @JsonKey(toJson: _questionsToJson)
  final List<SubjectQuestion> questions;

  ExamSubject({
    required this.name,
    required this.duration,
    required this.gradeMarkings,
    required this.questions,
  });

  static List<Map<String, dynamic>> _questionsToJson(
      List<SubjectQuestion> questions) {
    return questions.map((e) => e.toJson()).toList();
  }

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
      duration: Duration(minutes: json['duration'] as int),
      gradeMarkings: (json['grade_markings'] as Map<String, dynamic>).map(
          (key, value) =>
              MapEntry(key, value is int ? value.toDouble() : value as double)),
      questions: subjectQuestions.cast<SubjectQuestion>(),
    );
  }

  Map<String, dynamic> toJson() => _$ExamSubjectToJson(this);

  /// Get all optional questions in this subject.
  List<OptionalQuestion> getOptionalQuestions() {
    final singleChoiceQuestions =
        questions.whereType<SingleChoiceQuestion>().toList();
    final groupChoiceQuestions =
        questions.whereType<GroupChoiceQuestion>().toList();

    final optionalQuestions = <OptionalQuestion>[];

    optionalQuestions.addAll(singleChoiceQuestions);
    optionalQuestions.addAll(groupChoiceQuestions.expand((e) => e.options));

    return optionalQuestions;
  }

  /// Clear all selected choices.
  void clearRecords() {
    for (final question in getOptionalQuestions()) {
      question.selectedChoice = null;
    }
  }
}