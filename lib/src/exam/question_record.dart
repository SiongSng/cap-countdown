import 'package:cap_countdown/main.dart';
import 'package:cap_countdown/src/exam/optional_question.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_record.g.dart';

@JsonSerializable(explicitToJson: true)
class QuestionRecord {
  final String? note;
  final bool isFavorite;
  final List<AnswerHistory> answerHistory;

  const QuestionRecord({
    this.note,
    this.isFavorite = false,
    this.answerHistory = const [],
  });

  factory QuestionRecord.fromJson(Map<String, dynamic> json) =>
      _$QuestionRecordFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionRecordToJson(this);

  QuestionRecord copyWith({
    String? note,
    bool? isFavorite,
    List<AnswerHistory>? answerHistory,
  }) {
    return QuestionRecord(
      note: note ?? this.note,
      isFavorite: isFavorite ?? this.isFavorite,
      answerHistory: answerHistory ?? this.answerHistory,
    );
  }

  static QuestionRecord getByHash(String hash) {
    return localStorage.questionRecords[hash] ?? const QuestionRecord();
  }
}

@JsonSerializable()
class AnswerHistory {
  final DateTime date;
  final QuestionAnswer? selectedAnswer;
  final bool isCorrect;

  const AnswerHistory({
    required this.date,
    required this.selectedAnswer,
    required this.isCorrect,
  });

  factory AnswerHistory.fromJson(Map<String, dynamic> json) =>
      _$AnswerHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerHistoryToJson(this);
}
