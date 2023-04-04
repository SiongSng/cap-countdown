// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_choice_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleChoiceQuestion _$SingleChoiceQuestionFromJson(
        Map<String, dynamic> json) =>
    SingleChoiceQuestion(
      number: json['number'] as int,
      description: json['description'] as String?,
      image: json['image'] as String?,
      passingRate: (json['passing_rate'] as num).toDouble(),
      discriminationIndex: (json['discrimination_index'] as num).toDouble(),
      choices: (json['choices'] as List<dynamic>)
          .map((e) => QuestionChoice.fromJson(e as Map<String, dynamic>))
          .toList(),
      correctAnswer:
          $enumDecode(_$QuestionAnswerEnumMap, json['correct_answer']),
      explanation: json['explanation'] as String?,
    );

Map<String, dynamic> _$SingleChoiceQuestionToJson(
        SingleChoiceQuestion instance) =>
    <String, dynamic>{
      'number': instance.number,
      'description': instance.description,
      'image': instance.image,
      'passing_rate': instance.passingRate,
      'discrimination_index': instance.discriminationIndex,
      'choices': OptionalQuestion.choicesToJson(instance.choices),
      'correct_answer': _$QuestionAnswerEnumMap[instance.correctAnswer]!,
      'explanation': instance.explanation,
      'type': _$QuestionTypeEnumMap[instance.type]!,
    };

const _$QuestionAnswerEnumMap = {
  QuestionAnswer.A: 'A',
  QuestionAnswer.B: 'B',
  QuestionAnswer.C: 'C',
  QuestionAnswer.D: 'D',
};

const _$QuestionTypeEnumMap = {
  QuestionType.singleChoice: 'singleChoice',
  QuestionType.groupChoice: 'groupChoice',
};
