import 'package:cap_countdown/src/widgets/cap_time_left.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
      children: const [_Hourglass(), CAPTimeLeft(showDetail: true)],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _Hourglass extends StatelessWidget {
  const _Hourglass();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SpinKitPouringHourGlassRefined(
            color: Theme.of(context).dividerColor,
            duration: const Duration(minutes: 1),
            size: 200),
      ),
    );
  }
}
