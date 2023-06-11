import 'package:cap_countdown/main.dart';
import 'package:cap_countdown/src/util/cap_util.dart';
import 'package:flutter/material.dart';

class HighSchoolChoiceFillingPage extends StatefulWidget {
  const HighSchoolChoiceFillingPage({super.key});

  @override
  State<HighSchoolChoiceFillingPage> createState() =>
      _HighSchoolChoiceFillingPageState();
}

class _HighSchoolChoiceFillingPageState
    extends State<HighSchoolChoiceFillingPage> {
  @override
  Widget build(BuildContext context) {
    final areas = config.choiceFilling.highSchool;

    return Scaffold(
        appBar: AppBar(
          title: const Text('高級中等學校免試入學'),
        ),
        body: ListView.separated(
            itemCount: areas.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final area = areas[index];

              return ListTile(
                title: Text(area.name),
                subtitle: Text(
                    '${CAPUtil.formatTime(area.startTime)} 至 ${CAPUtil.formatTime(area.endTime)}'),
                onTap: () {
                  CAPUtil.checkChoiceFillingTime(
                      context,
                      area.startTime,
                      area.link,
                      '${area.name} 選填志願',
                      '現在還無法選填志願，請等待至 %time% 方可選填。');
                },
              );
            }));
  }
}
