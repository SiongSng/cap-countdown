import 'dart:async';

import 'package:cap_countdown/main.dart';
import 'package:cap_countdown/src/exam/exam_subject.dart';
import 'package:cap_countdown/src/widgets/optional_question_view.dart';
import 'package:cap_countdown/src/widgets/subject_question_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SimulationExamPage extends StatefulWidget {
  final String examName;
  final ExamSubject subject;

  const SimulationExamPage(
      {Key? key, required this.examName, required this.subject})
      : super(key: key);

  @override
  State<SimulationExamPage> createState() => _SimulationExamPageState();
}

class _SimulationExamPageState extends State<SimulationExamPage> {
  final _pageController = PageController();

  int _currentPage = 0;
  bool _submitted = false;

  @override
  Widget build(BuildContext context) {
    final questions = widget.subject.questions;
    final question = questions[_currentPage];
    final isFavorite = localStorage.favoriteQuestions.contains(question);

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
                  onPressed: () {},
                  icon: const Icon(Icons.draw_outlined),
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
                      ? const Icon(Icons.favorite)
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
              if (_submitted) GradeMarkings(subject: widget.subject),
              const Divider(),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    final question = questions[index];

                    return SingleChildScrollView(
                        child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SubjectQuestionView(
                        question: question,
                        option: QuestionViewOption(
                            showQuestionNumber: true, submitted: _submitted),
                      ),
                    ));
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
                              _pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut);
                            },
                            child: const Text('上一題'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // page indicator beautify
                        PageIndicator(
                          currentPage: _currentPage,
                          totalPages: questions.length,
                          onPageChanged: (page) {
                            _pageController.animateToPage(page,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                          },
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_currentPage < questions.length - 1) {
                                _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut);
                              }
                            },
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
      widget.subject.clearRecords();
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
                  widget.subject.clearRecords();
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
                  });
                  Navigator.of(context).pop();
                }
              }),
            ));
  }
}

class PageIndicator extends StatefulWidget {
  final int currentPage;
  final int totalPages;
  final void Function(int page)? onPageChanged;

  const PageIndicator(
      {super.key,
      required this.currentPage,
      required this.totalPages,
      this.onPageChanged});

  @override
  State<PageIndicator> createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  late TextEditingController _textEditingController;
  int _inputPage = 1;

  @override
  void initState() {
    super.initState();
    _textEditingController =
        TextEditingController(text: '${widget.currentPage + 1}');
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant PageIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentPage != oldWidget.currentPage) {
      _textEditingController.text = '${widget.currentPage + 1}';
      _inputPage = widget.currentPage + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge;

    return Row(
      children: [
        SizedBox(
          height: 45,
          width: 45,
          child: TextField(
            controller: _textEditingController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            onChanged: (text) {
              _inputPage = int.tryParse(text) ?? 1;
            },
            onSubmitted: (_) {
              _inputPage = _inputPage.clamp(1, widget.totalPages);
              _textEditingController.text = '$_inputPage';
              widget.onPageChanged?.call(_inputPage - 1);
            },
          ),
        ),
        Text(' / ${widget.totalPages}', style: textStyle),
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

  Text _getGradeMarkingText(BuildContext context, int correctCount) {
    final chart = subject.gradeMarkings;
    final gradeMarking = chart.entries
        .firstWhere((entry) => correctCount >= entry.value,
            orElse: () => chart.entries.last)
        .key;
    final Color color;

    if (gradeMarking.contains('A') || gradeMarking.contains('精熟')) {
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
        _getGradeMarkingText(context, correctCount),
        Text('答對題數（$correctCount / ${allQuestion.length}）', style: textStyle),
        Text('記得看看詳解了解問題，加油！', style: textStyle),
      ],
    );
  }
}
