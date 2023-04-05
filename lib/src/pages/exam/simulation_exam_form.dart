import 'package:cap_countdown/src/exam/exam.dart';
import 'package:cap_countdown/src/exam/exam_loader.dart';
import 'package:cap_countdown/src/exam/exam_subject.dart';
import 'package:flutter/material.dart';

import 'paper_simulation_exam_page.dart';

class SimulationExamForm extends StatefulWidget {
  const SimulationExamForm({Key? key}) : super(key: key);

  @override
  State<SimulationExamForm> createState() => _SimulationExamFormState();
}

class _SimulationExamFormState extends State<SimulationExamForm> {
  final _exams = ExamLoader.exams.reversed.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('請選擇要測驗的年份'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                  itemCount: _exams.length,
                  itemBuilder: (context, index) {
                    final exam = _exams[index];

                    return Column(
                      children: [
                        ListTile(
                          title: Text(exam.name,
                              style: Theme.of(context).textTheme.titleLarge),
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('完成度'),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: LinearProgressIndicator(
                                      value: 0,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text('0%')
                              ],
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          tileColor: Theme.of(context).colorScheme.onSecondary,
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => _SelectSubjectDialog(
                                    context: context, exam: exam));
                          },
                        ),
                        const SizedBox(height: 12)
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class _SelectSubjectDialog extends StatefulWidget {
  final BuildContext context;
  final Exam exam;

  const _SelectSubjectDialog({
    required this.context,
    required this.exam,
  });

  @override
  State<_SelectSubjectDialog> createState() => _SelectSubjectDialogState();
}

class _SelectSubjectDialogState extends State<_SelectSubjectDialog> {
  ExamSubject? _selectedSubject;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('請選擇要測驗的科目'),
      content: Column(
          children: widget.exam.subjects
              .map((e) => RadioListTile(
                    title: Text(e.name),
                    value: e,
                    groupValue: _selectedSubject,
                    onChanged: (value) {
                      setState(() {
                        _selectedSubject = value;
                      });
                    },
                  ))
              .toList()),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: () {
            if (_selectedSubject == null) return;

            Navigator.of(context).pop();
            Navigator.of(widget.context).push(
              MaterialPageRoute(
                builder: (context) => PrepareSimulationExamPage(
                    year: widget.exam.year,
                    examName: widget.exam.name,
                    subject: _selectedSubject!),
              ),
            );
          },
          child: const Text('確定'),
        ),
      ],
      scrollable: true,
    );
  }
}
