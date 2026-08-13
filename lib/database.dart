import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class FavoriteNameModel extends Table {
  IntColumn get id => integer().autoIncrement()();
}

class AppSettingsModel extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  TextColumn get themeMode => text().withDefault(const Constant('system'))();
  BoolColumn get autoPlayQuran => boolean().withDefault(const Constant(false))();
  RealColumn get autoPlayQuranVolume =>
      real().withDefault(const Constant(0.2))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [FavoriteNameModel, AppSettingsModel])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await into(appSettingsModel)
              .insert(AppSettingsModelCompanion.insert());
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(appSettingsModel);
            await into(appSettingsModel)
                .insert(AppSettingsModelCompanion.insert());
          } else if (from < 3) {
            await m.addColumn(appSettingsModel, appSettingsModel.autoPlayQuran);
            await m.addColumn(
                appSettingsModel, appSettingsModel.autoPlayQuranVolume);
          }
        },
      );

  static QueryExecutor _openConnection() {
    return driftDatabase(
        name: 'db',
        native: const DriftNativeOptions(
            databaseDirectory: getApplicationSupportDirectory));
  }
}
