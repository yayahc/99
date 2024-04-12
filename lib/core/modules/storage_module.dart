import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class StorageModule {
  @singleton
  @preResolve
  @Named('pref')
  Future<SharedPreferences> get instance => SharedPreferences.getInstance();
}
