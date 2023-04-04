import 'package:flutter/material.dart';

import 'src/config/config_helper.dart';
import 'src/config/config_instance.dart';
import 'src/exam/exam_loader.dart';
import 'src/pages/exam/simulation_exam_form.dart';
import 'src/pages/favorite_questions_page.dart';
import 'src/pages/main_page.dart';
import 'src/pages/settings_page.dart';
import 'src/storage/local_storage.dart';
import 'src/storage/storage.dart';
import 'src/widgets/theme_provider.dart';

final ConfigInstance config = ConfigInstance();
final LocalStorage localStorage = LocalStorage();

void main() {
  _run();
}

Future<void> _run() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigHelper.init();
  await StorageHelper.init();
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
            case '/favorite_questions':
              return MaterialPageRoute(
                builder: (context) => const FavoriteQuestionsPage(),
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
