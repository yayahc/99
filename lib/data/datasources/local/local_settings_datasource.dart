import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:ninety/data/datasources/i_settings_datasource.dart';
import 'package:ninety/database.dart';
import 'package:ninety/domain/entities/app_language.dart';
import 'package:ninety/domain/entities/quran_auto_play.dart';
import 'package:ninety/domain/params/settings/set_language_param.dart';
import 'package:ninety/domain/params/settings/set_quran_auto_play_param.dart';
import 'package:ninety/domain/params/settings/set_theme_mode_param.dart';

@Singleton(as: ISettingsDatasource)
class LocalSettingsDatasourceImpl implements ISettingsDatasource {
  final AppDatabase db;
  LocalSettingsDatasourceImpl(@Named('db') this.db);

  static const _rowId = 1;

  @override
  Future<String> getThemeMode() async {
    final row = await _row();
    return row?.themeMode ?? _encode(ThemeMode.system);
  }

  @override
  Future<void> setThemeMode(SetThemeModeParam param) async {
    final value = _encode(param.themeMode);
    await db.into(db.appSettingsModel).insertOnConflictUpdate(
          AppSettingsModelCompanion.insert(
            id: const Value(_rowId),
            themeMode: Value(value),
          ),
        );
  }

  @override
  Future<QuranAutoPlay> getQuranAutoPlay() async {
    final row = await _row();
    if (row == null) return const QuranAutoPlay.disabled();
    return QuranAutoPlay(
      enabled: row.autoPlayQuran,
      volume: row.autoPlayQuranVolume,
    );
  }

  @override
  Future<void> setQuranAutoPlay(SetQuranAutoPlayParam param) async {
    await db.into(db.appSettingsModel).insertOnConflictUpdate(
          AppSettingsModelCompanion.insert(
            id: const Value(_rowId),
            autoPlayQuran: Value(param.autoPlay.enabled),
            autoPlayQuranVolume: Value(param.autoPlay.volume),
          ),
        );
  }

  @override
  Future<String> getLanguageCode() async {
    final row = await _row();
    return row?.languageCode ?? AppLanguage.system.code;
  }

  @override
  Future<void> setLanguage(SetLanguageParam param) async {
    await db.into(db.appSettingsModel).insertOnConflictUpdate(
          AppSettingsModelCompanion.insert(
            id: const Value(_rowId),
            languageCode: Value(param.language.code),
          ),
        );
  }

  Future<AppSettingsModelData?> _row() {
    return (db.select(db.appSettingsModel)..where((t) => t.id.equals(_rowId)))
        .getSingleOrNull();
  }

  static String _encode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }
}
