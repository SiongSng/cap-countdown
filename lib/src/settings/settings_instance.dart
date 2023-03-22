import 'app_theme.dart';
import 'settings.dart';

class SettingsInstance {
  AppTheme get appTheme => AppTheme.values.byName(
      SettingsHelper.get<String>('app_theme', AppTheme.followSystem.name));

  set appTheme(AppTheme value) => SettingsHelper.set('app_theme', value.name);
}
