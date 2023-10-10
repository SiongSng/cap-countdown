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
                    '## 有什麼新鮮事？\n### 歡迎您使用會考沙漏 **${config.appVersion}** 版～  \n### 本次更新共包含以下內容：\n\n* 新增 110 數學科題庫與詳解\n* 修正 112 自然科部份題目之參考答案誤值\n* 修正部份使用者回報的題目錯誤'),
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
