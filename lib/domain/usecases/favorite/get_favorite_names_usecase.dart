import 'package:dartz/dartz.dart';
import 'package:ninety/core/common/error/app_error.dart';
import 'package:ninety/core/common/helpers/error_catcher.dart';
import 'package:ninety/domain/entities/name.dart';
import 'package:ninety/domain/params/favorite/get_favorite_names_param.dart';
import 'package:ninety/domain/repositories/favorite/i_favorite_name_repository.dart';
import 'package:ninety/domain/usecases/usecase.dart';

class GetFavoriteNamesUsecase
    implements Usecase<GetFavoriteNamesParam, List<Name>> {
  final IFavoriteNameRepository _favoriteNameRepository;
  GetFavoriteNamesUsecase(this._favoriteNameRepository);

  @override
  Future<Either<AppError, List<Name>>> trigger(
      GetFavoriteNamesParam param) async {
    return await ErrorCatcher.trycatch(
        _favoriteNameRepository.getFavoriteNames(param));
  }
}
