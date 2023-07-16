import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_rich_content.g.dart';

@JsonSerializable()
class QuestionRichContent {
  final RichContentType type;
  final String? content;
  final MainAxisAlignment? alignment;

  QuestionRichContent({
    required this.type,
    this.content,
    this.alignment,
  });

  factory QuestionRichContent.fromJson(Map<String, dynamic> json) =>
      _$QuestionRichContentFromJson(json);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuestionRichContent &&
        other.type == type &&
        other.content == content &&
        other.alignment == alignment;
  }

  @override
  int get hashCode => Object.hash(
        type,
        content,
        alignment,
      );

  Map<String, dynamic> toJson() => _$QuestionRichContentToJson(this);
}

enum RichContentType { text, image, border }
