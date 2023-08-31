import 'dart:async';
import 'dart:math';

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
  final encourageMessages = [
    '加油！堅持到最後一刻～',
    '不論結果如何，堅持到底就對了！',
    '跟過去的自己比，每一次的努力都是一次成長。',
    '相信自己一定做得到！',
    '前方或許有挑戰，但你已經為此做好準備。',
    '不要氣餒！會考只是人生中的一小部份。',
    '從錯誤中學習，失敗為成功之母。',
    '長風破浪會有時，直掛雲帆濟滄海。'
  ];
  late final String encourageMessage;

  @override
  void initState() {
    encourageMessage =
        encourageMessages[Random().nextInt(encourageMessages.length)];
    super.initState();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return timer.cancel();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final duration = CAPUtil.getDurationToCAP();
    final capIsAboutToStart =
        duration.inDays == 0 && duration.inMilliseconds > 0;
    final capIsStarted = duration.inMilliseconds <= 0;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (capIsStarted) ...[
                Text('會考已正式開始',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                const SizedBox(height: 8),
                Text('祝你考試順利，未來就在你手中！',
                    style: Theme.of(context).textTheme.titleLarge),
              ],
              if (capIsAboutToStart)
                Text(
                  encourageMessage,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              if (duration.inDays > 0)
                Text(
                  '距離會考只剩下',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              if (!capIsStarted && (widget.showDetail || duration.inDays > 0))
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
              if (!capIsStarted && (widget.showDetail || capIsAboutToStart))
                _buildDetails(duration),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetails(Duration duration) {
    return Wrap(spacing: 5, children: [
      RichText(
          text: TextSpan(children: [
        TextSpan(
          text: (duration.inHours % 24).toString(),
          style: TextStyle(
              fontSize: 45,
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
              fontSize: 45,
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
              fontSize: 45,
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
