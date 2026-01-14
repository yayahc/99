import 'package:injectable/injectable.dart';
import 'package:ninety/domain/entities/name.dart';
import 'package:ninety/domain/params/favorite/add_name_to_favorite_param.dart';
import 'package:ninety/domain/params/favorite/get_favorite_names_param.dart';
import 'package:ninety/domain/params/favorite/remove_name_to_favorite_param.dart';
import 'package:ninety/domain/repositories/favorite/i_favorite_name_repository.dart';

import '../../datasources/i_name_datasource.dart';

@Singleton(as: IFavoriteNameRepository)
class FavoriteNameRepositoryImpl implements IFavoriteNameRepository {
  final INameDatasource _nameDatasource;

  FavoriteNameRepositoryImpl(this._nameDatasource);

  @override
  Future<void> addNameToFavorite(AddNameToFavoriteParam param) async {
    _nameDatasource.addNameToFavorite(param);
  }

  @override
  Future<List<Name>> getFavoriteNames(GetFavoriteNamesParam param) async {
    return _nameDatasource.getFavoriteNames(param);
  }

  @override
  Future<void> removeNameToFavorite(RemoveNameToFavoriteParam param) async {
    _nameDatasource.removeNameToFavorite(param);
  }
}
