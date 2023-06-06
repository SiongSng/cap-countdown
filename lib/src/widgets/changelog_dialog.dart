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
              '歡迎您使用會考沙漏 ${config.appVersion} 版。  \n本次更新共包含以下新功能與修復：\n\n## 新功能\n### - 新增考後懶人包供畢業生使用，提供會考成績查詢、志願選填等資訊，在倒數頁面可找到相關按鈕。\n### - 將倒數時間改為 113 年的國中教育會考。\n### - 左右滑動選項即可劃掉該選項（排除選項），方便作答。\n\n## 修復\n### - 修正部份題目資料\n### - 倘若會考正式開始時，應顯示會考已開始的訊息，而非剩餘負幾天。'),
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
