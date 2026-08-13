import 'dart:ffi';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/open.dart';
import 'package:ninety/data/datasources/local/local_settings_datasource.dart';
import 'package:ninety/database.dart';
import 'package:ninety/domain/entities/app_language.dart';
import 'package:ninety/domain/entities/quran_auto_play.dart';
import 'package:ninety/domain/params/settings/set_language_param.dart';
import 'package:ninety/domain/params/settings/set_quran_auto_play_param.dart';
import 'package:ninety/domain/params/settings/set_theme_mode_param.dart';

void main() {
  late AppDatabase db;
  late LocalSettingsDatasourceImpl datasource;

  setUpAll(() {
    if (Platform.isLinux) {
      open.overrideFor(
        OperatingSystem.linux,
        () => DynamicLibrary.open('libsqlite3.so.0'),
      );
    }
  });

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    datasource = LocalSettingsDatasourceImpl(db);
  });

  tearDown(() => db.close());

  test('quran auto play defaults to disabled at a low volume', () async {
    final autoPlay = await datasource.getQuranAutoPlay();

    expect(autoPlay.enabled, isFalse);
    expect(autoPlay.volume, 0.2);
  });

  test('quran auto play survives a write and read back', () async {
    await datasource.setQuranAutoPlay(
      SetQuranAutoPlayParam(const QuranAutoPlay(enabled: true, volume: 0.35)),
    );

    final autoPlay = await datasource.getQuranAutoPlay();

    expect(autoPlay.enabled, isTrue);
    expect(autoPlay.volume, 0.35);
  });

  test('language defaults to the system one and survives a write', () async {
    expect(await datasource.getLanguageCode(), 'system');

    await datasource.setLanguage(SetLanguageParam(AppLanguage.arabic));

    expect(await datasource.getLanguageCode(), 'ar');
  });

  test('writing one setting leaves the other untouched', () async {
    await datasource.setThemeMode(SetThemeModeParam(ThemeMode.dark));
    await datasource.setQuranAutoPlay(
      SetQuranAutoPlayParam(const QuranAutoPlay(enabled: true, volume: 0.5)),
    );

    expect(await datasource.getThemeMode(), 'dark');

    await datasource.setThemeMode(SetThemeModeParam(ThemeMode.light));
    final autoPlay = await datasource.getQuranAutoPlay();

    expect(autoPlay.enabled, isTrue);
    expect(autoPlay.volume, 0.5);
  });
}
