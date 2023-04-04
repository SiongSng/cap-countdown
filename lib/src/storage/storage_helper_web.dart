import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class StorageHelper {
  static late final Map _data;

  static Future<void> init() async {
    final jsonString = html.window.localStorage['settings'] ??= '{}';
    _data = jsonDecode(jsonString);
  }

  static T get<T>(String key, [T? defaultValue]) {
    return _data[key] ?? defaultValue;
  }

  static void set<T>(String key, T value) {
    _data[key] = value;
    save();
  }

  static Future<void> save() async {
    html.window.localStorage['settings'] = jsonEncode(_data);
  }
}
