import 'package:dartz/dartz.dart';
import 'package:ninety/features/name/data/datasources/local_data_sources/name/i_name_local_datasource.dart';
import 'package:ninety/features/name/data/models/i_name_model.dart';
import '../../../../core/error/app_error.dart';
import '../../domain/repositories/name_repository/i_name_repository.dart';

class NameRepositoryImpl implements INameRepository {
  final INameLocalDataSource _nameLocalDataSource;

  NameRepositoryImpl(this._nameLocalDataSource);

  @override
  Future<Either<AppError, List<ITranslationModel>>> getNames(String lang) {
    return _nameLocalDataSource.getNames(lang);
  }
}
