// ignore_for_file: use_build_context_synchronously

import 'package:cap_countdown/src/pages/countdown_page.dart';
import 'package:cap_countdown/src/pages/exam/exam_page.dart';
import 'package:cap_countdown/src/pages/home_page.dart';
import 'package:flutter/material.dart';
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
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/personal');
                },
                tooltip: '個人分析',
                icon: const Icon(Icons.account_circle_rounded)),
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: const Text('設定'),
                  onTap: () async {
                    await _waitPopupMenu(context);
                    if (!context.mounted) return;
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
                PopupMenuItem(
                  child: const Text('題目收藏庫'),
                  onTap: () async {
                    await _waitPopupMenu(context);
                    if (!context.mounted) return;
                    Navigator.pushNamed(context, '/favorite_questions');
                  },
                ),
                PopupMenuItem(
                  child: const Text('官方討論區'),
                  onTap: () async {
                    launchUrlString(
                        'https://github.com/SiongSng/cap-countdown/discussions');
                  },
                ),
                PopupMenuItem(
                  child: const Text('關於'),
                  onTap: () async {
                    await _waitPopupMenu(context);
                    if (!context.mounted) return;
                    Navigator.pushNamed(context, '/about');
                  },
                ),
              ],
            ),
          ],
        ),
        body: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
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
            )
          ],
        ));
  }

  Future<void> _waitPopupMenu(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
