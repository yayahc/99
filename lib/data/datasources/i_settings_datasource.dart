import 'package:ninety/domain/entities/quran_auto_play.dart';
import 'package:ninety/domain/params/settings/set_language_param.dart';
import 'package:ninety/domain/params/settings/set_quran_auto_play_param.dart';
import 'package:ninety/domain/params/settings/set_theme_mode_param.dart';

abstract class ISettingsDatasource {
  Future<String> getThemeMode();
  Future<void> setThemeMode(SetThemeModeParam param);
  Future<QuranAutoPlay> getQuranAutoPlay();
  Future<void> setQuranAutoPlay(SetQuranAutoPlayParam param);
  Future<String> getLanguageCode();
  Future<void> setLanguage(SetLanguageParam param);
}
