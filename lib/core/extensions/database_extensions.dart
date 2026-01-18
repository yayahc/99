import 'package:ninety/database.dart';
import 'package:ninety/domain/entities/name.dart';
import '../../data/datasources/local/names_datas.dart';

extension FavoriteNameModelDatabaseExtensions on FavoriteNameModelData {
  Name get toNameEntity => NamesDatas.names.firstWhere((n) => n.id == id);
}
