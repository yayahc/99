import 'package:dartz/dartz.dart';
import 'package:ninety/core/common/error/app_error.dart';
import 'package:ninety/core/common/helpers/error_catcher.dart';
import 'package:ninety/domain/params/favorite/add_name_to_favorite_param.dart';
import 'package:ninety/domain/repositories/favorite/i_favorite_name_repository.dart';
import 'package:ninety/domain/usecases/usecase.dart';

class AddNameToFavoriteUsecase
    implements Usecase<AddNameToFavoriteParam, void> {
  final IFavoriteNameRepository _favoriteNameRepository;
  AddNameToFavoriteUsecase(this._favoriteNameRepository);

  @override
  Future<Either<AppError, void>> trigger(AddNameToFavoriteParam param) async {
    return await ErrorCatcher.trycatch(
        _favoriteNameRepository.addNameToFavorite(param));
  }
}
