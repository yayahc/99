import 'package:dartz/dartz.dart';
import 'package:ninety/core/error/app_error.dart';

abstract class UsesCase<R> {
  Future<Either<AppError, R>> trigger(String lang);
}
