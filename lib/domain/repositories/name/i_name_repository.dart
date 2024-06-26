import 'package:ninety/domain/entities/name.dart';
import 'package:ninety/domain/params/names/get_name_param.dart';
import 'package:ninety/domain/params/names/get_names_param.dart';

abstract class INameRepository {
  Future<List<Name>> getNames(GetNamesParam param);
  Future<Name> getName(GetNameParam param);
}
