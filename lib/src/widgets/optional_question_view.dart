import 'package:cap_countdown/src/exam/optional_question.dart';
import 'package:cap_countdown/src/widgets/choice_button.dart';
import 'package:cap_countdown/src/widgets/question_image.dart';
import 'package:cap_countdown/src/widgets/question_text.dart';
import 'package:flutter/material.dart';

class OptionalQuestionView extends StatefulWidget {
  final OptionalQuestion question;

  const OptionalQuestionView({super.key, required this.question});

  @override
  State<OptionalQuestionView> createState() => _OptionalQuestionViewState();
}

class _OptionalQuestionViewState extends State<OptionalQuestionView> {
  bool showMore = false;

  @override
  void didUpdateWidget(covariant OptionalQuestionView oldWidget) {
    if (oldWidget.question != widget.question) {
      showMore = false;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final description = widget.question.description;
    final imageName = widget.question.image;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (imageName != null) QuestionImage(imageFileName: imageName),
        if (widget.question.image != null) const SizedBox(height: 8),
        // Use LaTexT to render LaTeX (math formula) in text.
        if (description != null) QuestionText(text: description),
        const SizedBox(height: 8),
        _ChoiceButtons(question: widget.question),
        if (widget.question.submittedChoice != null)
          Align(
            alignment: Alignment.center,
            child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    showMore = !showMore;
                  });
                },
                label: const Text('看詳解'),
                icon: Icon(showMore ? Icons.expand_less : Icons.expand_more)),
          ),
        if (showMore) ...[
          const Divider(),
          Align(
              alignment: Alignment.center,
              child: Text('詳解', style: Theme.of(context).textTheme.titleLarge)),
          const SizedBox(height: 8),
          QuestionText(
              text:
                  '本試題參考答案為：${widget.question.correctAnswer.name}\n\n${widget.question.explanation ?? '本題暫無詳解，將在未來更新中新增。\n倘若造成您的困擾，我們深感抱歉！'}'),
          const SizedBox(height: 10),
          _Indicator(
              passingRate: widget.question.passingRate,
              discriminationIndex: widget.question.discriminationIndex),
          const SizedBox(height: 8),
        ]
      ],
    );
  }
}

class _Indicator extends StatelessWidget {
  final double passingRate;
  final double discriminationIndex;

  const _Indicator(
      {required this.passingRate, required this.discriminationIndex});

  @override
  Widget build(BuildContext context) {
    Color passRateColor = getColorFromPassingRate(passingRate);
    Color discriminationColor = getColorFromDiscrimination(discriminationIndex);
    String discriminationLabel = getDiscriminationLabel(discriminationIndex);

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Material(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '通過率',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${(passingRate * 100).toInt()}%',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: passRateColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '鑑別度',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        discriminationLabel,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: discriminationColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getDiscriminationLabel(double discrimination) {
    if (discrimination < 0.2) {
      return '低';
    } else if (discrimination < 0.5) {
      return '中';
    } else {
      return '高';
    }
  }

  Color getColorFromDiscrimination(double discrimination) {
    if (discrimination < 0.2) {
      return Colors.red;
    } else if (discrimination < 0.5) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  Color getColorFromPassingRate(double passingRate) {
    if (passingRate < 0.3) {
      return Colors.red;
    } else if (passingRate < 0.5) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }
}

class _ChoiceButtons extends StatefulWidget {
  final OptionalQuestion question;

  const _ChoiceButtons({required this.question});

  @override
  State<_ChoiceButtons> createState() => _ChoiceButtonsState();
}

class _ChoiceButtonsState extends State<_ChoiceButtons> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8,
      children: widget.question.choices
          .map((e) => ChoiceButton(
                choice: e,
                question: widget.question,
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
