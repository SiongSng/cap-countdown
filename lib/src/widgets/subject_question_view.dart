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
  final QuestionViewOption option;
  final List<Widget> Function(List<OptionalQuestion>)? actions;

  const SubjectQuestionView({
    Key? key,
    required this.question,
    this.option = const QuestionViewOption(),
    this.actions,
  }) : super(key: key);

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
              if (!widget.option.showQuestionNumber)
                Text('${entry.key + 1}.',
                    style: Theme.of(context).textTheme.titleLarge),
              OptionalQuestionView(
                  question: entry.value, option: widget.option),
              if (entry.key != question.options.length - 1) const Divider(),
            ],
          ),
        if (widget.actions != null) ...[
          const SizedBox(height: 8),
          ...widget.actions!(question.options)
        ],
      ],
    );
  }

  Widget _buildSingleChoice(
      BuildContext context, SingleChoiceQuestion question) {
    return Column(
      children: [
        OptionalQuestionView(question: question, option: widget.option),
        const SizedBox(height: 8),
        if (widget.actions != null) ...[
          const SizedBox(height: 8),
          ...widget.actions!([question])
        ],
      ],
    );
  }
}
