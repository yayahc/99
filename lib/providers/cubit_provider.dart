import 'package:bloc/bloc.dart';
import 'package:ninety/core/models/name.dart';

class CubitProvider extends Cubit<List<Name>> {
  CubitProvider(super.initialState);

  void showName(int nameID) {}
}
