import 'package:cap_countdown/src/config/config_helper.dart';

class ConfigInstance {
  DateTime get capStartTime => DateTime.fromMillisecondsSinceEpoch(
      ConfigHelper.get<int>('cap_start_time'));
}
