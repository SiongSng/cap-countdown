import 'package:cap_countdown/exam/subject_question.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exam_subject.g.dart';

@JsonSerializable()
class ExamSubject {
  final String name;
  final List<SubjectQuestion> questions;

  ExamSubject({
    required this.name,
    required this.questions,
  });

  factory ExamSubject.fromJson(Map<String, dynamic> json) =>
      _$ExamSubjectFromJson(json);

  Map<String, dynamic> toJson() => _$ExamSubjectToJson(this);
}
