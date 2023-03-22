import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

abstract class SettingsHelper {
  static late final Map _settings;

  static Future<void> init() async {
    final jsonString = html.window.localStorage['settings'] ??= '{}';
    _settings = jsonDecode(jsonString);
  }

  static T get<T>(String key, [T? defaultValue]) {
    return _settings[key] ?? defaultValue;
  }

  static void set<T>(String key, T value) {
    _settings[key] = value;
    save();
  }

  static Future<void> save() async {
    html.window.localStorage['settings'] = jsonEncode(_settings);
  }
}
