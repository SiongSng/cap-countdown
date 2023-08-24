import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:url_strategy/url_strategy.dart';

import 'src/config/config_helper.dart';
import 'src/config/config_instance.dart';
import 'src/exam/exam_loader.dart';
import 'src/pages/about_page.dart';
import 'src/pages/high_school_choice_filling_page.dart';
import 'src/pages/exam/simulation_exam_form.dart';
import 'src/pages/favorite_questions_page.dart';
import 'src/pages/main_page.dart';
import 'src/pages/personal_page.dart';
import 'src/pages/settings_page.dart';
import 'src/storage/local_storage.dart';
import 'src/storage/storage.dart';
import 'src/widgets/data_provider.dart';

final ConfigInstance config = ConfigInstance();
final LocalStorage localStorage = LocalStorage();

void main() {
  _run();
}

Future<void> _run() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigHelper.init();
  await StorageHelper.init();
  await ExamLoader.load();
  await initializeDateFormatting();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return DataProvider(builder: (context, themeData) {
      return MaterialApp(
        title: '會考沙漏',
        theme: themeData,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/settings':
              return MaterialPageRoute(
                settings: settings,
                builder: (context) => const SettingsPage(),
              );
            case '/exam/simulation':
              return MaterialPageRoute(
                settings: settings,
                builder: (context) => const SimulationExamForm(),
              );
            case '/favorite_questions':
              return MaterialPageRoute(
                settings: settings,
                builder: (context) => const FavoriteQuestionsPage(),
              );
            case '/about':
              return MaterialPageRoute(
                settings: settings,
                builder: (context) => const AboutPage(),
              );
            case '/personal':
              return MaterialPageRoute(
                settings: settings,
                builder: (context) => const PersonalPage(),
              );
            case '/high-school-choice-filling':
              return MaterialPageRoute(
                settings: settings,
                builder: (context) => const HighSchoolChoiceFillingPage(),
              );
            default:
              return MaterialPageRoute(
                settings:
                    RouteSettings(name: '/', arguments: settings.arguments),
                builder: (context) => const MainPage(),
              );
          }
        },
        initialRoute: '/',
      );
    });
  }
}
