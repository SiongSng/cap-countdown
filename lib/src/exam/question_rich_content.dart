import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_rich_content.g.dart';

@JsonSerializable()
class QuestionRichContent {
  final RichContentType type;
  final String? content;
  @JsonKey(fromJson: _alignmentFromJson, toJson: _alignmentToJson)
  final Alignment? alignment;

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

  static Alignment? _alignmentFromJson(String? alignment) {
    switch (alignment) {
      case 'topLeft':
        return Alignment.topLeft;
      case 'topCenter':
        return Alignment.topCenter;
      case 'topRight':
        return Alignment.topRight;
      case 'centerLeft':
        return Alignment.centerLeft;
      case 'center':
        return Alignment.center;
      case 'centerRight':
        return Alignment.centerRight;
      case 'bottomLeft':
        return Alignment.bottomLeft;
      case 'bottomCenter':
        return Alignment.bottomCenter;
      case 'bottomRight':
        return Alignment.bottomRight;
      case null:
        return null;
      default:
        throw Exception('Invalid alignment');
    }
  }

  static String? _alignmentToJson(Alignment? alignment) {
    switch (alignment) {
      case Alignment.topLeft:
        return 'topLeft';
      case Alignment.topCenter:
        return 'topCenter';
      case Alignment.topRight:
        return 'topRight';
      case Alignment.centerLeft:
        return 'centerLeft';
      case Alignment.center:
        return 'center';
      case Alignment.centerRight:
        return 'centerRight';
      case Alignment.bottomLeft:
        return 'bottomLeft';
      case Alignment.bottomCenter:
        return 'bottomCenter';
      case Alignment.bottomRight:
        return 'bottomRight';
      case null:
        return null;
      default:
        throw Exception('Invalid alignment');
    }
  }
}

enum RichContentType { text, image, border }
