import 'dart:convert';

import 'package:flutter/services.dart';

abstract class ConfigHelper {
  static late final Map _config;

  static Future<void> init() async {
    final jsonString = await rootBundle.loadString('assets/config.json');
    _config = jsonDecode(jsonString);
  }

  static T get<T>(String key) {
    return _config[key];
  }
}
