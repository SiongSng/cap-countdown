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
              '歡迎您使用會考沙漏 ${config.appVersion} 版，本次更新共包含以下新功能與修復：\n\n## 修復\n### - 部份情況下無法開啟個人分析頁面\n### - 部份情況下無法收藏題目（愛心按鈕）\n### - 無法更換個人分析頁面中的頭貼'),
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
