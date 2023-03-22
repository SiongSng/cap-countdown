import 'package:flutter/material.dart';

enum AppTheme {
  light('淺色', Icon(Icons.wb_sunny_rounded)),
  dark('深色', Icon(Icons.nightlight_round)),
  followSystem('依據系統', Icon(Icons.settings_suggest_rounded));

  final String uiName;
  final Widget icon;

  const AppTheme(this.uiName, this.icon);
}
