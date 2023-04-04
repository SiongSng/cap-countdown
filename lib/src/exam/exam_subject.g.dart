// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamSubject _$ExamSubjectFromJson(Map<String, dynamic> json) => ExamSubject(
      name: json['name'] as String,
      duration: ExamSubject._durationFromJson(json['duration']),
      gradeMarkings: (json['grade_markings'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      questions: ExamSubject._questionsFromJson(json['questions']),
    );

Map<String, dynamic> _$ExamSubjectToJson(ExamSubject instance) =>
    <String, dynamic>{
      'name': instance.name,
      'duration': ExamSubject._durationToJson(instance.duration),
      'grade_markings': instance.gradeMarkings,
      'questions': instance.questions,
    };
