import 'package:cap_countdown/src/config/app_theme.dart';
import 'package:cap_countdown/main.dart';
import 'package:cap_countdown/src/widgets/theme_provider.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('主題色系'),
            trailing: SegmentedButton(
                segments: AppTheme.values
                    .map((e) => ButtonSegment(
                        value: e, label: Text(e.uiName), icon: e.icon))
                    .toList(),
                selected: {config.appTheme},
                onSelectionChanged: (value) {
                  final theme = value.first;
                  config.appTheme = theme;
                  ThemeProvider.of(context).setTheme(theme);
                  setState(() {});
                }),
          )
        ],
      ),
    );
  }
}
