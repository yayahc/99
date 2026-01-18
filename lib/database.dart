import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class FavoriteNameModel extends Table {
  IntColumn get id => integer().autoIncrement()();
}

@DriftDatabase(tables: [FavoriteNameModel])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
        name: 'db',
        native: const DriftNativeOptions(
            databaseDirectory: getApplicationSupportDirectory));
  }
}
