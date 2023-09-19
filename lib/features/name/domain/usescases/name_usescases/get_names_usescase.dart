import 'package:dartz/dartz.dart';
import 'package:ninety/core/error/app_error.dart';
import 'package:ninety/core/usescase/usescase.dart';
import 'package:ninety/features/name/data/models/i_name_model.dart';
import 'package:ninety/features/name/domain/repositories/name_repository/i_name_repository.dart';

class GetNamesUsesCase implements UsesCase<List<ITranslationModel>> {
  final INameRepository nameRepository;

  GetNamesUsesCase(this.nameRepository);

  @override
  Future<Either<AppError, List<ITranslationModel>>> trigger(String lang) {
    return nameRepository.getNames(lang);
  }
}
