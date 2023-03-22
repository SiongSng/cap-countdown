import 'package:cap_countdown/src/config/app_theme.dart';
import 'package:cap_countdown/src/config/config_helper.dart';

class ConfigInstance {
  DateTime get capStartTime => DateTime.fromMillisecondsSinceEpoch(
      ConfigHelper.get<int>('cap_start_time'));

  AppTheme get appTheme => AppTheme.values.byName(
      ConfigHelper.get<String>('app_theme', AppTheme.followSystem.name));

  set appTheme(AppTheme value) => ConfigHelper.set('app_theme', value.name);
}
