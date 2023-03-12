import 'package:cap_countdown/config/config_helper.dart';
import 'package:cap_countdown/config/config_instance.dart';
import 'package:cap_countdown/exam/exam_loader.dart';
import 'package:cap_countdown/pages/countdown_page.dart';
import 'package:cap_countdown/pages/exam.dart';
import 'package:cap_countdown/pages/home_page.dart';
import 'package:flutter/material.dart';

final ConfigInstance config = ConfigInstance();

void main() {
  _run();
}

Future<void> _run() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigHelper.init();
  await ExamLoader.load();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '會考倒數',
      theme: ThemeData(
        brightness:
            WidgetsFlutterBinding.ensureInitialized().window.platformBrightness,
        fontFamily: 'NotoSansTC',
        fontFamilyFallback: const ['NotoSansTC'],
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    const pages = <Widget>[
      CountdownPage(),
      HomePage(),
      ExamPage(),
    ];

    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset('assets/images/logo.png', width: 40, height: 40),
              const SizedBox(width: 8),
              const Text('會考倒數'),
            ],
          ),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => const [
                PopupMenuItem(
                  child: Text('設定'),
                ),
                PopupMenuItem(
                  child: Text('關於'),
                ),
              ],
            ),
          ],
        ),
        body: pages[selectedIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (value) {
            setState(() {
              selectedIndex = value;
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
