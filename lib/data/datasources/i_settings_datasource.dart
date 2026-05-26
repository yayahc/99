import 'package:ninety/domain/params/settings/set_theme_mode_param.dart';

abstract class ISettingsDatasource {
  Future<String> getThemeMode();
  Future<void> setThemeMode(SetThemeModeParam param);
}
