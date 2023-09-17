import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:ninety/core/error/app_error.dart';
import 'package:ninety/features/name/data/datasources/local_data_sources/name/i_name_local_datasource.dart';
import 'package:ninety/features/name/data/datasources/local_data_sources/name/local_names.dart';
import 'package:ninety/features/name/data/models/name.dart';
import 'package:ninety/features/name/domain/entities/name/name.dart';

class NameLocalDataSourceImpl implements INameLocalDataSource {
  @override
  Future<Either<AppError, List<Name>>> getNames() async {
    try {
      List<NameModel> localNames = LocalNamesProvider.names;
      return right(localNames);
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      return left(GenericAppError("Fail to load names..."));
    }
  }
}
