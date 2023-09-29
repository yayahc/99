import 'package:dartz/dartz.dart';
import 'package:ninety/core/error/app_error.dart';
import 'package:ninety/features/name/data/models/i_name_model.dart';

abstract class INameDataSource {
  Future<Either<AppError, List<ITranslationModel>>> getNames(String lang);
}
