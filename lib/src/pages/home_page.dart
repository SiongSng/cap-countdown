import 'package:cap_countdown/src/exam/exam_loader.dart';
import 'package:cap_countdown/src/exam/group_choice_question.dart';
import 'package:cap_countdown/src/exam/optional_question.dart';
import 'package:cap_countdown/src/exam/single_choice_question.dart';
import 'package:cap_countdown/src/widgets/cap_time_left.dart';
import 'package:cap_countdown/src/widgets/optional_question_view.dart';
import 'package:cap_countdown/src/widgets/question_image.dart';
import 'package:cap_countdown/src/widgets/question_text.dart';
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
        SizedBox(height: 25)
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
              Builder(builder: (context) {
                if (question is SingleChoiceQuestion) {
                  return _buildSingleChoice(context, question);
                } else if (question is GroupChoiceQuestion) {
                  return _buildGroupChoice(context, question);
                } else {
                  throw Exception("Unknown question type");
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGroupChoice(BuildContext context, GroupChoiceQuestion question) {
    final description = question.description;
    final imageFileName = question.image;

    return Column(
      children: [
        if (description != null) QuestionText(text: description),
        if (imageFileName != null) ...[
          const SizedBox(height: 8),
          QuestionImage(imageFileName: imageFileName),
          const SizedBox(height: 8)
        ],
        for (final entry in question.options.asMap().entries)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${entry.key + 1}.',
                  style: Theme.of(context).textTheme.titleLarge),
              OptionalQuestionView(question: entry.value),
            ],
          ),
        const SizedBox(height: 8),
        _submitAnswer(question.options, context)
      ],
    );
  }

  Widget _buildSingleChoice(
      BuildContext context, SingleChoiceQuestion question) {
    return Column(
      children: [
        OptionalQuestionView(question: question),
        const SizedBox(height: 8),
        _submitAnswer([question], context)
      ],
    );
  }

  Widget _submitAnswer(List<OptionalQuestion> questions, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FilledButton.icon(
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
                    content:
                        Text(questions.length > 1 ? '恭喜你全都答對了！' : '恭喜你答對了！'),
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
                for (final q in questions) {
                  q.submitted = true;
                }
              });
            },
            icon: const Icon(Icons.check),
            label: const Text('交卷')),
        FilledButton.icon(
            onPressed: () {
              setState(() {
                for (final q in questions) {
                  q.selectedChoice = null;
                  q.submitted = false;
                }
              });
            },
            icon: const Icon(Icons.refresh),
            label: const Text('再來一題')),
      ],
    );
  }
}
