import 'package:dartz/dartz.dart';
import 'package:ninety/core/error/app_error.dart';
import 'package:ninety/features/name/domain/entities/name/name.dart';

abstract class INameLocalDataSource {
  Future<Either<AppError, List<Name>>> getNames();
}
