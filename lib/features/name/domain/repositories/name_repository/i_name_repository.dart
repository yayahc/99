import 'package:dartz/dartz.dart';
import 'package:ninety/core/error/app_error.dart';
import '../../entities/name/name.dart';

abstract class INameRepository {
  Future<Either<AppError, List<Name>>> getNames();
}
