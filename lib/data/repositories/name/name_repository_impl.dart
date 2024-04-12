import 'package:ninety/data/datasources/i_name_datasource.dart';
import 'package:ninety/domain/entities/name.dart';
import 'package:ninety/domain/params/get_name_param.dart';
import 'package:ninety/domain/params/get_names_param.dart';
import 'package:ninety/domain/repositories/name/i_name_repository.dart';

class NameRepositoryImpl implements INameRepository {
  final INameDatasource _nameDatasource;

  NameRepositoryImpl(this._nameDatasource);

  @override
  Future<Name> getName(GetNameParam param) async {
    return await _nameDatasource.getName(param);
  }

  @override
  Future<List<Name>> getNames(GetNamesParam param) async {
    return await _nameDatasource.getNames(param);
  }
}
