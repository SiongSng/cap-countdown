// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_rich_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionRichContent _$QuestionRichContentFromJson(Map<String, dynamic> json) =>
    QuestionRichContent(
      type: $enumDecode(_$RichContentTypeEnumEnumMap, json['type']),
      content: json['content'] as String?,
      child: json['child'] == null
          ? null
          : QuestionRichContent.fromJson(json['child'] as Map<String, dynamic>),
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => QuestionRichContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      alignment:
          $enumDecodeNullable(_$MainAxisAlignmentEnumMap, json['alignment']),
    );

Map<String, dynamic> _$QuestionRichContentToJson(
        QuestionRichContent instance) =>
    <String, dynamic>{
      'type': _$RichContentTypeEnumEnumMap[instance.type]!,
      'content': instance.content,
      'child': instance.child,
      'children': instance.children,
      'alignment': _$MainAxisAlignmentEnumMap[instance.alignment],
    };

const _$RichContentTypeEnumEnumMap = {
  RichContentTypeEnum.text: 'text',
  RichContentTypeEnum.image: 'image',
  RichContentTypeEnum.border: 'border',
};

const _$MainAxisAlignmentEnumMap = {
  MainAxisAlignment.start: 'start',
  MainAxisAlignment.end: 'end',
  MainAxisAlignment.center: 'center',
  MainAxisAlignment.spaceBetween: 'spaceBetween',
  MainAxisAlignment.spaceAround: 'spaceAround',
  MainAxisAlignment.spaceEvenly: 'spaceEvenly',
};
