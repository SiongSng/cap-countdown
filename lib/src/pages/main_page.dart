// ignore_for_file: use_build_context_synchronously

import 'package:cap_countdown/main.dart';
import 'package:cap_countdown/src/pages/countdown_page.dart';
import 'package:cap_countdown/src/pages/exam/exam_page.dart';
import 'package:cap_countdown/src/pages/home_page.dart';
import 'package:cap_countdown/src/pages/personal_page.dart';
import 'package:cap_countdown/src/pages/settings_page.dart';
import 'package:cap_countdown/src/util/layout.dart';
import 'package:cap_countdown/src/widgets/changelog_dialog.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 1;
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: selectedIndex);

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final lastVersion = localStorage.lastVersion;
      final hasNewVersion =
          lastVersion == null || lastVersion != config.appVersion;

      if (hasNewVersion && context.mounted) {
        showDialog(
            context: context, builder: (context) => const ChangelogDialog());
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(builder: (context, breakpoint) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset('assets/images/logo.png', width: 40, height: 40),
              const SizedBox(width: 8),
              const Column(
                children: [
                  Text('會考沙漏'),
                  SizedBox(height: 4),
                ],
              ),
            ],
          ),
          actions: [
            breakpoint.isPhone ? _buildPhoneActions() : _buildPadActions(),
          ],
          scrolledUnderElevation: 0,
        ),
        body: breakpoint.isPhone
            ? _buildPageView(breakpoint)
            : _buildPadBody(breakpoint),
        bottomNavigationBar: Builder(
          builder: (context) {
            if (!breakpoint.isPhone) return const SizedBox.shrink();

            return _buildPhoneNavBar();
          },
        ),
        floatingActionButton: Builder(builder: (context) {
          if (!breakpoint.isPhone) return const SizedBox.shrink();

          return _buildPracticeButton();
        }),
      );
    });
  }

  FloatingActionButton _buildPracticeButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/exam/simulation');
      },
      tooltip: '開始練習試題',
      child: const Icon(Icons.edit_outlined),
    );
  }

  NavigationBar _buildPhoneNavBar() {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: (value) => changePage(value),
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
    );
  }

  Row _buildPadBody(LayoutBreakpoint breakpoint) {
    return Row(children: [
      NavigationRail(
          leading: _buildPracticeButton(),
          destinations: const [
            NavigationRailDestination(
                icon: Icon(Icons.calendar_month_outlined),
                selectedIcon: Icon(Icons.calendar_month_rounded),
                label: Text('倒數')),
            NavigationRailDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_rounded),
                label: Text('首頁')),
            NavigationRailDestination(
                icon: Icon(Icons.quiz_outlined),
                selectedIcon: Icon(Icons.quiz_rounded),
                label: Text('題庫')),
            NavigationRailDestination(
                icon: Icon(Icons.account_circle_outlined),
                selectedIcon: Icon(Icons.account_circle_rounded),
                label: Text('個人分析')),
            NavigationRailDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings_rounded),
                label: Text('設定')),
          ],
          labelType: NavigationRailLabelType.all,
          groupAlignment: 0,
          onDestinationSelected: (value) => changePage(value),
          selectedIndex: selectedIndex),
      Expanded(child: _buildPageView(breakpoint))
    ]);
  }

  Row _buildPadActions() {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/favorite_questions');
            },
            tooltip: '題目收藏庫',
            icon: const Icon(Icons.bookmarks_outlined)),
        IconButton(
            onPressed: () {
              launchUrlString(
                  'https://github.com/SiongSng/cap-countdown/discussions');
            },
            tooltip: '官方討論區',
            icon: const Icon(Icons.forum_outlined)),
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/about');
            },
            tooltip: '關於我們',
            icon: const Icon(Icons.info_outline_rounded))
      ],
    );
  }

  Row _buildPhoneActions() {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/personal');
            },
            tooltip: '個人分析',
            icon: const Icon(Icons.account_circle_rounded)),
        PopupMenuButton(
          tooltip: "更多",
          itemBuilder: (context) => [
            PopupMenuItem(
              child: const Text('設定'),
              onTap: () async {
                await _waitPopupMenu();
                if (!context.mounted) return;
                Navigator.pushNamed(context, '/settings');
              },
            ),
            PopupMenuItem(
              child: const Text('題目收藏庫'),
              onTap: () async {
                await _waitPopupMenu();
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
                await _waitPopupMenu();
                if (!context.mounted) return;
                Navigator.pushNamed(context, '/about');
              },
            ),
          ],
        ),
      ],
    );
  }

  PageView _buildPageView(LayoutBreakpoint breakpoint) {
    if (pageController.positions.isNotEmpty) {
      pageController.dispose();

      if (breakpoint.isPhone && selectedIndex > 2) {
        // Because the NavigationBar in phone mode only has 3 items.
        selectedIndex = 1;
      }

      pageController = PageController(initialPage: selectedIndex);
    }

    return PageView(
      controller: pageController,
      scrollDirection: breakpoint.isPhone ? Axis.horizontal : Axis.vertical,
      onPageChanged: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
      children: breakpoint.isPhone
          ? const [CountdownPage(), HomePage(), ExamPage()]
          : const [
              CountdownPage(),
              HomePage(),
              ExamPage(),
              PersonalPage(),
              SettingsPage()
            ],
    );
  }

  void changePage(int page) {
    setState(() {
      pageController.animateToPage(page,
          duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    });
  }

  Future<void> _waitPopupMenu() async {
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
