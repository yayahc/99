import 'package:ninety/domain/params/favorite/add_name_to_favorite_param.dart';
import 'package:ninety/domain/params/favorite/get_favorite_names_param.dart';
import 'package:ninety/domain/params/favorite/remove_name_to_favorite_param.dart';

import '../../domain/entities/name.dart';
import '../../domain/params/names/get_name_param.dart';
import '../../domain/params/names/get_names_param.dart';

abstract class INameDatasource {
  Future<List<Name>> getNames(GetNamesParam param);
  Future<Name> getName(GetNameParam param);
  Future<List<Name>> getFavoriteNames(GetFavoriteNamesParam param);
  Future<void> removeNameToFavorite(RemoveNameToFavoriteParam param);
  Future<void> addNameToFavorite(AddNameToFavoriteParam param);
}
