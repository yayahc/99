import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:ninety/core/error/app_error.dart';
import 'package:ninety/core/helpers/error_catcher.dart';
import 'package:ninety/domain/params/settings/get_theme_mode_param.dart';
import 'package:ninety/domain/repositories/settings/i_settings_repository.dart';
import 'package:ninety/domain/usecases/usecase.dart';

@singleton
class GetThemeModeUsecase implements Usecase<GetThemeModeParam, ThemeMode> {
  final ISettingsRepository _settingsRepository;
  GetThemeModeUsecase(this._settingsRepository);

  @override
  Future<Either<AppError, ThemeMode>> trigger(GetThemeModeParam param) async {
    return await ErrorCatcher.trycatch(_settingsRepository.getThemeMode());
  }
}
