import 'package:bloc/bloc.dart';
import 'package:ninety/features/name/domain/usescases/name_usescases/get_names_usescase.dart';
import '../../domain/entities/name/name.dart';

class NameCubit extends Cubit<List<Name>?> {
  final GetNamesUsesCase _getNamesUsesCase;
  NameCubit(super.initialState, this._getNamesUsesCase);

  Future<List<Name>?> getName(int id) async {
    final namesTrigger = await _getNamesUsesCase.trigger();
    if (namesTrigger.isRight()) {
      final names = namesTrigger.fold((l) => null, (r) => r);
      emit(names);
    }
    emit([]);
    return null;
  }
}
