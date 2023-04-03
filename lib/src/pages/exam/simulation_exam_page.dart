import 'dart:async';

import 'package:cap_countdown/src/exam/exam_subject.dart';
import 'package:cap_countdown/src/widgets/subject_question_view.dart';
import 'package:flutter/material.dart';

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
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final questions = widget.subject.questions;

    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
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
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          },
                          child: const Text('確定'),
                        ),
                      ],
                    );
                  });
            },
          ),
          title: Text(widget.examName),
        ),
        body: Column(
          children: [
            TestTimer(
              duration: widget.subject.duration,
              onTimerFinished: () {},
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemBuilder: (context, index) {
                  final question = questions[index];

                  return SingleChildScrollView(
                      child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SubjectQuestionView(
                        question: question, showQuestionNumber: true),
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
              child: Row(
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
            ),
          ],
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
          width: 45.0,
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

class TestTimer extends StatefulWidget {
  final Duration duration;
  final void Function() onTimerFinished;

  const TestTimer({
    super.key,
    required this.duration,
    required this.onTimerFinished,
  });

  @override
  State<TestTimer> createState() => _TestTimerState();
}

class _TestTimerState extends State<TestTimer> {
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
          widget.onTimerFinished();
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
