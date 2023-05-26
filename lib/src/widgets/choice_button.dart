import 'dart:ui';

import 'package:cap_countdown/src/exam/optional_question.dart';
import 'package:cap_countdown/src/exam/question_choice.dart';
import 'package:flutter/material.dart';
import 'package:latext/latext.dart';

class ChoiceButton extends StatelessWidget {
  final QuestionChoice choice;
  final OptionalQuestion question;
  final bool submitted;
  final bool isCrossOut;
  final ValueChanged<QuestionChoice?>? onChanged;
  final ValueChanged<ChoiceButtonEvent?>? onEvent;

  const ChoiceButton(
      {super.key,
      required this.choice,
      required this.question,
      required this.submitted,
      required this.isCrossOut,
      this.onChanged,
      this.onEvent});

  @override
  Widget build(BuildContext context) {
    final text = '(${choice.answer.name}) ${choice.description ?? ''}';

    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails dragEndDetails) {
        final offset = dragEndDetails.velocity.pixelsPerSecond.dx;

        if (offset != 0) {
          onEvent?.call(ChoiceButtonEvent.crossOutChoice);
        }
      },
      supportedDevices: const <PointerDeviceKind>{PointerDeviceKind.touch},
      behavior: HitTestBehavior.opaque,
      excludeFromSemantics: true,
      child: RadioListTile<QuestionChoice>(
        // Use LaTexT to render LaTeX (math formula) in text.
        title: LaTexT(
            laTeXCode: Text(
          text,
          style: isCrossOut
              ? const TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.grey)
              : null,
        )),
        value: choice,
        groupValue: question.selectedChoice,
        fillColor: _getFillColor(),
        onChanged: (value) {
          // If the question has been submitted, can't change the answer.
          if (submitted) return;
          if (isCrossOut) {
            ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
            messenger.clearSnackBars();
            messenger.showSnackBar(const SnackBar(
              content: Text('無法選擇已劃掉的選項，對選項左右滑動即可取消。'),
            ));
            return;
          }

          if (value == question.selectedChoice) {
            onChanged?.call(null);
          } else {
            onChanged?.call(value);
          }
        },
      ),
    );
  }

  MaterialStateProperty<Color>? _getFillColor() {
    if (!submitted) return null;

    if (question.correctAnswer == choice.answer) {
      return MaterialStateProperty.all(Colors.green);
    }

    if (question.selectedChoice?.answer == choice.answer &&
        question.correctAnswer != choice.answer) {
      return MaterialStateProperty.all(Colors.red);
    }

    return null;
  }
}

enum ChoiceButtonEvent {
  crossOutChoice,
  searchTranslate;
}
