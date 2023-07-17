// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_rich_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionRichContent _$QuestionRichContentFromJson(Map<String, dynamic> json) =>
    QuestionRichContent(
      type: $enumDecode(_$RichContentTypeEnumMap, json['type']),
      content: json['content'] as String?,
      alignment:
          QuestionRichContent._alignmentFromJson(json['alignment'] as String?),
    );

Map<String, dynamic> _$QuestionRichContentToJson(
        QuestionRichContent instance) =>
    <String, dynamic>{
      'type': _$RichContentTypeEnumMap[instance.type]!,
      'content': instance.content,
      'alignment': QuestionRichContent._alignmentToJson(instance.alignment),
    };

const _$RichContentTypeEnumMap = {
  RichContentType.text: 'text',
  RichContentType.image: 'image',
  RichContentType.border: 'border',
};
