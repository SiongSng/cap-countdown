import 'package:cap_countdown/main.dart';
import 'package:cap_countdown/src/util/cap_util.dart';
import 'package:cap_countdown/src/widgets/cap_time_left.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CountdownPage extends StatefulWidget {
  const CountdownPage({super.key});

  @override
  State<CountdownPage> createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      children: [
        _buildHourglass(),
        const CAPTimeLeft(showDetail: true),
        _buildPostExamTools()
      ],
    );
  }

  Widget _buildHourglass() {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SpinKitPouringHourGlassRefined(
          color: Theme.of(context).dividerColor,
          duration: const Duration(minutes: 1),
          size: 200),
    ));
  }

  Widget _buildPostExamTools() {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            '考後懶人包（112 年）',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              FilledButton.icon(
                onPressed: () {
                  CAPUtil.checkChoiceFillingTime(
                      context,
                      config.examResultAnnouncedTime,
                      'https://cap.rcpet.edu.tw',
                      '成績查詢',
                      '現在還無法查詢成績，請等待至 %time% 方可查詢。');
                },
                icon: const Icon(Icons.search_outlined),
                label: const Text('會考成績'),
              ),
              FilledButton.icon(
                onPressed: () {
                  launchUrlString(
                      'https://cap.rcpet.edu.tw/exam/112/112P_Answer.pdf');
                },
                icon: const Icon(Icons.book_outlined),
                label: const Text('參考答案'),
              ),
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.book_outlined),
                label: const Text('題數與等級對照表'),
              ),
              FilledButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/high-school-choice-filling');
                },
                icon: const Icon(Icons.volunteer_activism_outlined),
                label: const Text('志願選填（高中、高職）'),
              ),
              FilledButton.icon(
                onPressed: () {
                  final data = config.choiceFilling.fiveYearCollege;
                  CAPUtil.checkChoiceFillingTime(context, data.startTime,
                      data.link, '五專優免選填志願', '現在還無法選填志願，請等待至 %time% 方可選填。');
                },
                icon: const Icon(Icons.volunteer_activism_outlined),
                label: const Text('志願選填（五專優免）'),
              ),
            ],
          ),
        ],
      ),
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
