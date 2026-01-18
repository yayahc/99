import 'package:injectable/injectable.dart';
import 'package:ninety/database.dart';

@module
abstract class StorageModule {
  @singleton
  @Named('db')
  AppDatabase get instance => AppDatabase();
}
