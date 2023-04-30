import 'cap_subject.dart';

class QuestionMeta {
  final int year;
  final CAPSubject subjectId;
  final int questionIndex;
  final String questionNumber;

  const QuestionMeta({
    required this.year,
    required this.subjectId,
    required this.questionIndex,
    required this.questionNumber,
  });
}
