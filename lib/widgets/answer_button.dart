import 'package:cap_countdown/exam/question_choice.dart';
import 'package:flutter/material.dart';

class AnswerButton extends StatefulWidget {
  final QuestionChoice choice;

  const AnswerButton({super.key, required this.choice});

  @override
  State<AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {
  @override
  Widget build(BuildContext context) {
    final choice = widget.choice;

    return FilledButton.tonal(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('(${choice.answer.name}) ${choice.description}'),
      ),
      onPressed: () {},
    );
  }
}
