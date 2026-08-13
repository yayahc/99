import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ninety/core/error/app_error.dart';
import 'package:ninety/core/helpers/error_catcher.dart';
import 'package:ninety/domain/entities/app_language.dart';
import 'package:ninety/domain/params/settings/get_language_param.dart';
import 'package:ninety/domain/repositories/settings/i_settings_repository.dart';
import 'package:ninety/domain/usecases/usecase.dart';

@singleton
class GetLanguageUsecase implements Usecase<GetLanguageParam, AppLanguage> {
  final ISettingsRepository _settingsRepository;
  GetLanguageUsecase(this._settingsRepository);

  @override
  Future<Either<AppError, AppLanguage>> trigger(GetLanguageParam param) async {
    return await ErrorCatcher.trycatch(_settingsRepository.getLanguage());
  }
}
