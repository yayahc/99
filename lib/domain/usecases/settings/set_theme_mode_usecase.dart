import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ninety/core/error/app_error.dart';
import 'package:ninety/core/helpers/error_catcher.dart';
import 'package:ninety/domain/params/settings/set_theme_mode_param.dart';
import 'package:ninety/domain/repositories/settings/i_settings_repository.dart';
import 'package:ninety/domain/usecases/usecase.dart';

@singleton
class SetThemeModeUsecase implements Usecase<SetThemeModeParam, void> {
  final ISettingsRepository _settingsRepository;
  SetThemeModeUsecase(this._settingsRepository);

  @override
  Future<Either<AppError, void>> trigger(SetThemeModeParam param) async {
    return await ErrorCatcher.trycatch(
        _settingsRepository.setThemeMode(param));
  }
}
