import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ninety/core/error/app_error.dart';
import 'package:ninety/core/helpers/error_catcher.dart';
import 'package:ninety/domain/params/settings/set_language_param.dart';
import 'package:ninety/domain/repositories/settings/i_settings_repository.dart';
import 'package:ninety/domain/usecases/usecase.dart';

@singleton
class SetLanguageUsecase implements Usecase<SetLanguageParam, void> {
  final ISettingsRepository _settingsRepository;
  SetLanguageUsecase(this._settingsRepository);

  @override
  Future<Either<AppError, void>> trigger(SetLanguageParam param) async {
    return await ErrorCatcher.trycatch(_settingsRepository.setLanguage(param));
  }
}
