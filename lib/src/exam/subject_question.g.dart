// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectQuestion _$SubjectQuestionFromJson(Map<String, dynamic> json) =>
    SubjectQuestion(
      index: json['index'] as int,
      type: $enumDecode(_$QuestionTypeEnumMap, json['type']),
      description: json['description'] as String?,
      image: json['image'] as String?,
      passingRate: (json['passing_rate'] as num).toDouble(),
      discriminationIndex: (json['discrimination_index'] as num).toDouble(),
      choices: (json['choices'] as List<dynamic>)
          .map((e) => QuestionChoice.fromJson(e as Map<String, dynamic>))
          .toList(),
      correctAnswer:
          $enumDecode(_$QuestionAnswerEnumMap, json['correct_answer']),
      explanation: json['explanation'] as String,
    );

Map<String, dynamic> _$SubjectQuestionToJson(SubjectQuestion instance) =>
    <String, dynamic>{
      'index': instance.index,
      'type': _$QuestionTypeEnumMap[instance.type]!,
      'description': instance.description,
      'image': instance.image,
      'passing_rate': instance.passingRate,
      'discrimination_index': instance.discriminationIndex,
      'choices': instance.choices,
      'correct_answer': _$QuestionAnswerEnumMap[instance.correctAnswer]!,
      'explanation': instance.explanation,
    };

const _$QuestionTypeEnumMap = {
  QuestionType.singleChoice: 'singleChoice',
  QuestionType.groupChoice: 'groupChoice',
};

const _$QuestionAnswerEnumMap = {
  QuestionAnswer.A: 'A',
  QuestionAnswer.B: 'B',
  QuestionAnswer.C: 'C',
  QuestionAnswer.D: 'D',
};
