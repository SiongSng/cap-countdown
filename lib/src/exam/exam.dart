import 'package:cap_countdown/src/exam/exam_subject.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exam.g.dart';

@JsonSerializable()
class Exam {
  final String name;
  final List<ExamSubject> subjects;

  Exam({
    required this.name,
    required this.subjects,
  });

  factory Exam.fromJson(Map<String, dynamic> json) => _$ExamFromJson(json);

  Map<String, dynamic> toJson() => _$ExamToJson(this);
}
