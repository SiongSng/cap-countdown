// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionRecord _$QuestionRecordFromJson(Map<String, dynamic> json) =>
    QuestionRecord(
      note: json['note'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
      answerHistory: (json['answerHistory'] as List<dynamic>?)
              ?.map((e) => AnswerHistory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$QuestionRecordToJson(QuestionRecord instance) =>
    <String, dynamic>{
      'note': instance.note,
      'isFavorite': instance.isFavorite,
      'answerHistory': instance.answerHistory,
    };

AnswerHistory _$AnswerHistoryFromJson(Map<String, dynamic> json) =>
    AnswerHistory(
      date: DateTime.parse(json['date'] as String),
      selectedAnswer:
          $enumDecodeNullable(_$QuestionAnswerEnumMap, json['selectedAnswer']),
      isCorrect: json['isCorrect'] as bool,
    );

Map<String, dynamic> _$AnswerHistoryToJson(AnswerHistory instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'selectedAnswer': _$QuestionAnswerEnumMap[instance.selectedAnswer],
      'isCorrect': instance.isCorrect,
    };

const _$QuestionAnswerEnumMap = {
  QuestionAnswer.A: 'A',
  QuestionAnswer.B: 'B',
  QuestionAnswer.C: 'C',
  QuestionAnswer.D: 'D',
};
