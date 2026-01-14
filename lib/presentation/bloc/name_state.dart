import 'package:equatable/equatable.dart';
import 'package:ninety/domain/entities/name.dart';

sealed class NameState extends Equatable {}

class NamesLoadingState extends NameState {
  @override
  List<Object?> get props => [];
}

class NamesLoadedState extends NameState {
  final List<Name> names;

  NamesLoadedState({required this.names});
  @override
  List<Object?> get props => [names];
}

class ErrorLoadingNamesState extends NameState {
  final String error;

  ErrorLoadingNamesState({required this.error});
  @override
  List<Object?> get props => [error];
}

class InitialNamesState extends NameState {
  @override
  List<Object?> get props => [];
}
