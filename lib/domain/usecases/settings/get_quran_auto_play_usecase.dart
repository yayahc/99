import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ninety/core/error/app_error.dart';
import 'package:ninety/core/helpers/error_catcher.dart';
import 'package:ninety/domain/entities/quran_auto_play.dart';
import 'package:ninety/domain/params/settings/get_quran_auto_play_param.dart';
import 'package:ninety/domain/repositories/settings/i_settings_repository.dart';
import 'package:ninety/domain/usecases/usecase.dart';

@singleton
class GetQuranAutoPlayUsecase
    implements Usecase<GetQuranAutoPlayParam, QuranAutoPlay> {
  final ISettingsRepository _settingsRepository;
  GetQuranAutoPlayUsecase(this._settingsRepository);

  @override
  Future<Either<AppError, QuranAutoPlay>> trigger(
      GetQuranAutoPlayParam param) async {
    return await ErrorCatcher.trycatch(_settingsRepository.getQuranAutoPlay());
  }
}
