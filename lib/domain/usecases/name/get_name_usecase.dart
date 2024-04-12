import 'package:dartz/dartz.dart';
import 'package:ninety/core/common/error/app_error.dart';
import 'package:ninety/core/common/helpers/error_catcher.dart';
import 'package:ninety/domain/entities/name.dart';
import 'package:ninety/domain/repositories/name/name_repository.dart';
import 'package:ninety/domain/usecases/usecase.dart';
import '../../params/get_name_param.dart';

class GetNameUsecase implements Usecase<GetNameParam, Name> {
  final INameRepository _nameRepository;

  GetNameUsecase(this._nameRepository);

  @override
  Future<Either<AppError, Name>> trigger(GetNameParam param) async {
    return await ErrorCatcher.trycatch(_nameRepository.getName(param));
  }
}
