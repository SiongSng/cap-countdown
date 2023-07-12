import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_rich_content.g.dart';

@JsonSerializable()
class QuestionRichContent {
  final RichContentTypeEnum type;
  final String? content;
  final QuestionRichContent? child;
  final List<QuestionRichContent>? children;
  final MainAxisAlignment? alignment;

  QuestionRichContent({
    required this.type,
    this.content,
    this.child,
    this.children,
    this.alignment,
  });

  factory QuestionRichContent.fromJson(Map<String, dynamic> json) =>
      _$QuestionRichContentFromJson(json);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuestionRichContent &&
        other.type == type &&
        other.child == child &&
        other.content == content &&
        other.children == children &&
        other.alignment == alignment;
  }

  @override
  int get hashCode => Object.hash(
        type,
        content,
        child,
        children,
        alignment,
      );

  Map<String, dynamic> toJson() => _$QuestionRichContentToJson(this);
}

enum RichContentTypeEnum { text, image, border }
