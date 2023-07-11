import 'package:cap_countdown/src/exam/example_question.dart';
import 'package:cap_countdown/src/exam/group_choice_question.dart';
import 'package:cap_countdown/src/exam/optional_question.dart';
import 'package:cap_countdown/src/exam/question_meta.dart';
import 'package:cap_countdown/src/exam/single_choice_question.dart';
import 'package:cap_countdown/src/exam/subject_question.dart';
import 'package:cap_countdown/src/widgets/question_audio_player.dart';
import 'package:cap_countdown/src/widgets/report_question_button.dart';
import 'package:flutter/material.dart';

import 'optional_question_view.dart';
import 'question_image.dart';
import 'question_text.dart';

class SubjectQuestionView extends StatefulWidget {
  final SubjectQuestion question;
  final QuestionMeta meta;
  final QuestionViewOption option;
  final List<Widget> Function(List<OptionalQuestion>)? actions;

  const SubjectQuestionView({
    Key? key,
    required this.question,
    required this.meta,
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
      return _buildSingleChoice(question);
    } else if (question is GroupChoiceQuestion) {
      return _buildGroupChoice(question);
    } else if (question is ExampleQuestion) {
      return _buildExample(question);
    } else {
      throw Exception('Unknown question type');
    }
  }

  Widget _buildGroupChoice(GroupChoiceQuestion question) {
    final description = question.description;
    final imageFileName = question.image;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                    style: Theme.of(context).textTheme.titleMedium),
              OptionalQuestionView(
                  question: entry.value,
                  meta: widget.meta,
                  option: widget.option),
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

  Widget _buildSingleChoice(SingleChoiceQuestion question) {
    return Column(
      children: [
        OptionalQuestionView(
            question: question, meta: widget.meta, option: widget.option),
        const SizedBox(height: 8),
        if (widget.actions != null) ...[
          const SizedBox(height: 8),
          ...widget.actions!([question])
        ],
      ],
    );
  }

  Widget _buildExample(ExampleQuestion question) {
    final imageName = question.image;
    final description = question.description;
    final audioFileName = question.audio;

    return Column(
      children: [
        if (imageName != null) ...[
          QuestionImage(imageFileName: imageName),
          const SizedBox(height: 8),
        ],
        // Use LaTexT to render LaTeX (math formula) in text.
        if (description != null) ...[
          QuestionText(text: description),
          const SizedBox(height: 8),
        ],
        if (audioFileName != null) ...[
          QuestionAudioPlayer(
              audioFileName: audioFileName,
              onlyPlayOnce: widget.option.onlyPlayAudioOnce,
              onAudioPlayStateChanged: widget.option.onAudioPlayStateChanged),
          const SizedBox(height: 8),
        ],
        Align(
            alignment: Alignment.centerRight,
            child: ReportQuestionButton(meta: widget.meta)),
      ],
    );
  }
}
