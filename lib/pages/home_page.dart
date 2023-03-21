import 'package:cap_countdown/exam/exam_loader.dart';
import 'package:cap_countdown/widgets/cap_time_left.dart';
import 'package:cap_countdown/widgets/question_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        CAPTimeLeft(showDetail: false),
        _DailyQuestion(),
        SizedBox(height: 25)
      ],
    );
  }
}

class _DailyQuestion extends StatefulWidget {
  const _DailyQuestion();

  @override
  State<_DailyQuestion> createState() => _DailyQuestionState();
}

class _DailyQuestionState extends State<_DailyQuestion> {
  @override
  Widget build(BuildContext context) {
    final question = ExamLoader.getRandomQuestion();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text(
                '每日一題',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Text('趁還有時間的時候來練練題目吧！'),
              const SizedBox(height: 8),
              QuestionWidget(question: question),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilledButton.icon(
                      onPressed: () {
                        final selectedChoice = question.selectedChoice;
                        final messenger = ScaffoldMessenger.of(context);
                        messenger.clearSnackBars();

                        if (selectedChoice == null) {
                          messenger.showSnackBar(
                            const SnackBar(
                              content: Text('交卷前請先記得選擇答案喔！',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              backgroundColor: Colors.orange,
                            ),
                          );
                          return;
                        }

                        if (selectedChoice.answer == question.correctAnswer) {
                          messenger.showSnackBar(
                            const SnackBar(
                              content: Text('恭喜你答對了！'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else {
                          messenger.showSnackBar(
                            const SnackBar(
                              content: Text('答錯了，再接再厲！'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.check),
                      label: const Text('交卷')),
                  FilledButton.icon(
                      onPressed: () {
                        setState(() {
                          question.selectedChoice = null;
                        });
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('再來一題')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
