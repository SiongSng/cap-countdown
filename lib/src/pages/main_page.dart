// ignore_for_file: use_build_context_synchronously

import 'package:cap_countdown/src/pages/countdown_page.dart';
import 'package:cap_countdown/src/pages/exam/exam_page.dart';
import 'package:cap_countdown/src/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 1;
  late final PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: selectedIndex);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset('assets/images/logo.png', width: 40, height: 40),
              const SizedBox(width: 8),
              const Text('會考沙漏'),
            ],
          ),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: const Text('設定'),
                  onTap: () async {
                    await Future.delayed(const Duration(milliseconds: 200));
                    if (!context.mounted) return;

                    Navigator.pushNamed(context, '/settings');
                  },
                ),
                PopupMenuItem(
                  child: const Text('關於'),
                  onTap: () async {
                    await Future.delayed(const Duration(milliseconds: 200));
                    if (!context.mounted) return;

                    showAboutDialog(
                        context: context,
                        applicationName: '會考沙漏',
                        applicationVersion: '0.1.0',
                        children: [
                          const Text(
                              '這是個具有試題等豐富功能的會考沙漏計時器\n此外，手機版如果覺得看題目的圖片太小，可以直接用手去縮放，像是 Instagram 一樣。'),
                          const Divider(),
                          const Text(
                              '本應用程式的程式碼皆採用 GNU General Public License v3.0 (GPL-3.0) 授權條款釋出。'),
                          const Text(
                              '本應用程式內的國中教育會考歷屆試題皆來自於 國中教育會考全國試務會 與 國立臺灣師範大學心理與教育測驗研究發展中心，且本應用程式與上述兩個單位無任何關係。'),
                          const Text(
                              '本應用程式內的國中教育會考歷屆試題的詳解皆來自於 甄戰一點通，且本應用程式與上述單位無任何關係。'),
                          const Divider(),
                          Row(
                            children: [
                              const Text('開發者: '),
                              const Text('SiongSng（菘菘）'),
                              IconButton(
                                  onPressed: () {
                                    launchUrlString(
                                        'https://github.com/SiongSng/cap-countdown');
                                  },
                                  icon: const Icon(LineIcons.github))
                            ],
                          ),
                          const Text(
                              'Copyright © 2023 SiongSng All rights reserved.'),
                        ],
                        applicationIcon: Image.asset('assets/images/logo.png',
                            width: 40, height: 40));
                  },
                ),
              ],
            ),
          ],
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: const [
            CountdownPage(),
            HomePage(),
            ExamPage(),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (value) {
            setState(() {
              selectedIndex = value;
              pageController.animateToPage(value,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut);
            });
          },
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.calendar_month_outlined),
              selectedIcon: Icon(Icons.calendar_month_rounded),
              label: '倒數',
            ),
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded),
              label: '首頁',
            ),
            NavigationDestination(
              icon: Icon(Icons.quiz_outlined),
              selectedIcon: Icon(Icons.quiz_rounded),
              label: '題庫',
            ),
          ],
        ));
  }
}
