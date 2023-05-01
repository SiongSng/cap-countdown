import 'package:cap_countdown/main.dart';
import 'package:cap_countdown/src/exam/question_meta.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ReportQuestionButton extends StatelessWidget {
  final QuestionMeta meta;

  const ReportQuestionButton({Key? key, required this.meta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          final value =
              'CAP_${meta.year}_${meta.subjectId.id}_${meta.questionNumber} (ver:${config.appVersion})';

          launchUrlString(
              'https://docs.google.com/forms/d/e/1FAIpQLSd4UN6Eb2Tl616fYaze5tLfU-lN5UFrVg_iGhcZrA5LKqDEPw/viewform?usp=pp_url&entry.28993501=$value');
        },
        child: const Text('問題回報'));
  }
}
