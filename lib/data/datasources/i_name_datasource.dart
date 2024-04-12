import '../../domain/entities/name.dart';
import '../../domain/params/get_name_param.dart';
import '../../domain/params/get_names_param.dart';

abstract class INameDatasource {
  Future<List<Name>> getNames(GetNamesParam param);
  Future<Name> getName(GetNameParam param);
}
