import 'package:cap_countdown/config/config_helper.dart';
import 'package:cap_countdown/config/config_instance.dart';
import 'package:cap_countdown/exam/exam_loader.dart';
import 'package:cap_countdown/pages/main_page.dart';
import 'package:cap_countdown/pages/settings_page.dart';
import 'package:cap_countdown/widgets/theme_provider.dart';

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
    return ThemeProvider(builder: (context, themeData) {
      return MaterialApp(
        title: '會考沙漏',
        theme: themeData,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/settings':
              return MaterialPageRoute(
                builder: (context) => const SettingsPage(),
              );
            default:
              return MaterialPageRoute(
                builder: (context) => const MainPage(),
              );
          }
        },
        initialRoute: '/',
      );
    });
  }
}
