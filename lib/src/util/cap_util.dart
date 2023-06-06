import 'package:cap_countdown/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

abstract class CAPUtil {
  /// How much time is left of the CAP exam.
  static Duration getDurationToCAP() {
    return config.capStartTime.difference(DateTime.now());
  }

  static String formatTime(DateTime time) {
    final dateFormat = DateFormat('yyyy/MM/dd HH:mm', 'zh_TW');

    return dateFormat.format(time.toLocal());
  }

  static void checkChoiceFillingTime(BuildContext context, DateTime startTime,
      String link, String title, String description) {
    if (DateTime.now().isAfter(startTime)) {
      launchUrlString(link);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content:
              Text(description.replaceAll('%time%', formatTime(startTime))),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('確定'),
            ),
          ],
        ),
      );
    }
  }
}
