import 'dart:io';

import 'package:cap_countdown/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({Key? key}) : super(key: key);

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    final personalName = localStorage.personalName ?? '會考戰士';
    final records = localStorage.questionRecords;
    final todayRecords = records.entries
        .where((e) => e.value.answerHistory.any((h) =>
            h.date.isAfter(DateTime.now().subtract(const Duration(days: 1)))))
        .toList();
    final todayCorrect = todayRecords
        .where((e) => e.value.answerHistory.any((h) => h.isCorrect));
    final todayCorrectRate = todayCorrect.length / todayRecords.length * 100;

    return Scaffold(
      appBar: AppBar(
        title: const Text('個人分析'),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(children: [
                _buildAvatar(),
                const SizedBox(width: 12),
                Text(personalName,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge),
              ]),
              OutlinedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => _buildEditDialog());
                  },
                  child: const Text('編輯個人資料')),
            ],
          ),
          const SizedBox(height: 6),
          Text('統計資料',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child:
                          _buildDataCard('今日答題數', '${todayRecords.length} 題'),
                    ),
                    Expanded(
                      child: _buildDataCard(
                          '今日答對率',
                          todayCorrectRate.isNaN
                              ? '尚無資料'
                              : '${todayCorrectRate.toStringAsFixed(2)}%'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: _buildDataCard('已做過的題目',
                          '${records.entries.where((e) => e.value.answerHistory.isNotEmpty).length} 題'),
                    ),
                    Expanded(
                      child: _buildDataCard('近日答對率趨勢', 'COMING SOON'),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Card _buildDataCard(String title, String value) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(value, style: Theme.of(context).textTheme.bodyLarge)
        ],
      ),
    ));
  }

  AlertDialog _buildEditDialog() {
    return AlertDialog(
      title: const Text('編輯個人資料'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: TextEditingController(text: localStorage.personalName),
            decoration:
                const InputDecoration(labelText: '個人名稱', hintText: '請輸入您想要的名稱'),
            onChanged: (value) {
              if (value.isEmpty) {
                localStorage.personalName = null;
                return;
              }

              localStorage.personalName = value;
              setState(() {});
            },
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () async {
                    final result = await FilePicker.platform
                        .pickFiles(type: FileType.image);
                    if (result == null) {
                      return;
                    }

                    final file = result.files.single;

                    if (kIsWeb) {
                      if (file.size > 1024 * 1024 && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('個人頭貼的檔案大小不可超過 1MB')));
                        return;
                      }
                    }

                    final Uint8List bytes;

                    if (kIsWeb) {
                      bytes = file.bytes!;
                    } else {
                      bytes = File(file.path!).readAsBytesSync();
                    }

                    localStorage.personalAvatar = bytes;
                    setState(() {});
                  },
                  child: const Text('選擇個人頭貼')),
              TextButton(
                  onPressed: () {
                    localStorage.personalAvatar = null;
                    setState(() {});
                  },
                  child: const Text('移除個人頭貼'))
            ],
          )
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {});
            },
            child: const Text('完成')),
      ],
    );
  }

  Widget _buildAvatar() {
    final avatarBytes = localStorage.personalAvatar;
    if (avatarBytes == null) {
      return const Icon(Icons.account_circle_rounded, size: 120);
    }

    return ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: Image.memory(avatarBytes, width: 120, height: 120));
  }
}
