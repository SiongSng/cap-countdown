import 'dart:async';

import 'package:cap_countdown/main.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final difference = config.capStartTime.difference(DateTime.now());
    int day = difference.inDays;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 1,
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
              if (widget.showDetail) ...[
                Text('再', style: Theme.of(context).textTheme.titleLarge),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: (difference.inHours % 24).toString(),
                    style: TextStyle(
                        fontSize: 65.5,
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
                Text('又', style: Theme.of(context).textTheme.titleLarge),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: (difference.inMinutes % 60).toString(),
                    style: TextStyle(
                        fontSize: 65.5,
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
                Text('又', style: Theme.of(context).textTheme.titleLarge),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: (difference.inSeconds % 60).toString(),
                    style: TextStyle(
                        fontSize: 65.5,
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
              ]
            ],
          ),
        ),
      ),
    );
  }
}
