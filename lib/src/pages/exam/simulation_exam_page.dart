import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:cap_countdown/main.dart';
import 'package:cap_countdown/src/exam/cap_subject.dart';
import 'package:cap_countdown/src/exam/exam_subject.dart';
import 'package:cap_countdown/src/exam/group_choice_question.dart';
import 'package:cap_countdown/src/exam/question_meta.dart';
import 'package:cap_countdown/src/exam/question_record.dart';
import 'package:cap_countdown/src/exam/single_choice_question.dart';
import 'package:cap_countdown/src/exam/subject_question.dart';
import 'package:cap_countdown/src/widgets/optional_question_view.dart';
import 'package:cap_countdown/src/widgets/subject_question_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/question_text.dart';

class SimulationExamPage extends StatefulWidget {
  final int year;
  final String examName;
  final ExamSubject subject;

  const SimulationExamPage(
      {Key? key,
      required this.year,
      required this.examName,
      required this.subject})
      : super(key: key);

  @override
  State<SimulationExamPage> createState() => _SimulationExamPageState();
}

class _SimulationExamPageState extends State<SimulationExamPage> {
  final _pageController = PageController();

  int _currentPage = 0;
  bool _submitted = false;
  late bool _disablePageChange;

  @override
  void initState() {
    _disablePageChange =
        widget.subject.subjectId == CAPSubject.englishListening;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final questions = widget.subject.questions;
    final question = questions[_currentPage];
    final isFavorite =
        localStorage.questionRecords[question.hash]?.isFavorite ?? false;
    final tookNote = localStorage.questionRecords[question.hash]?.note != null;

    return WillPopScope(
      onWillPop: () async {
        // Prevent using system navigation to leave this page.
        _showBackDialog();

        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.examName, style: const TextStyle(fontSize: 18)),
            actions: [
              IconButton(
                  onPressed: () {
                    _showNoteDialog(question);
                  },
                  icon: tookNote
                      ? Icon(Icons.draw_rounded,
                          color: Theme.of(context).colorScheme.primary)
                      : const Icon(Icons.draw_outlined),
                  tooltip: '做筆記'),
              IconButton(
                  onPressed: () {
                    if (isFavorite) {
                      question.removeFromFavorite();
                    } else {
                      question.addToFavorite();
                    }
                    setState(() {});
                  },
                  icon: isFavorite
                      ? const Icon(Icons.favorite, color: Colors.red)
                      : const Icon(Icons.favorite_border),
                  tooltip: isFavorite ? '取消收藏' : '加入收藏'),
            ],
            leading: BackButton(
              onPressed: () {
                _showBackDialog();
              },
            ),
          ),
          body: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                if (!_submitted)
                  ExamTimer(
                    duration: widget.subject.duration,
                    onExamOver: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('警告'),
                              content: const Text('考試時間已到，請勿繼續作答！'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      _submit();
                                    },
                                    child: const Text('確定'))
                              ],
                            );
                          });
                    },
                  ),
                const SizedBox(
                  width: 20,
                ),
                if (widget.subject.subjectId == CAPSubject.math)
                  InkWell(
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          child: const Column(
                            children: [Icon(Icons.list), Text("數學公式")],
                          )),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                insetPadding: const EdgeInsets.all(10),
                                contentPadding: const EdgeInsets.all(10),
                                title: ListTile(
                                    title: const Text('數學公式'),
                                    leading: const Icon(Icons.list),
                                    shape:
                                        Border.all(color: Colors.transparent)),
                                content: const SingleChildScrollView(
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("📖"),
                                            Column(children: [
                                              QuestionText(
                                                  text:
                                                      "和的平方公式：\$(a+b)^2\$\$=a^2\$\$+2ab\$\$+b^2\$"),
                                              QuestionText(
                                                  text:
                                                      "差的平方公式：\$(a-b)^2\$\$=a^2\$\$-2ab\$\$+b^2\$"),
                                              QuestionText(
                                                  text:
                                                      "平方差公式：\$a^2-b^2\$\$=(a+b)(a-b)\$"),
                                            ])
                                          ]),
                                      QuestionText(
                                          text:
                                              "📖若直角三角形兩股長為 \$a\$ 、 \$b\$，斜邊長為 \$c\$，則 \$c^2\$\$=a^2\$\$+b^2\$"),
                                      QuestionText(
                                          text:
                                              "📖若圓的半徑為 \$r\$,圓周率為 \$\\pi\$,則圓面積 \$=\\pi r^2\$，圓周長 \$=2 \\pi r\$"),
                                      QuestionText(
                                          text:
                                              "📖凸 n 邊形的內角和為 \$(n − 2)\$\$ \\times 180^\\circ\$ ， \$n \\geq 3\$"),
                                      QuestionText(
                                          text:
                                              "📖若一個等差數列的首項為 \$a_1\$，公差為 \$d\$，第 \$n\$ 項為 \$a_n\$,前 \$n\$ 項和為 \$S_n\$，則 \$a_n\$\$ = a_1 \$\$+ (n − 1) d\$，\$S_n\$\$ =\\frac{n (a_1 + a_n)}{2}\$"),
                                      QuestionText(
                                          text:
                                              "📖若一個等比數列的首項為 \$a_1\$，公比為 \$r\$，第 \$n\$ 項為 \$a_n\$，則 \$a_n\$ \$= a_1r^{n − 1}\$"),
                                      QuestionText(
                                          text:
                                              "📖一元二次方程式 \$ax^2 \$\$+ bx \$\$+ c \$\$= 0\$ 的解為 \$x \$\$=\\frac{ −b\\pm \\sqrt{b^2 − 4ac}}{2a}\$")
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
                      })
              ]),
              if (_submitted) GradeMarkings(subject: widget.subject),
              const Divider(),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: questions.length,
                  physics: _disablePageChange
                      ? const NeverScrollableScrollPhysics()
                      : null,
                  itemBuilder: (context, index) {
                    final question = questions[index];

                    return _QuestionPage(
                      question: question,
                      meta: QuestionMeta(
                          year: widget.year,
                          subjectId: widget.subject.subjectId,
                          questionIndex: index,
                          questionNumber: question.questionNumber),
                      option: QuestionViewOption(
                          showQuestionNumber: true,
                          submitted: _submitted,
                          onlyPlayAudioOnce: !_submitted,
                          onAudioPlayStateChanged: (state) {
                            setState(() {
                              _disablePageChange = state == PlayerState.playing;
                            });
                          }),
                    );
                  },
                  onPageChanged: (page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    if (!_submitted && _currentPage == questions.length - 1)
                      _buildSubmitButton(),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_disablePageChange) return;
                              _pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut);
                            },
                            style: ElevatedButton.styleFrom(
                                foregroundColor:
                                    _disablePageChange || _currentPage == 0
                                        ? Theme.of(context).disabledColor
                                        : null),
                            child: const Text('上一題'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        QuestionNumberIndicator(
                          currentPage: _currentPage,
                          subject: widget.subject,
                          enable: !_disablePageChange,
                          onPageChanged: (page) {
                            final isEnglishListening =
                                widget.subject.subjectId ==
                                    CAPSubject.englishListening;

                            // When the exam subject is English listening, disable the animation page change.
                            // Because if there is animation, the audio will be played when passing through each page.
                            if (isEnglishListening) {
                              _pageController.jumpToPage(page);
                              return;
                            }

                            _pageController.animateToPage(page,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                          },
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_disablePageChange) return;
                              if (_currentPage == questions.length - 1) return;

                              _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut);
                            },
                            style: ElevatedButton.styleFrom(
                                foregroundColor: _disablePageChange
                                    ? Theme.of(context).disabledColor
                                    : null),
                            child: const Text('下一題'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  FloatingActionButton _buildSubmitButton() {
    return FloatingActionButton.extended(
        onPressed: () {
          final optionalQuestions = widget.subject.getOptionalQuestions();

          if (optionalQuestions.any((q) => q.selectedChoice == null)) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('確認交卷'),
                    content:
                        const Text('您尚有未作答的題目，您仍然要交卷嗎？\n還有一些時間，建議您可以繼續作答。'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('取消')),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _submit();
                          },
                          child: const Text('確定'))
                    ],
                  );
                });

            return;
          }

          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('確認交卷'),
                  content: const Text('您確定要交卷了嗎？\n還有一些時間，建議您可以先檢查看看再交卷。'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('取消')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _submit();
                        },
                        child: const Text('確定'))
                  ],
                );
              });
        },
        icon: const Icon(Icons.done_rounded),
        label: const Text('交卷'));
  }

  void _showBackDialog() {
    if (_submitted) {
      widget.subject.clearSelectRecords();
      Navigator.of(context).popUntil((route) => route.isFirst);
      return;
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('確定要離開嗎？'),
            content: const Text('這將會清除本次的作答紀錄。'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('取消'),
              ),
              TextButton(
                onPressed: () {
                  widget.subject.clearSelectRecords();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text('確定'),
              ),
            ],
          );
        });
  }

  void _submit() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('智慧老師正在為您批改考卷...'),
              content:
                  Lottie.asset('assets/animations/135507-exam-prep-topics.json',
                      onLoaded: (composition) async {
                await Future.delayed(const Duration(milliseconds: 2800));
                if (mounted) {
                  setState(() {
                    _submitted = true;

                    final optionalQuestions =
                        widget.subject.getOptionalQuestions();
                    for (final question in optionalQuestions) {
                      question.makeAsAnswered();
                    }
                  });
                  Navigator.of(context).pop();
                }
              }),
            ));
  }

  void _showNoteDialog(SubjectQuestion question) {
    final records = localStorage.questionRecords;
    QuestionRecord? record = records[question.hash] ?? const QuestionRecord();
    final noteController = TextEditingController(text: record.note ?? '');

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('筆記'),
            content: TextField(
              controller: noteController,
              maxLines: null,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: '請輸入筆記'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('取消'),
              ),
              TextButton(
                onPressed: () {
                  final text = noteController.text;
                  records[question.hash] =
                      record.copyWith(note: text.isEmpty ? null : text);
                  localStorage.questionRecords = records;

                  Navigator.of(context).pop();
                  setState(() {});
                },
                child: const Text('確定'),
              ),
            ],
          );
        });
  }
}

class _QuestionPage extends StatefulWidget {
  const _QuestionPage({
    required this.question,
    required this.meta,
    required this.option,
  });

  final SubjectQuestion question;
  final QuestionMeta meta;
  final QuestionViewOption option;

  @override
  State<_QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<_QuestionPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SubjectQuestionView(
        question: widget.question,
        meta: widget.meta,
        option: widget.option,
      ),
    ));
  }

  @override
  bool get wantKeepAlive => true;
}

class QuestionNumberIndicator extends StatefulWidget {
  final int currentPage;
  final ExamSubject subject;
  final bool enable;
  final void Function(int page) onPageChanged;

  const QuestionNumberIndicator(
      {super.key,
      required this.currentPage,
      required this.subject,
      required this.enable,
      required this.onPageChanged});

  @override
  State<QuestionNumberIndicator> createState() =>
      _QuestionNumberIndicatorState();
}

class _QuestionNumberIndicatorState extends State<QuestionNumberIndicator> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();

    _textEditingController = TextEditingController(text: _getQuestionNumber());
  }

  String _getQuestionNumber() {
    final question = widget.subject.questions[widget.currentPage];
    return question.questionNumber;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant QuestionNumberIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    _textEditingController.text = _getQuestionNumber();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge;
    final optionalQuestions = widget.subject.getOptionalQuestions();

    return Row(
      children: [
        SizedBox(
          height: 45,
          width: 55,
          child: TextField(
            controller: _textEditingController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            enabled: widget.enable,
            onSubmitted: (value) {
              final inputPage =
                  (int.tryParse(value) ?? 1).clamp(1, optionalQuestions.length);

              int page = widget.subject.questions.indexWhere((question) {
                if (question is SingleChoiceQuestion) {
                  return question.number == inputPage;
                } else if (question is GroupChoiceQuestion) {
                  return question.options.any((e) => e.number == inputPage);
                } else {
                  return false;
                }
              });

              widget.onPageChanged(page);
              setState(() {
                _textEditingController.text = _getQuestionNumber();
              });
            },
          ),
        ),
        Text(' / ${optionalQuestions.length}', style: textStyle),
      ],
    );
  }
}

class ExamTimer extends StatefulWidget {
  final Duration duration;
  final void Function() onExamOver;

  const ExamTimer({
    super.key,
    required this.duration,
    required this.onExamOver,
  });

  @override
  State<ExamTimer> createState() => _ExamTimerState();
}

class _ExamTimerState extends State<ExamTimer> {
  late Timer _timer;
  Duration _remainingTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.duration;
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime = widget.duration - Duration(seconds: timer.tick);
        if (_remainingTime <= Duration.zero) {
          _timer.cancel();
          widget.onExamOver();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final hours = _remainingTime.inHours.remainder(24);
    final minutes = _remainingTime.inMinutes.remainder(60);
    final seconds = _remainingTime.inSeconds.remainder(60);
    Color? textColor;

    if (_remainingTime.inMinutes <= 5) {
      textColor = Colors.red;
    } else if (_remainingTime.inMinutes <= 10) {
      textColor = Colors.orange;
    } else if (_remainingTime.inMinutes <= 15) {
      textColor = Colors.yellow;
    }

    return Text(
      '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
      style:
          Theme.of(context).textTheme.headlineLarge?.copyWith(color: textColor),
    );
  }
}

class GradeMarkings extends StatelessWidget {
  final ExamSubject subject;

  const GradeMarkings({Key? key, required this.subject}) : super(key: key);

  Text _getGradeMarkingText(BuildContext context, int correctCount, int total) {
    final chart = subject.gradeMarkings;
    final String gradeMarking;
    if (subject.subjectId == CAPSubject.math) {
      final percentage = (correctCount / total) * 100;
      gradeMarking = chart.entries
          .firstWhere((entry) => percentage >= entry.value,
              orElse: () => chart.entries.last)
          .key;
    } else {
      gradeMarking = chart.entries
          .firstWhere((entry) => correctCount >= entry.value,
              orElse: () => chart.entries.last)
          .key;
    }

    final Color color;

    // https://cap.rcpet.edu.tw/score3.html
    if (subject.subjectId == CAPSubject.englishListening &&
        gradeMarking.contains('基礎')) {
      color = Colors.green;
    } else if (gradeMarking.contains('A') || gradeMarking.contains('精熟')) {
      color = Colors.green;
    } else if (gradeMarking.contains('B+') || gradeMarking.contains('基礎')) {
      color = Colors.blue;
    } else if (gradeMarking.contains('B')) {
      color = Colors.orange;
    } else if (gradeMarking.contains('C') || gradeMarking.contains('待加強')) {
      color = Colors.red;
    } else {
      color = Colors.white;
    }

    return Text(gradeMarking,
        style: Theme.of(context)
            .textTheme
            .displayMedium
            ?.copyWith(color: color, fontWeight: FontWeight.bold));
  }

  @override
  Widget build(BuildContext context) {
    final allQuestion = subject.getOptionalQuestions();
    final correctCount = allQuestion.where((q) => q.isCorrect).length;
    final textStyle = Theme.of(context).textTheme.bodyLarge;

    return Column(
      children: [
        Text('等級加標示', style: textStyle),
        _getGradeMarkingText(context, correctCount, allQuestion.length),
        Text('答對題數（$correctCount / ${allQuestion.length}）', style: textStyle),
        Text('記得看看詳解了解問題，加油！', style: textStyle),
      ],
    );
  }
}
