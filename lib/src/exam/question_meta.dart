import 'package:cap_countdown/src/exam/single_choice_question.dart';

import 'cap_subject.dart';
import 'example_question.dart';
import 'group_choice_question.dart';

class QuestionMeta {
  final int year;
  final CAPSubject subjectId;
  final int questionIndex;
  final String questionNumber;

  const QuestionMeta(
      {required this.year,
      required this.subjectId,
      required this.questionIndex,
      required this.questionNumber});

  factory QuestionMeta.build({year, subjectId, questionIndex, question}) {
    final String questionNumber;
    if (question is SingleChoiceQuestion) {
      questionNumber =
          '${question.number.toString()}(i:${questionIndex.toString()})';
    } else if (question is GroupChoiceQuestion) {
      questionNumber =
          '${question.options.first.number}-${question.options.last.number}(i:${questionIndex.toString()})';
    } else if (question is ExampleQuestion) {
      questionNumber = 'example(i:$questionIndex)';
    } else {
      throw Exception('Unknown question type');
    }
    return QuestionMeta(
        year: year,
        subjectId: subjectId,
        questionIndex: questionIndex,
        questionNumber: questionNumber);
  }
}
