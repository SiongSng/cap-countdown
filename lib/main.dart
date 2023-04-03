import 'package:flutter/material.dart';

import 'src/config/config_helper.dart';
import 'src/config/config_instance.dart';
import 'src/exam/exam_loader.dart';
import 'src/pages/exam/simulation_exam_form.dart';
import 'src/pages/main_page.dart';
import 'src/pages/settings_page.dart';
import 'src/settings/settings.dart';
import 'src/settings/settings_instance.dart';
import 'src/widgets/theme_provider.dart';

final ConfigInstance config = ConfigInstance();
final SettingsInstance settings = SettingsInstance();

void main() {
  _run();
}

Future<void> _run() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigHelper.init();
  await SettingsHelper.init();
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
            case '/exam/simulation':
              return MaterialPageRoute(
                builder: (context) => const SimulationExamForm(),
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
