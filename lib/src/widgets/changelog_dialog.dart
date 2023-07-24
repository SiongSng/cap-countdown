import 'package:cap_countdown/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ChangelogDialog extends StatelessWidget {
  const ChangelogDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MarkdownBody(
                data:
                    '## 有什麼新鮮事？\n### 歡迎您使用會考沙漏 **${config.appVersion}** 版～  \n### 本次更新共包含以下內容：\n\n* 新增 112 年會考題庫\n* 支援更多的題目顯示模式，使作答體驗更為逼真\n* 在模擬歷屆試題介面中新增「數學參考公式」供參考\n* 壓縮題庫資源檔，減少安裝所需的空間\n* 修復翻轉螢幕時每日一題中的題目會被重置\n* 改善部份題目的圖片位置，避免遺漏掉資訊\n* 改善「準備模擬歷屆試題」的介面佈局'),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                localStorage.lastVersion = config.appVersion;
                Navigator.of(context).pop();
              },
              child: const Text('我知道了'),
            ),
          ],
        ),
      ),
    );
  }
}
