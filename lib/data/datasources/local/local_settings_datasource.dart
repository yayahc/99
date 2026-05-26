import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:ninety/data/datasources/i_settings_datasource.dart';
import 'package:ninety/database.dart';
import 'package:ninety/domain/params/settings/set_theme_mode_param.dart';

@Singleton(as: ISettingsDatasource)
class LocalSettingsDatasourceImpl implements ISettingsDatasource {
  final AppDatabase db;
  LocalSettingsDatasourceImpl(@Named('db') this.db);

  static const _rowId = 1;

  @override
  Future<String> getThemeMode() async {
    final row = await (db.select(db.appSettingsModel)
          ..where((t) => t.id.equals(_rowId)))
        .getSingleOrNull();
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
