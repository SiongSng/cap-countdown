import 'dart:async';

import 'package:cap_countdown/main.dart';
import 'package:cap_countdown/src/util/cap_util.dart';
import 'package:flutter/material.dart';

class CAPTimeLeft extends StatefulWidget {
  final bool showDetail;

  const CAPTimeLeft({super.key, required this.showDetail});

  @override
  State<CAPTimeLeft> createState() => _CAPTimeLeftState();
}

class _CAPTimeLeftState extends State<CAPTimeLeft> {
  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return timer.cancel();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // final duration = CAPUtil.getDurationToCAP();

    const duration = Duration(hours: 10, minutes: 59, seconds: 59);
    final capIsAboutToStart = duration.inDays == 0;
    final capIsStarted = duration.inMilliseconds == 0;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (capIsAboutToStart)
                Text(
                  '加油！堅持到最後一刻～',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).colorScheme.secondary),
                ),
              if (!capIsAboutToStart)
                Text(
                  '距離會考只剩下',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              if (widget.showDetail || duration.inDays > 0)
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: getDay(duration).toString(),
                    style: TextStyle(
                        fontSize: 85.5,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black),
                  ),
                  TextSpan(
                    text: '天',
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                ])),
              if (widget.showDetail || capIsAboutToStart)
                _buildDetails(duration, context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetails(Duration duration, BuildContext context) {
    return Wrap(spacing: 5, children: [
      RichText(
          text: TextSpan(children: [
        TextSpan(
          text: (duration.inHours % 24).toString(),
          style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black),
        ),
        TextSpan(
          text: '小時',
          style: Theme.of(context).textTheme.titleLarge,
        )
      ])),
      RichText(
          text: TextSpan(children: [
        TextSpan(
          text: (duration.inMinutes % 60).toString(),
          style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black),
        ),
        TextSpan(
          text: '分鐘',
          style: Theme.of(context).textTheme.titleLarge,
        )
      ])),
      RichText(
          text: TextSpan(children: [
        TextSpan(
          text: (duration.inSeconds % 60).toString(),
          style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black),
        ),
        TextSpan(
          text: '秒鐘',
          style: Theme.of(context).textTheme.titleLarge,
        )
      ])),
    ]);
  }

  int getDay(Duration duration) {
    final hour = duration.inHours % 24;

    if (!widget.showDetail && localStorage.userFriendlyCountdown && hour > 12) {
      return duration.inDays + 1;
    }

    return duration.inDays;
  }
}
