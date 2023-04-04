import 'package:cap_countdown/src/exam/exam_subject.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exam.g.dart';

@JsonSerializable()
class Exam {
  final int year;
  final String name;
  final List<ExamSubject> subjects;

  Exam({
    required this.year,
    required this.name,
    required this.subjects,
  });

  factory Exam.fromJson(Map<String, dynamic> json) => _$ExamFromJson(json);

  Map<String, dynamic> toJson() => _$ExamToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Exam &&
        other.year == year &&
        other.name == name &&
        listEquals(other.subjects, subjects);
  }

  @override
  int get hashCode => year.hashCode ^ name.hashCode ^ subjects.hashCode;
}
