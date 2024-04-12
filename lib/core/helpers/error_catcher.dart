import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ninety/core/error/app_error.dart';

class ErrorCatcher {
  static Future<Either<AppError, T>> trycatch<T>(Future<T> fn) async {
    try {
      await fn;
      return right(await fn);
    } catch (e, stackTrace) {
      log(stackTrace.toString());
      return left(GenericError(e.toString()));
    }
  }
}
