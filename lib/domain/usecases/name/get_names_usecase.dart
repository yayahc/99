import 'package:dartz/dartz.dart';
import 'package:ninety/core/common/error/app_error.dart';
import 'package:ninety/core/common/helpers/error_catcher.dart';
import 'package:ninety/domain/entities/name.dart';
import 'package:ninety/domain/params/get_names_param.dart';
import 'package:ninety/domain/repositories/name/name_repository.dart';
import 'package:ninety/domain/usecases/usecase.dart';

class GetNamesUsecase implements Usecase<GetNamesParam, List<Name>> {
  final INameRepository _nameRepository;

  GetNamesUsecase(this._nameRepository);

  @override
  Future<Either<AppError, List<Name>>> trigger(GetNamesParam param) async {
    return await ErrorCatcher.trycatch(_nameRepository.getNames(param));
  }
}
