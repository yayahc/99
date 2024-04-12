import 'package:dartz/dartz.dart';
import 'package:ninety/core/error/app_error.dart';

abstract class Usecase<Param, T> {
  Future<Either<AppError, T>> trigger(Param param);
}
