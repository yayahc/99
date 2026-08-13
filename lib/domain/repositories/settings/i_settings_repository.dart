import 'package:flutter/material.dart';
import 'package:ninety/domain/entities/app_language.dart';
import 'package:ninety/domain/entities/quran_auto_play.dart';
import 'package:ninety/domain/params/settings/set_language_param.dart';
import 'package:ninety/domain/params/settings/set_quran_auto_play_param.dart';
import 'package:ninety/domain/params/settings/set_theme_mode_param.dart';

abstract class ISettingsRepository {
  Future<ThemeMode> getThemeMode();
  Future<void> setThemeMode(SetThemeModeParam param);
  Future<QuranAutoPlay> getQuranAutoPlay();
  Future<void> setQuranAutoPlay(SetQuranAutoPlayParam param);
  Future<AppLanguage> getLanguage();
  Future<void> setLanguage(SetLanguageParam param);
}
