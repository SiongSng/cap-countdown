import 'package:cap_countdown/src/exam/optional_question.dart';
import 'package:cap_countdown/src/exam/question_choice.dart';
import 'package:flutter/material.dart';
import 'package:latext/latext.dart';

class ChoiceButton extends StatelessWidget {
  final QuestionChoice choice;
  final OptionalQuestion question;
  final ValueChanged<QuestionChoice?>? onChanged;

  const ChoiceButton(
      {super.key,
      required this.choice,
      required this.question,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return RadioListTile<QuestionChoice>(
      // Use LaTexT to render LaTeX (math formula) in text.
      title: LaTexT(
          laTeXCode:
              Text('(${choice.answer.name}) ${choice.description ?? ''}')),
      value: choice,
      groupValue: question.selectedChoice,
      fillColor: _getFillColor(),
      onChanged: (value) {
        // If the question has been submitted, can't change the answer.
        if (question.submittedChoice != null) {
          return;
        }

        if (value == question.selectedChoice) {
          onChanged?.call(null);
        } else {
          onChanged?.call(value);
        }
      },
    );
  }

  MaterialStateProperty<Color>? _getFillColor() {
    final submittedChoice = question.submittedChoice;
    if (submittedChoice == null) {
      return null;
    }

    if (question.correctAnswer == choice.answer) {
      return MaterialStateProperty.all(Colors.green);
    }

    if (submittedChoice.answer == choice.answer &&
        question.correctAnswer != choice.answer) {
      return MaterialStateProperty.all(Colors.red);
    }

    return null;
  }
}
