import 'package:dartz/dartz.dart';
import 'package:ninety/features/name/data/datasources/local_data_sources/name/i_name_local_datasource.dart';
import '../../../../core/error/app_error.dart';
import '../../domain/entities/name/name.dart';
import '../../domain/repositories/name_repository/i_name_repository.dart';

class NameRepositoryImpl implements INameRepository {
  final INameLocalDataSource _nameLocalDataSource;

  NameRepositoryImpl(this._nameLocalDataSource);

  @override
  Future<Either<AppError, List<Name>>> getNames() {
    return _nameLocalDataSource.getNames();
  }
}
