import 'package:cap_countdown/exam/exam_loader.dart';
import 'package:flutter/material.dart';

class ExamPage extends StatefulWidget {
  const ExamPage({super.key});

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  final examScope = ExamLoader.exams.map((e) => e.name);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text('本頁面還在製作中～'),
              const SizedBox(height: 8),
              DropdownMenu<String>(
                  label: const Text('試題範圍'),
                  initialSelection: 'all',
                  dropdownMenuEntries: [
                    const DropdownMenuEntry(label: '全部', value: 'all'),
                    ...examScope
                        .map((e) => DropdownMenuEntry(label: e, value: e))
                  ]),
            ],
          ),
        ),
      ),
    ]);
  }
}
