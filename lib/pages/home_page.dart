import 'package:cap_countdown/exam/exam_loader.dart';
import 'package:cap_countdown/main.dart';
import 'package:cap_countdown/widgets/answer_button.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

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
        _TimeLeft(),
        _DailyQuestion(),
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
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                '每日一題',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              if (question.image != null)
                SizedBox(
                  width: 200,
                  height: 100,
                  child: PhotoView(
                    backgroundDecoration:
                        const BoxDecoration(color: Colors.transparent),
                    imageProvider: AssetImage(
                      'assets/images/exam/${question.image}',
                    ),
                  ),
                ),
              Text(
                question.description ?? '',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 10,
                runSpacing: 8,
                children: question.choices
                    .map((e) => AnswerButton(
                          choice: e,
                        ))
                    .toList(),
              ),
              const SizedBox(height: 8),
              FilledButton.icon(
                  onPressed: () {
                    setState(() {});
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('再來一題'))
            ],
          ),
        ),
      ),
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
                  style: const TextStyle(fontSize: 85.5),
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
