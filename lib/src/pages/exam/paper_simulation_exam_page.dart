import 'dart:async';

import 'package:cap_countdown/src/exam/exam_subject.dart';
import 'package:cap_countdown/src/pages/exam/simulation_exam_page.dart';
import 'package:flutter/material.dart';

class PaperSimulationExamPage extends StatefulWidget {
  final String examName;
  final ExamSubject subject;

  const PaperSimulationExamPage(
      {Key? key, required this.examName, required this.subject})
      : super(key: key);

  @override
  State<PaperSimulationExamPage> createState() =>
      _PaperSimulationExamPageState();
}

class _PaperSimulationExamPageState extends State<PaperSimulationExamPage> {
  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(minutes: 1), (timer) {
      if (!mounted) return timer.cancel();

      // Update the left time
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final optionalQuestionLength =
        widget.subject.getAllOptionalQuestion().length;

    final now = DateTime.now().toLocal();
    final end = now.add(widget.subject.duration);

    return Scaffold(
      appBar: AppBar(
        title: const Text('準備好接受挑戰了嗎？'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset('assets/images/materials/awards.png'),
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        '這是 ${widget.examName}試題，共有 $optionalQuestionLength 題選擇題，每題都只有一個正確或最佳的答案。'),
                    Text(
                        '測驗時間從 ${now.hour}:${now.minute} 到 ${end.hour}:${end.minute}，共 ${widget.subject.duration.inMinutes} 分鐘。'),
                  ],
                ),
                const Divider(),
                Text('準備好紙筆，點下方按鈕就立即開始囉！',
                    style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SimulationExamPage(
                          examName: widget.examName, subject: widget.subject)));
                },
                label: const Text('開始測驗', style: TextStyle(fontSize: 18)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
