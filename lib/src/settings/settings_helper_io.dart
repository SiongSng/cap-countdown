import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

abstract class SettingsHelper {
  static late final Map _settings;

  static Future<void> init() async {
    final file = await _getFile();
    final String jsonString;

    if (file.existsSync()) {
      jsonString = file.readAsStringSync();
    } else {
      jsonString = '{}';
    }

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
    final file = await _getFile();
    file.writeAsStringSync(jsonEncode(_settings));
  }

  static Future<File> _getFile() async {
    final supportDirectory = await getApplicationSupportDirectory();
    return File(join(supportDirectory.path, 'settings.json'));
  }
}
