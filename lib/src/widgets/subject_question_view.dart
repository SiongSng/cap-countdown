import 'package:cap_countdown/src/exam/group_choice_question.dart';
import 'package:cap_countdown/src/exam/optional_question.dart';
import 'package:cap_countdown/src/exam/single_choice_question.dart';
import 'package:cap_countdown/src/exam/subject_question.dart';
import 'package:flutter/material.dart';

import 'optional_question_view.dart';
import 'question_image.dart';
import 'question_text.dart';

class SubjectQuestionView extends StatefulWidget {
  final SubjectQuestion question;
  final VoidCallback onRefresh;

  const SubjectQuestionView(
      {Key? key, required this.question, required this.onRefresh})
      : super(key: key);

  @override
  State<SubjectQuestionView> createState() => _SubjectQuestionViewState();
}

class _SubjectQuestionViewState extends State<SubjectQuestionView> {
  @override
  Widget build(BuildContext context) {
    final question = widget.question;

    if (question is SingleChoiceQuestion) {
      return _buildSingleChoice(context, question);
    } else if (question is GroupChoiceQuestion) {
      return _buildGroupChoice(context, question);
    } else {
      throw Exception("Unknown question type");
    }
  }

  Widget _buildGroupChoice(BuildContext context, GroupChoiceQuestion question) {
    final description = question.description;
    final imageFileName = question.image;

    return Column(
      children: [
        if (description != null) QuestionText(text: description),
        if (imageFileName != null) ...[
          const SizedBox(height: 8),
          QuestionImage(imageFileName: imageFileName),
          const SizedBox(height: 8)
        ],
        if (description != null || imageFileName != null) const Divider(),
        for (final entry in question.options.asMap().entries)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${entry.key + 1}.',
                  style: Theme.of(context).textTheme.titleLarge),
              OptionalQuestionView(question: entry.value),
            ],
          ),
        const SizedBox(height: 8),
        _submitAnswer(question.options, context)
      ],
    );
  }

  Widget _buildSingleChoice(
      BuildContext context, SingleChoiceQuestion question) {
    return Column(
      children: [
        OptionalQuestionView(question: question),
        const SizedBox(height: 8),
        _submitAnswer([question], context)
      ],
    );
  }

  Widget _submitAnswer(List<OptionalQuestion> questions, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FilledButton.icon(
            onPressed: () {
              final isSelectAll =
                  questions.every((q) => q.selectedChoice != null);
              final messenger = ScaffoldMessenger.of(context);
              messenger.clearSnackBars();

              if (!isSelectAll) {
                messenger.showSnackBar(
                  const SnackBar(
                    content: Text('交卷前請先記得選擇答案喔！',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    backgroundColor: Colors.orange,
                  ),
                );
                return;
              }

              if (questions.every((q) => q.isCorrect)) {
                messenger.showSnackBar(
                  SnackBar(
                    content:
                        Text(questions.length > 1 ? '恭喜你全都答對了！' : '恭喜你答對了！'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else {
                messenger.showSnackBar(
                  const SnackBar(
                    content: Text('答錯了，再接再厲！記得看詳解修正錯誤呦！'),
                    backgroundColor: Colors.red,
                  ),
                );
              }

              setState(() {
                for (final q in questions) {
                  q.submittedChoice = q.selectedChoice;
                }
              });
            },
            icon: const Icon(Icons.check),
            label: const Text('交卷')),
        FilledButton.icon(
            onPressed: () {
              setState(() {
                for (final q in questions) {
                  q.selectedChoice = null;
                  q.submittedChoice = null;
                }
              });

              widget.onRefresh();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('再來一題')),
      ],
    );
  }
}
