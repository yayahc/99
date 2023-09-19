import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:ninety/features/name/data/models/i_name_model.dart';
import '../../../../../../core/error/app_error.dart';
import '../../../repositories/i_data_sources_repository.dart';
import 'local_names.dart';

class NameLocalDataSourceImpl implements INameDataSource {
  @override
  Future<Either<AppError, List<ITranslationModel>>> getNames(
      String lang) async {
    try {
      List<ITranslationModel> localNames = LocalNames.getList(lang);
      return right(localNames);
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      return left(GenericAppError("Fail to load names..."));
    }
  }
}
