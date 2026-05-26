import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:ninety/domain/params/settings/get_theme_mode_param.dart';
import 'package:ninety/domain/params/settings/set_theme_mode_param.dart';
import 'package:ninety/domain/usecases/settings/get_theme_mode_usecase.dart';
import 'package:ninety/domain/usecases/settings/set_theme_mode_usecase.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final GetThemeModeUsecase _getThemeModeUsecase;
  final SetThemeModeUsecase _setThemeModeUsecase;

  ThemeCubit(this._getThemeModeUsecase, this._setThemeModeUsecase)
      : super(ThemeMode.system);

  Future<void> loadThemeMode() async {
    final result = await _getThemeModeUsecase.trigger(GetThemeModeParam());
    result.fold((_) => emit(ThemeMode.system), emit);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    emit(mode);
    await _setThemeModeUsecase.trigger(SetThemeModeParam(mode));
  }
}
