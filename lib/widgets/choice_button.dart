import 'package:cap_countdown/exam/question_choice.dart';
import 'package:flutter/material.dart';
import 'package:tex_text/tex_text.dart';

class ChoiceButton extends StatelessWidget {
  final QuestionChoice choice;
  final QuestionChoice? selectedChoice;
  final ValueChanged<QuestionChoice?>? onChanged;

  const ChoiceButton(
      {super.key, required this.choice, this.selectedChoice, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return RadioListTile<QuestionChoice>(
      // Use TexText to render LaTeX (math formula) in text.
      title: TexText('(${choice.answer.name}) ${choice.description}'),
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
