import 'package:cap_countdown/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ChangelogDialog extends StatelessWidget {
  const ChangelogDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('有什麼新東西？'),
      scrollable: true,
      content: MarkdownBody(
          data:
              '歡迎您使用會考沙漏 ${config.appVersion} 版。  \n本次更新共包含以下新功能與修復：\n\n### * 修復翻轉螢幕時每日一題中的題目會被重置。'),
      actions: [
        TextButton(
          onPressed: () {
            localStorage.lastVersion = config.appVersion;
            Navigator.of(context).pop();
          },
          child: const Text('我知道了'),
        ),
      ],
    );
  }
}
