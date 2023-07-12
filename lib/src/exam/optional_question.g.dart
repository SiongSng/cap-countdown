// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'optional_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionalQuestion _$OptionalQuestionFromJson(Map<String, dynamic> json) =>
    OptionalQuestion(
      number: json['number'] as int,
      description: json['description'] as String?,
      image: json['image'] as String?,
      audio: json['audio'] as String?,
      passingRate: (json['passing_rate'] as num?)?.toDouble(),
      discriminationIndex: (json['discrimination_index'] as num?)?.toDouble(),
      choices: (json['choices'] as List<dynamic>)
          .map((e) => QuestionChoice.fromJson(e as Map<String, dynamic>))
          .toList(),
      correctAnswer:
          $enumDecode(_$QuestionAnswerEnumMap, json['correct_answer']),
      explanation: json['explanation'] as String?,
      richContentList: (json['rich_content'] as List<dynamic>?)
          ?.map((e) => QuestionRichContent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OptionalQuestionToJson(OptionalQuestion instance) =>
    <String, dynamic>{
      'number': instance.number,
      'description': instance.description,
      'image': instance.image,
      'audio': instance.audio,
      'passing_rate': instance.passingRate,
      'discrimination_index': instance.discriminationIndex,
      'choices': instance.choices.map((e) => e.toJson()).toList(),
      'correct_answer': _$QuestionAnswerEnumMap[instance.correctAnswer]!,
      'explanation': instance.explanation,
      'rich_content': instance.richContentList?.map((e) => e.toJson()).toList(),
    };

const _$QuestionAnswerEnumMap = {
  QuestionAnswer.A: 'A',
  QuestionAnswer.B: 'B',
  QuestionAnswer.C: 'C',
  QuestionAnswer.D: 'D',
};
