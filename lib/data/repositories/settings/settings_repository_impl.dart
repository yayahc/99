import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:ninety/data/datasources/i_settings_datasource.dart';
import 'package:ninety/domain/entities/quran_auto_play.dart';
import 'package:ninety/domain/params/settings/set_quran_auto_play_param.dart';
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

  @override
  Future<QuranAutoPlay> getQuranAutoPlay() =>
      _settingsDatasource.getQuranAutoPlay();

  @override
  Future<void> setQuranAutoPlay(SetQuranAutoPlayParam param) =>
      _settingsDatasource.setQuranAutoPlay(param);

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
