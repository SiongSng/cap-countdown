import 'package:cap_countdown/main.dart';
import 'package:cap_countdown/src/exam/exam_loader.dart';
import 'package:cap_countdown/src/exam/subject_question.dart';
import 'package:cap_countdown/src/storage/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataProvider extends StatefulWidget {
  final Widget Function(BuildContext context, ThemeData themeData) builder;

  const DataProvider({Key? key, required this.builder}) : super(key: key);

  static DataChangeNotifier of(BuildContext context) {
    return Provider.of<DataChangeNotifier>(context, listen: false);
  }

  @override
  State<DataProvider> createState() => _DataProviderState();
}

class _DataProviderState extends State<DataProvider> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataChangeNotifier>(
        create: (_) => DataChangeNotifier(
            localStorage.appTheme, ExamLoader.getRandomQuestion()),
        child:
            Consumer<DataChangeNotifier>(builder: (context, notifier, child) {
          final Brightness brightness;

          switch (notifier.theme) {
            case AppTheme.followSystem:
              brightness =
                  View.of(context).platformDispatcher.platformBrightness;
              break;
            case AppTheme.light:
              brightness = Brightness.light;
              break;
            case AppTheme.dark:
              brightness = Brightness.dark;
              break;
          }
          final accentColor = localStorage.accentColor;

          final themeData = ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: accentColor, brightness: brightness),
            useMaterial3: true,
          );

          return widget.builder(context, themeData);
        }));
  }
}

class DataChangeNotifier extends ChangeNotifier implements ReassembleHandler {
  AppTheme _theme;
  SubjectQuestion _dailyQuestion;

  AppTheme get theme => _theme;
  SubjectQuestion get dailyQuestion => _dailyQuestion;

  DataChangeNotifier(this._theme, this._dailyQuestion);

  void setTheme(AppTheme theme) {
    _theme = theme;
    notifyListeners();
  }

  void setAccentColor(Color? color) {
    localStorage.accentColor = color;
    notifyListeners();
  }

  void refreshDailyQuestion() {
    _dailyQuestion = ExamLoader.getRandomQuestion();
    notifyListeners();
  }

  /// Handle hot reload
  @override
  void reassemble() {
    setTheme(localStorage.appTheme);
  }
}
