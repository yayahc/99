import 'package:ninety/data/datasources/i_name_datasource.dart';
import 'package:ninety/data/datasources/local/names_datas.dart';
import 'package:ninety/domain/entities/name.dart';
import 'package:ninety/domain/params/get_name_param.dart';
import 'package:ninety/domain/params/get_names_param.dart';

class LocalNameDatasourceImpl implements INameDatasource {
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
}
