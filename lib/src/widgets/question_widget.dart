import 'package:cap_countdown/src/exam/subject_question.dart';
import 'package:cap_countdown/src/widgets/choice_button.dart';
import 'package:flutter/material.dart';
import 'package:tex_text/tex_text.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

class QuestionWidget extends StatefulWidget {
  final SubjectQuestion question;

  const QuestionWidget({super.key, required this.question});

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  bool showExplanation = false;

  @override
  void didUpdateWidget(covariant QuestionWidget oldWidget) {
    if (oldWidget.question != widget.question) {
      showExplanation = false;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.question.image != null)
          Builder(builder: (context) {
            final image = Image.asset(
              'assets/images/exam/${widget.question.image}',
              fit: BoxFit.fitWidth,
            );
            final platform = Theme.of(context).platform;

            if (platform == TargetPlatform.android ||
                platform == TargetPlatform.iOS) {
              return ZoomOverlay(
                maxScale: 5.0,
                child: image,
              );
            }

            return image;
          }),
        if (widget.question.image != null) const SizedBox(height: 8),
        // Use TexText to render LaTeX (math formula) in text.
        TexText(
          widget.question.description ?? '',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 8),
        _ChoiceButtons(question: widget.question),
        TextButton.icon(
            onPressed: () {
              if (widget.question.selectedChoice == null) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('請先交卷再來看詳解喔！'),
                  backgroundColor: Colors.orange,
                ));
                return;
              }

              setState(() {
                showExplanation = !showExplanation;
              });
            },
            label: const Text('看詳解'),
            icon:
                Icon(showExplanation ? Icons.expand_less : Icons.expand_more)),
        if (showExplanation) ...[
          const Divider(),
          Text('詳解', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          TexText(
              '本試題參考答案為：${widget.question.correctAnswer.name}\n\n${widget.question.explanation}',
              style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 8)
        ]
      ],
    );
  }
}

class _ChoiceButtons extends StatefulWidget {
  final SubjectQuestion question;

  const _ChoiceButtons({required this.question});

  @override
  State<_ChoiceButtons> createState() => _ChoiceButtonsState();
}

class _ChoiceButtonsState extends State<_ChoiceButtons> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children: widget.question.choices
          .map((e) => ChoiceButton(
                choice: e,
                selectedChoice: widget.question.selectedChoice,
                onChanged: (value) {
                  setState(() {
                    widget.question.selectedChoice = value;
                  });
                },
              ))
          .toList(),
    );
  }
}
