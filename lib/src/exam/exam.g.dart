// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exam _$ExamFromJson(Map<String, dynamic> json) => Exam(
      year: json['year'] as int,
      name: json['name'] as String,
      subjects: (json['subjects'] as List<dynamic>)
          .map((e) => ExamSubject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExamToJson(Exam instance) => <String, dynamic>{
      'year': instance.year,
      'name': instance.name,
      'subjects': instance.subjects,
    };
