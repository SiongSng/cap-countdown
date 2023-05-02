import 'package:cap_countdown/src/exam/single_choice_question.dart';

import 'cap_subject.dart';
import 'example_question.dart';
import 'group_choice_question.dart';

class QuestionMeta {
  final int year;
  final CAPSubject subjectId;
  final int questionIndex;
  late final String questionNumber;
  final dynamic question;

  QuestionMeta({
    required this.year,
    required this.subjectId,
    required this.questionIndex,
    required this.question,
  }) {
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
  }
}
