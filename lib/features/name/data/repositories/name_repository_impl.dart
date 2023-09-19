import 'package:dartz/dartz.dart';
import 'package:ninety/features/name/data/models/i_name_model.dart';
import '../../../../core/error/app_error.dart';
import '../../domain/repositories/name_repository/i_name_repository.dart';
import 'i_data_sources_repository.dart';

class NameRepositoryImpl implements INameRepository {
  final INameDataSource _nameDataSource;

  NameRepositoryImpl(this._nameDataSource);

  @override
  Future<Either<AppError, List<ITranslationModel>>> getNames(String lang) {
    return _nameDataSource.getNames(lang);
  }
}
