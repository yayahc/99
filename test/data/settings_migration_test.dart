import 'dart:ffi';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ninety/database.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlite3/sqlite3.dart';

void main() {
  late Directory tempDir;
  late File dbFile;

  setUpAll(() {
    if (Platform.isLinux) {
      open.overrideFor(
        OperatingSystem.linux,
        () => DynamicLibrary.open('libsqlite3.so.0'),
      );
    }
  });

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('ninety_migration');
    dbFile = File('${tempDir.path}/db.sqlite');
  });

  tearDown(() => tempDir.deleteSync(recursive: true));

  void writeSchema(String sql) {
    final raw = sqlite3.open(dbFile.path);
    raw.execute('''
      CREATE TABLE favorite_name_model (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT
      );
      INSERT INTO favorite_name_model (id) VALUES (7);
      $sql
    ''');
    raw.dispose();
  }

  test('upgrading from v2 keeps existing settings and adds the new defaults',
      () async {
    writeSchema('''
      CREATE TABLE app_settings_model (
        id INTEGER NOT NULL DEFAULT 1,
        theme_mode TEXT NOT NULL DEFAULT 'system',
        PRIMARY KEY (id)
      );
      INSERT INTO app_settings_model (id, theme_mode) VALUES (1, 'dark');
      PRAGMA user_version = 2;
    ''');

    final db = AppDatabase(NativeDatabase(dbFile));
    final settings = await db.select(db.appSettingsModel).getSingle();
    final favorites = await db.select(db.favoriteNameModel).get();
    await db.close();

    expect(settings.themeMode, 'dark');
    expect(settings.autoPlayQuran, isFalse);
    expect(settings.autoPlayQuranVolume, 0.2);
    expect(settings.languageCode, 'system');
    expect(favorites.map((f) => f.id), [7]);
  });

  test('upgrading from v3 keeps the quran auto play settings', () async {
    writeSchema('''
      CREATE TABLE app_settings_model (
        id INTEGER NOT NULL DEFAULT 1,
        theme_mode TEXT NOT NULL DEFAULT 'system',
        auto_play_quran INTEGER NOT NULL DEFAULT 0
          CHECK ("auto_play_quran" IN (0, 1)),
        auto_play_quran_volume REAL NOT NULL DEFAULT 0.2,
        PRIMARY KEY (id)
      );
      INSERT INTO app_settings_model
        (id, theme_mode, auto_play_quran, auto_play_quran_volume)
        VALUES (1, 'light', 1, 0.45);
      PRAGMA user_version = 3;
    ''');

    final db = AppDatabase(NativeDatabase(dbFile));
    final settings = await db.select(db.appSettingsModel).getSingle();
    await db.close();

    expect(settings.themeMode, 'light');
    expect(settings.autoPlayQuran, isTrue);
    expect(settings.autoPlayQuranVolume, 0.45);
    expect(settings.languageCode, 'system');
  });
}
