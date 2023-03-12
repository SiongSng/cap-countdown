import 'package:cap_countdown/exam/exam_loader.dart';
import 'package:cap_countdown/exam/subject_question.dart';
import 'package:cap_countdown/main.dart';
import 'package:cap_countdown/widgets/choice_button.dart';
import 'package:flutter/material.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [_TimeLeft(), _DailyQuestion(), SizedBox(height: 25)],
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
        elevation: 1,
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
              if (question.image != null)
                Builder(builder: (context) {
                  final image = Image.asset(
                    'assets/images/exam/${question.image}',
                    fit: BoxFit.fitWidth,
                    height: 150,
                  );
                  final platform = Theme.of(context).platform;

                  if (platform == TargetPlatform.android ||
                      platform == TargetPlatform.iOS) {
                    return ZoomOverlay(
                      maxScale: 5.0,
                      child: image,
                    );
                  }

                  return image;
                }),
              if (question.image != null) const SizedBox(height: 8),
              Text(
                question.description ?? '',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              _ChoiceButtons(question: question),
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
                              content: Text('交卷前請先記得選擇答案喔！'),
                              backgroundColor: Colors.orange,
                            ),
                          );
                          return;
                        }

                        if (selectedChoice.answer == question.correctAnswer) {
                          messenger.showSnackBar(
                            SnackBar(
                              content: const Text('恭喜你答對了！'),
                              backgroundColor: Colors.green,
                              action: _viewExplanationAction(context, question),
                            ),
                          );
                        } else {
                          messenger.showSnackBar(
                            SnackBar(
                              content: const Text('答錯了，再接再厲！'),
                              action: _viewExplanationAction(context, question),
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

  SnackBarAction _viewExplanationAction(
      BuildContext context, SubjectQuestion question) {
    return SnackBarAction(
      label: '看詳解',
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('詳解'),
                  content: Text(question.explanation),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('關閉'))
                  ],
                ));
      },
    );
  }
}

class _ChoiceButtons extends StatefulWidget {
  final SubjectQuestion question;

  const _ChoiceButtons({required this.question});

  @override
  State<_ChoiceButtons> createState() => _ChoiceButtonsState();
}

class _ChoiceButtonsState extends State<_ChoiceButtons> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children: widget.question.choices
          .map((e) => ChoiceButton(
                choice: e,
                selectedChoice: widget.question.selectedChoice,
                onChanged: (value) {
                  setState(() {
                    widget.question.selectedChoice = value;
                  });
                },
              ))
          .toList(),
    );
  }
}

class _TimeLeft extends StatelessWidget {
  const _TimeLeft();

  @override
  Widget build(BuildContext context) {
    int day = config.capStartTime.difference(DateTime.now()).inDays;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                '距離會考只剩下',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: day.toString(),
                  style: TextStyle(
                      fontSize: 85.5,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black),
                ),
                TextSpan(
                  text: '天',
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ])),
            ],
          ),
        ),
      ),
    );
  }
}
