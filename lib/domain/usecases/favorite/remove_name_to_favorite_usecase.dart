import 'package:dartz/dartz.dart';
import 'package:ninety/core/common/error/app_error.dart';
import 'package:ninety/core/common/helpers/error_catcher.dart';
import 'package:ninety/domain/params/favorite/remove_name_to_favorite_param.dart';
import 'package:ninety/domain/repositories/favorite/i_favorite_name_repository.dart';
import 'package:ninety/domain/usecases/usecase.dart';

class RemoveNameToFavoriteUsecase
    implements Usecase<RemoveNameToFavoriteParam, void> {
  final IFavoriteNameRepository _favoriteNameRepository;
  RemoveNameToFavoriteUsecase(this._favoriteNameRepository);

  @override
  Future<Either<AppError, void>> trigger(
      RemoveNameToFavoriteParam param) async {
    return await ErrorCatcher.trycatch(
        _favoriteNameRepository.removeNameToFavorite(param));
  }
}
