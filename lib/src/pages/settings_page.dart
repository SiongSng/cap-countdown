import 'package:cap_countdown/main.dart';
import 'package:cap_countdown/src/storage/app_theme.dart';
import 'package:cap_countdown/src/widgets/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Color accentColor = localStorage.accentColor;

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
            child: ExpansionTile(
              title: const Text('主題與色系'),
              initiallyExpanded: true,
              leading: const Icon(Icons.display_settings),
              shape: Border.all(color: Colors.transparent),
              children: [
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
                const SizedBox(height: 12),
                ListTile(
                  leading: const Icon(Icons.colorize),
                  title: const Text('自訂強調色'),
                  trailing: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ColoredBox(
                      color: accentColor,
                      child: const SizedBox(
                        width: 48,
                        height: 48,
                      ),
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('請選擇強調色'),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            pickerColor: accentColor,
                            onColorChanged: (color) {
                              accentColor = color;
                            },
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('取消'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              ThemeProvider.of(context).setAccentColor(null);
                              setState(() {});
                            },
                            child: const Text('預設'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              ThemeProvider.of(context)
                                  .setAccentColor(accentColor);
                              setState(() {});
                            },
                            child: const Text('確定'),
                          ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
