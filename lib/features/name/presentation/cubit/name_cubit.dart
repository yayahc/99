import 'package:bloc/bloc.dart';
import 'package:ninety/features/name/domain/usescases/name_usescases/get_names_usescase.dart';

class NameCubit extends Cubit<GetNamesUsesCase> {
  NameCubit(super.initialState);

  void getName(int id) async {
    final nametrigger = await state.trigger();
    final name = nametrigger.fold((l) => null, (r) => null);
    emit(name);
  }
}
