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
              '歡迎您使用會考沙漏 ${config.appVersion} 版，本次更新共包含以下新功能與修復：\n\n## 新功能\n### - 個人分析頁面，快速了解今日答對率、共作答的題目數量與其他豐富的統計資料。\n### - 現在在首頁可以透過左右滑動切換分頁了！\n## 改善\n### - 回報題目錯誤時的題號更佳精確。\n### - 網頁版在載入中的時候會明確標示正在載入的文字訊息。\n## 修復\n### - 數個題目的圖片缺失或選項、文字內容有誤。\n### - 因時區關係，導致距離會考的剩餘時間有誤。'),
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
