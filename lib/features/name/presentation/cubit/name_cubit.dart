import 'package:bloc/bloc.dart';
import 'package:ninety/features/name/data/models/name.dart';

class CubitProvider extends Cubit<List<Name>> {
  CubitProvider(super.initialState);

  Name getName(int id) {
    final name = state.where((name) => name.id == id).first;
    return name;
  }
}
