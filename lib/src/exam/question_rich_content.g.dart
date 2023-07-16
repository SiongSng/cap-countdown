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
          $enumDecodeNullable(_$MainAxisAlignmentEnumMap, json['alignment']),
    );

Map<String, dynamic> _$QuestionRichContentToJson(
        QuestionRichContent instance) =>
    <String, dynamic>{
      'type': _$RichContentTypeEnumMap[instance.type]!,
      'content': instance.content,
      'alignment': _$MainAxisAlignmentEnumMap[instance.alignment],
    };

const _$RichContentTypeEnumMap = {
  RichContentType.text: 'text',
  RichContentType.image: 'image',
  RichContentType.border: 'border',
};

const _$MainAxisAlignmentEnumMap = {
  MainAxisAlignment.start: 'start',
  MainAxisAlignment.end: 'end',
  MainAxisAlignment.center: 'center',
  MainAxisAlignment.spaceBetween: 'spaceBetween',
  MainAxisAlignment.spaceAround: 'spaceAround',
  MainAxisAlignment.spaceEvenly: 'spaceEvenly',
};
