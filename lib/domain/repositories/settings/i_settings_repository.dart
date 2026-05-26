import 'package:flutter/material.dart';
import 'package:ninety/domain/params/settings/set_theme_mode_param.dart';

abstract class ISettingsRepository {
  Future<ThemeMode> getThemeMode();
  Future<void> setThemeMode(SetThemeModeParam param);
}
