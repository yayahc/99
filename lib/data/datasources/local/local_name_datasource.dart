import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:ninety/core/error/app_error.dart';
import 'package:ninety/core/extensions/database_extensions.dart';
import 'package:ninety/data/datasources/i_name_datasource.dart';
import 'package:ninety/data/datasources/local/names_datas.dart';
import 'package:ninety/database.dart';
import 'package:ninety/domain/entities/name.dart';
import 'package:ninety/domain/params/favorite/add_name_to_favorite_param.dart';
import 'package:ninety/domain/params/favorite/get_favorite_names_param.dart';
import 'package:ninety/domain/params/favorite/remove_name_to_favorite_param.dart';
import 'package:ninety/domain/params/names/get_name_param.dart';
import 'package:ninety/domain/params/names/get_names_param.dart';

@Singleton(as: INameDatasource)
class LocalNameDatasourceImpl implements INameDatasource {
  final AppDatabase db;
  LocalNameDatasourceImpl(@Named('db') this.db);

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
    try {
      await db
          .into(db.favoriteNameModel)
          .insert(FavoriteNameModelCompanion.insert(id: Value(param.id)));
    } catch (e) {
      throw ErrorWhileAddingNameToFavorite(
          'An error occurend while adding name to favorite');
    }
  }

  @override
  Future<List<Name>> getFavoriteNames(GetFavoriteNamesParam param) async {
    try {
      final names = await db.favoriteNameModel.all().get();
      return names.isEmpty ? [] : names.map((n) => n.toNameEntity).toList();
    } catch (e) {
      throw ErrorWhileLoadingNameToFavorite(e.toString());
    }
  }

  @override
  Future<void> removeNameToFavorite(RemoveNameToFavoriteParam param) async {
    try {
      await db.favoriteNameModel
          .deleteWhere((name) => name.id.equals(param.id));
    } catch (e) {
      throw ErrorWhileAddingNameToFavorite(
          'An error occurend while removing name to favorite');
    }
  }
}
