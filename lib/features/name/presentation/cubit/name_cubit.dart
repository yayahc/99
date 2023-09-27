import 'package:bloc/bloc.dart';
import 'package:ninety/features/name/data/models/i_name_model.dart';
import '../../domain/usescases/name_usescases/get_names_usescase.dart';

class NameCubitState {
  String lang;
  List<ITranslationModel>? names;
  NameCubitState(this.lang, this.names);
}

class NameCubit extends Cubit<NameCubitState> {
  final GetNamesUsesCase _getNamesUsesCase;
  NameCubit(super.initialState, this._getNamesUsesCase);

  Future<void> getName(String lang) async {
    final namesTrigger = await _getNamesUsesCase.trigger(lang);
    if (namesTrigger.isRight()) {
      final names = namesTrigger.fold((l) => null, (r) => r);
      emit(NameCubitState(lang, names));
      return;
    }
    emit(NameCubitState(lang, []));
  }
}
