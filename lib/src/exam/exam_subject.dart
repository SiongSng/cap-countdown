import 'package:cap_countdown/src/exam/cap_subject.dart';
import 'package:cap_countdown/src/exam/group_choice_question.dart';
import 'package:cap_countdown/src/exam/optional_question.dart';
import 'package:cap_countdown/src/exam/subject_question.dart';
import 'package:json_annotation/json_annotation.dart';

import 'single_choice_question.dart';

part 'exam_subject.g.dart';

@JsonSerializable(explicitToJson: true)
class ExamSubject {
  final String name;

  // Each exam has a different test time, and you can't continue to answer when the time is up.
  @JsonKey(fromJson: _durationFromJson, toJson: _durationToJson)
  final Duration duration;

  @JsonKey(name: 'grade_markings')
  final Map<String, double> gradeMarkings;

  @JsonKey(
      name: 'subject_id',
      fromJson: _subjectIdFromJson,
      toJson: _subjectIdToJson)
  final CAPSubject subjectId;

  final List<SubjectQuestion> questions;

  ExamSubject({
    required this.name,
    required this.duration,
    required this.gradeMarkings,
    required this.subjectId,
    required this.questions,
  });

  static Duration _durationFromJson(json) {
    return Duration(minutes: json as int);
  }

  static int _durationToJson(Duration duration) {
    return duration.inMinutes;
  }

  static CAPSubject _subjectIdFromJson(json) {
    return CAPSubject.values.firstWhere((e) => e.id == json as String);
  }

  static String _subjectIdToJson(CAPSubject subjectId) {
    return subjectId.id;
  }

  factory ExamSubject.fromJson(Map<String, dynamic> json) =>
      _$ExamSubjectFromJson(json);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExamSubject &&
        other.name == name &&
        other.duration == duration &&
        other.gradeMarkings == gradeMarkings &&
        other.questions == questions;
  }

  @override
  int get hashCode =>
      Object.hash(name, duration, gradeMarkings, subjectId, questions);

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
  void clearSelectRecords() {
    for (final question in getOptionalQuestions()) {
      question.selectedChoice = null;
    }
  }
}
