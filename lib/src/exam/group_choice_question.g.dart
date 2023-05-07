// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_choice_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupChoiceQuestion _$GroupChoiceQuestionFromJson(Map<String, dynamic> json) =>
    GroupChoiceQuestion(
      description: json['description'] as String?,
      image: json['image'] as String?,
      options: (json['options'] as List<dynamic>)
          .map((e) => OptionalQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GroupChoiceQuestionToJson(
        GroupChoiceQuestion instance) =>
    <String, dynamic>{
      'type': _$QuestionTypeEnumMap[instance.type]!,
      'description': instance.description,
      'image': instance.image,
      'options': instance.options.map((e) => e.toJson()).toList(),
    };

const _$QuestionTypeEnumMap = {
  QuestionType.singleChoice: 'singleChoice',
  QuestionType.groupChoice: 'groupChoice',
  QuestionType.example: 'example',
};
