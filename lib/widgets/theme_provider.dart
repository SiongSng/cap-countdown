import 'package:cap_countdown/config/app_theme.dart';
import 'package:cap_countdown/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends StatefulWidget {
  final Widget Function(BuildContext context, ThemeData themeData) builder;

  const ThemeProvider({Key? key, required this.builder}) : super(key: key);

  static ThemeChangeNotifier of(BuildContext context) {
    return Provider.of<ThemeChangeNotifier>(context, listen: false);
  }

  @override
  State<ThemeProvider> createState() => _ThemeProviderState();
}

class _ThemeProviderState extends State<ThemeProvider> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChangeNotifier>(
        create: (_) => ThemeChangeNotifier(config.appTheme),
        child:
            Consumer<ThemeChangeNotifier>(builder: (context, notifier, child) {
          final Brightness brightness;

          switch (notifier.theme) {
            case AppTheme.followSystem:
              brightness = WidgetsFlutterBinding.ensureInitialized()
                  .window
                  .platformBrightness;
              break;
            case AppTheme.light:
              brightness = Brightness.light;
              break;
            case AppTheme.dark:
              brightness = Brightness.dark;
              break;
          }

          final themeData = ThemeData(
            brightness: brightness,
            fontFamily: 'NotoSansTC',
            fontFamilyFallback: const ['NotoSansTC'],
            useMaterial3: true,
          );

          return widget.builder(context, themeData);
        }));
  }
}

class ThemeChangeNotifier extends ChangeNotifier implements ReassembleHandler {
  AppTheme _theme;

  AppTheme get theme => _theme;

  ThemeChangeNotifier(this._theme);

  void setTheme(AppTheme theme) {
    _theme = theme;
    notifyListeners();
  }

  /// Handle hot reload
  @override
  void reassemble() {
    setTheme(config.appTheme);
  }
}
