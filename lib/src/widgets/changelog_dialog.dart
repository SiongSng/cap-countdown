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
              '歡迎您使用會考沙漏 ${config.appVersion} 版。  \n距離 112 年會考只剩下**最後一天了**，祝您**會考順利，選擇屬於自己的未來**！  \n本次更新共包含以下新功能與修復：\n\n## 新功能\n### - 改善平板等大螢幕裝置的使用者介面，操作起來更舒適！（未來還會繼續針對各種設備改善）\n### - 針對會考即將開始與開始後的倒數介面進行改善並新增許多鼓勵用語。\n### - 更人性化的倒數時間（詳見設定頁面）。\n### - 在手機版主畫面新增一個練習歷屆試題的按鈕，節省尋找按鈕的時間。\n\n## 修復\n### - 部份題目內容的小錯誤\n### - 播放英文聽力的微小修正（基於開源函式庫的新版本變更）'),
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
