import 'package:cap_countdown/main.dart';
import 'package:cap_countdown/src/storage/app_theme.dart';
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('主題色系', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                SegmentedButton(
                    segments: AppTheme.values
                        .map((e) => ButtonSegment(
                            value: e, label: Text(e.uiName), icon: e.icon))
                        .toList(),
                    selected: {localStorage.appTheme},
                    onSelectionChanged: (value) {
                      final theme = value.first;
                      localStorage.appTheme = theme;
                      ThemeProvider.of(context).setTheme(theme);
                      setState(() {});
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
