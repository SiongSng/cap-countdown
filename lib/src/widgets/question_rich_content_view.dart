import 'package:cap_countdown/src/exam/question_rich_content.dart';
import 'package:cap_countdown/src/widgets/question_image.dart';
import 'package:cap_countdown/src/widgets/question_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestionRichContentView extends StatelessWidget {
  final List<QuestionRichContent> richContents;
  final String? prefixText;

  const QuestionRichContentView(
      {required this.richContents, this.prefixText, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    for (QuestionRichContent content in richContents) {
      widgets.addAll(buildRichContent(content));
    }
    if (widgets.length > 1) {
      widgets.add(const SizedBox(height: 8));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  Widget alignWidget(Alignment? alignment, Widget widget) {
    return alignment != null
        ? Align(alignment: alignment, child: widget)
        : widget;
  }

  List<Widget> buildRichContent(QuestionRichContent richContent) {
    final List<Widget> widgets = [];
    final bool showPrefixText =
        prefixText != null && richContents.first == richContent;

    switch (richContent.type) {
      case RichContentType.text:
        widgets.add(alignWidget(
            richContent.alignment,
            QuestionText(
                text:
                    "${showPrefixText ? "${prefixText!} " : ""}${richContent.content}")));
        break;
      case RichContentType.image:
        if (showPrefixText) {
          widgets.add(QuestionText(text: prefixText!));
        }
        widgets.add(const SizedBox(height: 8));
        alignWidget(
            richContent.alignment,
            QuestionImage(
              imageFileName: richContent.content!,
            ));
        widgets.add(const SizedBox(height: 8));
        break;
      case RichContentType.border:
        if (richContent.content == null) {
          throw Exception("Border content cannot be null");
        }

        widgets.add(alignWidget(
            richContent.alignment,
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(border: Border.all()),
              child: QuestionText(text: richContent.content!),
            )));
        break;
    }

    return widgets;
  }
}
