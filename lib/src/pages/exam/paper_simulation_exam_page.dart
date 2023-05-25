import 'dart:async';

import 'package:cap_countdown/src/exam/exam_subject.dart';
import 'package:cap_countdown/src/pages/exam/simulation_exam_page.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

class PrepareSimulationExamPage extends StatefulWidget {
  final int year;
  final String examName;
  final ExamSubject subject;

  const PrepareSimulationExamPage(
      {Key? key,
      required this.year,
      required this.examName,
      required this.subject})
      : super(key: key);

  @override
  State<PrepareSimulationExamPage> createState() =>
      _PrepareSimulationExamPageState();
}

class _PrepareSimulationExamPageState extends State<PrepareSimulationExamPage> {
  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!mounted) return timer.cancel();

      // Update the left time
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final optionalQuestionLength = widget.subject.getOptionalQuestions().length;

    final now = DateTime.now().toLocal();
    final end = now.add(widget.subject.duration);

    return Scaffold(
      appBar: AppBar(
        title: const Text('準備好了嗎？'),
        actions: [
          const Text("模擬試題設定"),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return AlertDialog(
                          content: Container(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                ListTile(
                                    title: const Text('模擬試題'),
                                    leading: const Icon(Icons.edit),
                                    shape:
                                        Border.all(color: Colors.transparent)),
                                SwitchListTile(
                                    value: localStorage.simulationExamTiming,
                                    onChanged: (value) {
                                      localStorage.simulationExamTiming = value;
                                      setState(() {});
                                    },
                                    title: const Text('作答時間倒計時'),
                                    subtitle: const Text(
                                        '若啟用則有作答時間限制，在該科作答時間結束後強制交卷；反之則無此限制。')),
                                SwitchListTile(
                                    value:
                                        localStorage.simulationExamShowAnsBtn,
                                    onChanged: (value) {
                                      localStorage.simulationExamShowAnsBtn =
                                          value;
                                      setState(() {});
                                    },
                                    title: const Text('即時對答案'),
                                    subtitle: const Text(
                                        '為每道試題增加一個「對答案」答案按鈕，可單獨提交該題答案，並查看詳解。'))
                              ])),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('確定'))
                          ],
                        );
                      });
                    });
              },
              icon: const Icon(Icons.settings))
        ],
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
                        '這是 ${widget.examName}${widget.subject.name}試題，共有 $optionalQuestionLength 題選擇題，每題都只有一個正確或最佳的答案。',
                        style: Theme.of(context).textTheme.bodyLarge),
                    Text(
                        '測驗時間從 ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} 到 ${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}，共 ${widget.subject.duration.inMinutes} 分鐘。',
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
                const Divider(),
                Text('準備好紙筆，點下方按鈕就立即開始囉！\n加油！',
                    textAlign: TextAlign.center,
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
                            year: widget.year,
                            examName: widget.examName,
                            subject: widget.subject,
                          )));
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
