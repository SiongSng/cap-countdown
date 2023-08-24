import 'package:cap_countdown/src/config/config_helper.dart';
import 'package:cap_countdown/src/model/choice_filling.dart';
import 'package:pub_semver/pub_semver.dart';

class ConfigInstance {
  Version get appVersion =>
      Version.parse(ConfigHelper.get<String>('app_version'));

  DateTime get capStartTime =>
      DateTime.parse(ConfigHelper.get<String>('cap_start_time')).toLocal();

  DateTime get examResultAnnouncedTime =>
      DateTime.parse(ConfigHelper.get<String>('exam_result_announced_time'))
          .toLocal();

  ChoiceFilling get choiceFilling => ChoiceFilling.fromJson(
      ConfigHelper.get<Map<String, dynamic>>('choice_filling'));
}
