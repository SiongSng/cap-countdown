import 'package:cap_countdown/src/exam/optional_question.dart';
import 'package:cap_countdown/src/widgets/cap_time_left.dart';
import 'package:cap_countdown/src/widgets/data_provider.dart';
import 'package:cap_countdown/src/widgets/optional_question_view.dart';
import 'package:cap_countdown/src/widgets/subject_question_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ListView(
      children: const [
        CAPTimeLeft(showDetail: false),
        _DailyQuestion(),
        SizedBox(height: 75)
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _DailyQuestion extends StatefulWidget {
  const _DailyQuestion();

  @override
  State<_DailyQuestion> createState() => _DailyQuestionState();
}

class _DailyQuestionState extends State<_DailyQuestion> {
  bool _submitted = false;

  @override
  Widget build(BuildContext context) {
    final question = DataProvider.of(context).dailyQuestion;

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
              SubjectQuestionView(
                  question: question,
                  meta: question.meta,
                  option: QuestionViewOption(
                      showQuestionNumber: false, submitted: _submitted),
                  actions: (questions) => [_submitAnswer(questions)]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _submitAnswer(List<OptionalQuestion> questions) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        (!_submitted)
            ? FilledButton.icon(
                onPressed: () {
                  final isSelectAll =
                      questions.every((q) => q.selectedChoice != null);
                  final messenger = ScaffoldMessenger.of(context);
                  messenger.clearSnackBars();

                  if (!isSelectAll) {
                    messenger.showSnackBar(
                      const SnackBar(
                        content: Text('交卷前請先記得選擇答案喔！',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        backgroundColor: Colors.orange,
                      ),
                    );
                    return;
                  }

                  if (questions.every((q) => q.isCorrect)) {
                    messenger.showSnackBar(
                      SnackBar(
                        content: Text(
                            questions.length > 1 ? '恭喜你全都答對了！' : '恭喜你答對了！'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    messenger.showSnackBar(
                      const SnackBar(
                        content: Text('答錯了，再接再厲！記得看詳解修正錯誤呦！'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }

                  setState(() {
                    _submitted = true;
                    for (final q in questions) {
                      q.makeAsAnswered();
                    }
                  });
                },
                icon: const Icon(Icons.check),
                label: const Text('交卷'))
            : FilledButton.icon(
                onPressed: () {
                  setState(() {
                    _submitted = false;
                  });
                },
                icon: const Icon(Icons.visibility_off_outlined),
                label: const Text('收回交卷')),
        FilledButton.icon(
            onPressed: () {
              setState(() {
                for (final q in questions) {
                  q.selectedChoice = null;
                }
                _submitted = false;
              });

              setState(() {
                DataProvider.of(context).refreshDailyQuestion();
              });
            },
            icon: const Icon(Icons.refresh),
            label: const Text('再來一題')),
      ],
    );
  }
}
