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
      subjectId: ExamSubject._subjectIdFromJson(json['subject_id']),
      questions: (json['questions'] as List<dynamic>)
          .map((e) => SubjectQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExamSubjectToJson(ExamSubject instance) =>
    <String, dynamic>{
      'name': instance.name,
      'duration': ExamSubject._durationToJson(instance.duration),
      'grade_markings': instance.gradeMarkings,
      'subject_id': ExamSubject._subjectIdToJson(instance.subjectId),
      'questions': instance.questions.map((e) => e.toJson()).toList(),
    };
