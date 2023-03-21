import 'package:cap_countdown/main.dart';

abstract class CAPUtil {
  /// How much time is left of the CAP exam.
  static Duration getDurationToCAP() {
    return config.capStartTime.difference(DateTime.now());
  }
}
