import 'package:bloc/bloc.dart';
import 'package:ninety/domain/params/favorite/add_name_to_favorite_param.dart';
import 'package:ninety/domain/params/favorite/get_favorite_names_param.dart';
import 'package:ninety/domain/params/favorite/remove_name_to_favorite_param.dart';
import 'package:ninety/presentation/bloc/favorite_state.dart';
import '../../domain/usecases/favorite/add_name_to_favorite_usecase.dart';
import '../../domain/usecases/favorite/get_favorite_names_usecase.dart';
import '../../domain/usecases/favorite/remove_name_to_favorite_usecase.dart';

class FavoriteCubit extends Cubit<FavoriteNamesState> {
  final AddNameToFavoriteUsecase _addNameToFavoriteUsecase;
  final GetFavoriteNamesUsecase _getFavoriteNamesUsecase;
  final RemoveNameToFavoriteUsecase _removeNameToFavoriteUsecase;
  FavoriteCubit(this._addNameToFavoriteUsecase, this._getFavoriteNamesUsecase,
      this._removeNameToFavoriteUsecase)
      : super(InitialFavoriteNamesState());

  void loadFavotiresNames() async {
    emit(FavoriteNamesLoadingState());
    final result =
        await _getFavoriteNamesUsecase.trigger(GetFavoriteNamesParam());
    result.fold(
        (error) =>
            emit(ErrorLoadingFavoriteNamesState(error: error.getError())),
        (names) => emit(FavoriteNamesLoadedState(names: names)));
  }

  void addNameToFavorite(int id) async {
    emit(AddFavoriteNamesState());
    final result =
        await _addNameToFavoriteUsecase.trigger(AddNameToFavoriteParam(id));
    result.fold(
        (error) => emit(ErrorAddingFavoriteNamesState(error: error.getError())),
        (_) => emit(FavoriteNamesAddedState()));
    loadFavotiresNames();
  }

  void removeNameToFavorite(int id) async {
    emit(RemoveFavoriteNamesState());
    final result = await _removeNameToFavoriteUsecase
        .trigger(RemoveNameToFavoriteParam(id));
    result.fold(
        (error) =>
            emit(ErrorRemovingFavoriteNamesState(error: error.getError())),
        (_) => emit(FavoriteNamesRemovedState()));
    loadFavotiresNames();
  }
}
