import 'package:cap_countdown/src/widgets/question_image.dart';
import 'package:cap_countdown/src/widgets/question_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../exam/question_rich_content.dart';

class QuestionRichContentView extends StatelessWidget {
  final List<QuestionRichContent> richContentList;
  final String? prefixText;

  const QuestionRichContentView(
      {required this.richContentList, this.prefixText, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> richWidgetList = [];

    void addAlignWidget(MainAxisAlignment? alignment, Widget widget) {
      richWidgetList.add(alignment != null
          ? Row(mainAxisAlignment: alignment, children: [widget])
          : widget);
    }

    for (QuestionRichContent richContent in richContentList) {
      switch (richContent.type) {
        case RichContentTypeEnum.text:
          addAlignWidget(
              richContent.alignment,
              QuestionText(
                  text:
                      "${prefixText != null && richContentList.first == richContent ? "${prefixText!} " : ""}${richContent.content}"));
          break;
        case RichContentTypeEnum.image:
          if (prefixText != null && richContentList.first == richContent) {
            richWidgetList.add(QuestionText(text: prefixText!));
          }
          richWidgetList.add(const SizedBox(
            height: 8,
          ));
          addAlignWidget(
              richContent.alignment,
              QuestionImage(
                imageFileName: richContent.content!,
              ));
          richWidgetList.add(const SizedBox(
            height: 8,
          ));

          break;
        case RichContentTypeEnum.border:
          addAlignWidget(
              richContent.alignment,
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(border: Border.all()),
                child: QuestionRichContentView(
                  richContentList: [richContent.child!],
                ),
              ));
          break;
        default:
          throw TypeError();
      }
    }
    richWidgetList.add(const SizedBox(
      height: 8,
    ));
    if (richWidgetList.length == 2) return richWidgetList[0];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: richWidgetList,
    );
  }
}
