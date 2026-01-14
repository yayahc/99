import 'package:equatable/equatable.dart';
import 'package:ninety/domain/entities/name.dart';

sealed class FavoriteNamesState extends Equatable {}

class InitialFavoriteNamesState extends FavoriteNamesState {
  @override
  List<Object?> get props => [];
}

class FavoriteNamesLoadingState extends FavoriteNamesState {
  @override
  List<Object?> get props => [];
}

class FavoriteNamesLoadedState extends FavoriteNamesState {
  final List<Name> names;

  FavoriteNamesLoadedState({required this.names});
  @override
  List<Object?> get props => [names];
}

class ErrorLoadingFavoriteNamesState extends FavoriteNamesState {
  final String error;

  ErrorLoadingFavoriteNamesState({required this.error});
  @override
  List<Object?> get props => [error];
}

// +
class AddFavoriteNamesState extends FavoriteNamesState {
  @override
  List<Object?> get props => [];
}

class FavoriteNamesAddedState extends FavoriteNamesState {
  @override
  List<Object?> get props => [];
}

class ErrorAddingFavoriteNamesState extends FavoriteNamesState {
  final String error;

  ErrorAddingFavoriteNamesState({required this.error});
  @override
  List<Object?> get props => [error];
}

// -
class RemoveFavoriteNamesState extends FavoriteNamesState {
  @override
  List<Object?> get props => [];
}

class FavoriteNamesRemovedState extends FavoriteNamesState {
  @override
  List<Object?> get props => [];
}

class ErrorRemovingFavoriteNamesState extends FavoriteNamesState {
  final String error;

  ErrorRemovingFavoriteNamesState({required this.error});
  @override
  List<Object?> get props => [error];
}
