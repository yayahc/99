import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:ninety/domain/entities/app_language.dart';
import 'package:ninety/domain/params/settings/get_language_param.dart';
import 'package:ninety/domain/params/settings/set_language_param.dart';
import 'package:ninety/domain/usecases/settings/get_language_usecase.dart';
import 'package:ninety/domain/usecases/settings/set_language_usecase.dart';
import 'package:ninety/services/notifications/daily_notification_service.dart';

class LanguageCubit extends Cubit<AppLanguage> {
  final GetLanguageUsecase _getLanguageUsecase;
  final SetLanguageUsecase _setLanguageUsecase;

  LanguageCubit(this._getLanguageUsecase, this._setLanguageUsecase)
      : super(AppLanguage.system);

  Future<void> loadLanguage() async {
    final result = await _getLanguageUsecase.trigger(GetLanguageParam());
    result.fold((_) => emit(AppLanguage.system), emit);
  }

  Future<void> setLanguage(AppLanguage language) async {
    if (language == state) return;
    emit(language);
    await _setLanguageUsecase.trigger(SetLanguageParam(language));
    try {
      await DailyNotificationService.scheduleDailyReminders(
        locale: language.locale,
      );
    } catch (e, s) {
      debugPrint(
          'Rescheduling reminders after a language change failed: $e\n$s');
    }
  }
}
