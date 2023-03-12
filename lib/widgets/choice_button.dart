import 'package:cap_countdown/exam/question_choice.dart';
import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget {
  final QuestionChoice choice;
  final QuestionChoice? selectedChoice;
  final ValueChanged<QuestionChoice?>? onChanged;

  const ChoiceButton(
      {super.key, required this.choice, this.selectedChoice, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return RadioListTile<QuestionChoice>(
      title: Text('(${choice.answer.name}) ${choice.description}'),
      value: choice,
      groupValue: selectedChoice,
      onChanged: (value) {
        if (value == selectedChoice) {
          onChanged?.call(null);
        } else {
          onChanged?.call(value);
        }
      },
    );
  }
}
