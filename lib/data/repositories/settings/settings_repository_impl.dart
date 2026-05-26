import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:ninety/data/datasources/i_settings_datasource.dart';
import 'package:ninety/domain/params/settings/set_theme_mode_param.dart';
import 'package:ninety/domain/repositories/settings/i_settings_repository.dart';

@Singleton(as: ISettingsRepository)
class SettingsRepositoryImpl implements ISettingsRepository {
  final ISettingsDatasource _settingsDatasource;

  SettingsRepositoryImpl(this._settingsDatasource);

  @override
  Future<ThemeMode> getThemeMode() async {
    final raw = await _settingsDatasource.getThemeMode();
    return _decode(raw);
  }

  @override
  Future<void> setThemeMode(SetThemeModeParam param) async {
    await _settingsDatasource.setThemeMode(param);
  }

  ThemeMode _decode(String value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }
}
