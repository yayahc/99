import 'package:ninety/domain/entities/name.dart';
import 'package:ninety/domain/params/favorite/add_name_to_favorite_param.dart';
import 'package:ninety/domain/params/favorite/get_favorite_names_param.dart';
import 'package:ninety/domain/params/favorite/remove_name_to_favorite_param.dart';
import 'package:ninety/domain/repositories/favorite/i_favorite_name_repository.dart';

class FavoriteNameRepositoryImpl implements IFavoriteNameRepository {
  @override
  Future<void> addNameToFavorite(AddNameToFavoriteParam param) {
    // TODO: implement addNameToFavorite
    throw UnimplementedError();
  }

  @override
  Future<List<Name>> getFavoriteNames(GetFavoriteNamesParam param) {
    // TODO: implement getFavoriteNames
    throw UnimplementedError();
  }

  @override
  Future<void> removeNameToFavorite(RemoveNameToFavoriteParam param) {
    // TODO: implement removeNameToFavorite
    throw UnimplementedError();
  }
}
