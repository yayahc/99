import 'package:injectable/injectable.dart';
import 'package:ninety/core/common/error/app_error.dart';
import 'package:ninety/data/datasources/i_name_datasource.dart';
import 'package:ninety/data/datasources/local/names_datas.dart';
import 'package:ninety/domain/entities/name.dart';
import 'package:ninety/domain/params/favorite/add_name_to_favorite_param.dart';
import 'package:ninety/domain/params/favorite/get_favorite_names_param.dart';
import 'package:ninety/domain/params/favorite/remove_name_to_favorite_param.dart';
import 'package:ninety/domain/params/names/get_name_param.dart';
import 'package:ninety/domain/params/names/get_names_param.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Singleton(as: INameDatasource)
class LocalNameDatasourceImpl implements INameDatasource {
  final SharedPreferences pref;
  LocalNameDatasourceImpl(@Named('pref') this.pref);

  final List<Name> names = NamesDatas.names;

  @override
  Future<Name> getName(GetNameParam param) async {
    final int id = param.id;
    return names.firstWhere((e) => e.id == id);
  }

  @override
  Future<List<Name>> getNames(GetNamesParam param) async {
    return names;
  }

  @override
  Future<void> addNameToFavorite(AddNameToFavoriteParam param) async {
    final List<String>? indexes = pref.getStringList('fav');
    if (indexes != null) {
      indexes.add(param.id.toString());
      await pref.setStringList('fav', indexes);
    } else {
      throw ErrorWhileAddingNameToFavorite;
    }
  }

  @override
  Future<List<Name>> getFavoriteNames(GetFavoriteNamesParam param) async {
    final List<String>? indexes = pref.getStringList('fav');
    if (indexes == null) {
      return [];
    }
    final List<Name> names = await getNames(GetNamesParam());
    final List<Name> favNames =
        names.takeWhile((e) => indexes.contains(e.id.toString())).toList();
    return favNames;
  }

  @override
  Future<void> removeNameToFavorite(RemoveNameToFavoriteParam param) async {
    final List<String>? indexes = pref.getStringList('fav');
    if (indexes != null) {
      indexes.remove(param.id.toString());
      await pref.setStringList('fav', indexes);
    } else {
      throw ErrorWhileRemovingNameToFavorite;
    }
  }
}
