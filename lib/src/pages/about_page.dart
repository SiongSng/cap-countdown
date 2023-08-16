import 'package:cap_countdown/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          Image.asset('assets/images/logo.png', width: 40, height: 40),
          const SizedBox(width: 8),
          const Text('關於會考沙漏'),
        ],
      )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('應用程式版本：${config.appVersion}'),
              const Text(
                  '這是個具有試題等豐富功能的會考沙漏計時器\n此外完全免費、無廣告，超佛心的吧！\n也歡迎您加入我們的官方討論區提供建議或者一起聊天～'),
              Row(
                children: [
                  const Text('開發者: '),
                  const Text('SiongSng（菘菘）、Myster#7494、HACO'),
                  IconButton(
                      onPressed: () {
                        launchUrlString(
                            'https://github.com/SiongSng/cap-countdown');
                      },
                      icon: const Icon(LineIcons.github))
                ],
              ),
              ExpansionTile(
                title: const Text('授權與版權資訊'),
                shape: Border.all(color: Colors.transparent),
                children: [
                  MarkdownBody(
                      data:
                          '- 本應用程式的程式碼皆採用 [GNU General Public License v3.0 (GPL-3.0)](https://www.gnu.org/licenses/gpl-3.0.html) 授權條款釋出。\n- 本應用程式內的國中教育會考歷屆試題（含聽力音檔）皆來自於 [國中教育會考全國試務會](https://cap.rcpet.edu.tw/NEAC/About/About) 與 [國立臺灣師範大學心理與教育測驗研究發展中心](https://rcpet.edu.tw/)，且本應用程式與上述兩個單位無任何關係。\n- 本應用程式內的國中教育會考歷屆試題的部份詳解來自於 [甄戰一點通](https://www.reallygood.com.tw/newExam/inside?str=F7229F6ADD9F230A5FB41A782B73F2A0)，其餘則由開發者自行撰寫，且本應用程式與上述單位無任何關係。',
                      onTapLink: (text, href, title) {
                        if (href == null) return;
                        launchUrlString(href);
                      }),
                  TextButton(
                      onPressed: () {
                        showLicensePage(
                            context: context,
                            applicationVersion: config.appVersion.toString());
                      },
                      child: const Text('看看我們用來造出「會考沙漏」的開放原始碼函式庫'))
                ],
              ),
              const Divider(),
              const Text('Copyright © 2023 SiongSng All rights reserved.'),
            ],
          ),
        ),
      ),
    );
  }
}
