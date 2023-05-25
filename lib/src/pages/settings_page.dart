import 'package:cap_countdown/main.dart';
import 'package:cap_countdown/src/storage/app_theme.dart';
import 'package:cap_countdown/src/widgets/data_provider.dart';
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
                      DataProvider.of(context).setTheme(theme);
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
                              DataProvider.of(context).setAccentColor(null);
                              accentColor = localStorage.accentColor;
                              setState(() {});
                            },
                            child: const Text('預設'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              DataProvider.of(context)
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
          ),
          ExpansionTile(
              title: const Text('倒數'),
              initiallyExpanded: true,
              leading: const Icon(Icons.timer_outlined),
              shape: Border.all(color: Colors.transparent),
              children: [
                SwitchListTile(
                    value: localStorage.userFriendlyCountdown,
                    onChanged: (value) {
                      localStorage.userFriendlyCountdown = value;
                      setState(() {});
                    },
                    title: const Text('更人性化的倒數計時'),
                    subtitle:
                        const Text('如果距離會考還有 23 小時就會被視為還有一天。\n本功能須重啟應用程式才會生效。'))
              ]),
          ExpansionTile(
              title: const Text('模擬試題'),
              initiallyExpanded: true,
              leading: const Icon(Icons.edit),
              shape: Border.all(color: Colors.transparent),
              children: [
                SwitchListTile(
                    value: localStorage.simulationExamTiming,
                    onChanged: (value) {
                      localStorage.simulationExamTiming = value;
                      setState(() {});
                    },
                    title: const Text('作答時間倒計時'),
                    subtitle:
                        const Text('若啟用則有作答時間限制，在該科作答時間結束後強制交卷；反之則無此限制。')),
                SwitchListTile(
                    value: localStorage.simulationExamShowAnsBtn,
                    onChanged: (value) {
                      localStorage.simulationExamShowAnsBtn = value;
                      setState(() {});
                    },
                    title: const Text('即時對答案'),
                    subtitle: const Text('為每道試題增加一個「對答案」答案按鈕，可單獨提交該題答案，並查看詳解。'))
              ])
        ],
      ),
    );
  }
}
