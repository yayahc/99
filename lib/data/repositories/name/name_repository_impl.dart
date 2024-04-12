import 'package:injectable/injectable.dart';
import 'package:ninety/data/datasources/i_name_datasource.dart';
import 'package:ninety/domain/entities/name.dart';
import 'package:ninety/domain/params/names/get_name_param.dart';
import 'package:ninety/domain/params/names/get_names_param.dart';
import 'package:ninety/domain/repositories/name/i_name_repository.dart';

@Singleton(as: INameRepository)
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
