// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExampleQuestion _$ExampleQuestionFromJson(Map<String, dynamic> json) =>
    ExampleQuestion(
      description: json['description'] as String?,
      image: json['image'] as String?,
      audio: json['audio'] as String?,
    );

Map<String, dynamic> _$ExampleQuestionToJson(ExampleQuestion instance) =>
    <String, dynamic>{
      'type': _$QuestionTypeEnumMap[instance.type]!,
      'description': instance.description,
      'image': instance.image,
      'audio': instance.audio,
    };

const _$QuestionTypeEnumMap = {
  QuestionType.singleChoice: 'singleChoice',
  QuestionType.groupChoice: 'groupChoice',
  QuestionType.example: 'example',
};
