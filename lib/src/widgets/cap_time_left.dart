import 'dart:async';

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

    if (!widget.showDetail) return;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return timer.cancel();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final duration = CAPUtil.getDurationToCAP();
    int day = duration.inDays;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                '距離會考只剩下',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: day.toString(),
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
              if (widget.showDetail)
                Wrap(spacing: 5, children: [
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
                ])
            ],
          ),
        ),
      ),
    );
  }
}
