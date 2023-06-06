// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_choice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionChoice _$QuestionChoiceFromJson(Map<String, dynamic> json) =>
    QuestionChoice(
      answer: $enumDecode(_$QuestionAnswerEnumMap, json['answer']),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$QuestionChoiceToJson(QuestionChoice instance) =>
    <String, dynamic>{
      'answer': _$QuestionAnswerEnumMap[instance.answer]!,
      'description': instance.description,
    };

const _$QuestionAnswerEnumMap = {
  QuestionAnswer.A: 'A',
  QuestionAnswer.B: 'B',
  QuestionAnswer.C: 'C',
  QuestionAnswer.D: 'D',
};
