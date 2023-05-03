import 'package:json_annotation/json_annotation.dart';

part 'question_note.g.dart';

@JsonSerializable()
class QuestionNote {
  final String text;

  const QuestionNote({
    required this.text,
  });

  factory QuestionNote.fromJson(Map<String, dynamic> json) =>
      _$QuestionNoteFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionNoteToJson(this);
}
