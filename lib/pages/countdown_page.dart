import 'dart:async';

import 'package:cap_countdown/util/cap_util.dart';
import 'package:cap_countdown/widgets/cap_time_left.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CountdownPage extends StatefulWidget {
  const CountdownPage({super.key});

  @override
  State<CountdownPage> createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [_Hourglass(), CAPTimeLeft(showDetail: true)],
    );
  }
}

class _Hourglass extends StatefulWidget {
  const _Hourglass();

  @override
  State<_Hourglass> createState() => _HourglassState();
}

class _HourglassState extends State<_Hourglass> {
  @override
  void initState() {
    super.initState();

    // Update the hourglass duration every minute.
    Timer.periodic(const Duration(minutes: 1), (timer) {
      if (!mounted) return timer.cancel();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SpinKitPouringHourGlassRefined(
            color: Theme.of(context).dividerColor,
            duration:
                Duration(seconds: CAPUtil.getDurationToCAP().inSeconds % 60),
            size: 200),
      ),
    );
  }
}
