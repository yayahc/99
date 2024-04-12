import 'package:ninety/domain/entities/name.dart';
import 'package:ninety/domain/params/favorite/add_name_to_favorite_param.dart';
import 'package:ninety/domain/params/favorite/get_favorite_names_param.dart';
import 'package:ninety/domain/params/favorite/remove_name_to_favorite_param.dart';

abstract class IFavoriteNameRepository {
  Future<List<Name>> getFavoriteNames(GetFavoriteNamesParam param);
  Future<void> addNameToFavorite(AddNameToFavoriteParam param);
  Future<void> removeNameToFavorite(RemoveNameToFavoriteParam param);
}
