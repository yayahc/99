import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ninety/core/error/app_error.dart';
import 'package:ninety/core/helpers/error_catcher.dart';
import 'package:ninety/domain/entities/name.dart';
import 'package:ninety/domain/params/names/get_names_param.dart';
import 'package:ninety/domain/repositories/name/i_name_repository.dart';
import 'package:ninety/domain/usecases/usecase.dart';

@singleton
class GetNamesUsecase implements Usecase<GetNamesParam, List<Name>> {
  final INameRepository _nameRepository;

  GetNamesUsecase(this._nameRepository);

  @override
  Future<Either<AppError, List<Name>>> trigger(GetNamesParam param) async {
    return await ErrorCatcher.trycatch(_nameRepository.getNames(param));
  }
}
