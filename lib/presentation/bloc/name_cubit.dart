import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninety/domain/params/names/get_names_param.dart';
import 'package:ninety/presentation/bloc/name_state.dart';
import '../../domain/usecases/name/get_names_usecase.dart';

class NameCubit extends Cubit<NameState> {
  final GetNamesUsecase _getNamesUsecase;
  NameCubit(this._getNamesUsecase) : super(InitialNamesState());

  void loadNames() async {
    emit(NamesLoadingState());
    final result = await _getNamesUsecase.trigger(GetNamesParam());
    result.fold(
        (error) => emit(ErrorLoadingNamesState(error: error.getError())),
        (names) => emit(NamesLoadedState(names: names)));
  }
}
