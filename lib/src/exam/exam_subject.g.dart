// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamSubject _$ExamSubjectFromJson(Map<String, dynamic> json) => ExamSubject(
      name: json['name'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => SubjectQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExamSubjectToJson(ExamSubject instance) =>
    <String, dynamic>{
      'name': instance.name,
      'questions': instance.questions,
    };
