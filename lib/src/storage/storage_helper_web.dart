import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class StorageHelper {
  static Future<void> init() async {
    // No-op.
  }

  static T get<T>(String key, [T? defaultValue]) {
    final value = html.window.localStorage[key];

    if (value != null) {
      return jsonDecode(value) as T;
    } else {
      return defaultValue as T;
    }
  }

  static void set<T>(String key, T value) {
    if (value == null) {
      html.window.localStorage.remove(key);
      return;
    }

    html.window.localStorage[key] = jsonEncode(value);
  }

  static Future<void> save() async {
    // No-op.
  }
}
