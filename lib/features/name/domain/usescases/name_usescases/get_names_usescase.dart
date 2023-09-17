import 'package:dartz/dartz.dart';
import 'package:ninety/core/error/app_error.dart';
import 'package:ninety/core/usescase/usescase.dart';
import 'package:ninety/features/name/domain/entities/name/name.dart';
import 'package:ninety/features/name/domain/repositories/name_repository/i_name_repository.dart';

class GetNamesUsesCase implements UsesCase<List<Name>> {
  final INameRepository nameRepository;

  GetNamesUsesCase(this.nameRepository);

  @override
  Future<Either<AppError, List<Name>>> trigger() {
    return nameRepository.getNames();
  }
}
