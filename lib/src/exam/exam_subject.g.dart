// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$ExamSubjectToJson(ExamSubject instance) =>
    <String, dynamic>{
      'name': instance.name,
      'duration': instance.duration.inMicroseconds,
      'questions': ExamSubject._questionsToJson(instance.questions),
    };
