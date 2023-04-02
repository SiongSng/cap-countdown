import 'package:cap_countdown/src/exam/optional_question.dart';
import 'package:cap_countdown/src/widgets/choice_button.dart';
import 'package:flutter/material.dart';
import 'package:tex_text/tex_text.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

class QuestionWidget extends StatefulWidget {
  final OptionalQuestion question;

  const QuestionWidget({super.key, required this.question});

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  bool showMore = false;

  @override
  void didUpdateWidget(covariant QuestionWidget oldWidget) {
    if (oldWidget.question != widget.question) {
      showMore = false;
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
                showMore = !showMore;
              });
            },
            label: const Text('看詳解'),
            icon: Icon(showMore ? Icons.expand_less : Icons.expand_more)),
        if (showMore) ...[
          const Divider(),
          Text('詳解', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          TexText(
              '本試題參考答案為：${widget.question.correctAnswer.name}\n\n${widget.question.explanation ?? '本題暫無詳解，將在未來更新中新增。\n倘若造成您的困擾，我們深感抱歉！'}',
              style: Theme.of(context).textTheme.bodyLarge),
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
