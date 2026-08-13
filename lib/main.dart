import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ninety/di.dart';
import 'package:ninety/domain/entities/app_language.dart';
import 'package:ninety/domain/params/settings/get_language_param.dart';
import 'package:ninety/domain/usecases/settings/get_language_usecase.dart';
import 'package:ninety/init_app.dart';
import 'package:ninety/services/quran_audio/quran_auto_play_service.dart';
import 'package:ninety/services/audio_player/audio_player_service.dart';
import 'package:ninety/services/home_widget/home_widget_service.dart';
import 'package:ninety/services/notifications/daily_notification_service.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'root.dart';

Future<void> main() async {
  await init();
  AudioPlayerService().init();
  AudioPlayerService.instance.listen();
  await HomeWidgetService.instance.init();
  final language = await _storedLanguage();
  try {
    await DailyNotificationService.initialize();
    await DailyNotificationService.requestPermissions();
    await DailyNotificationService.scheduleDailyReminders(
      locale: language.locale,
    );
  } catch (e, s) {
    debugPrint('Daily notification setup failed: $e\n$s');
  }
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const Root());

  locator.get<QuranAutoPlayService>().startIfEnabled();

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("df6856bc-d3d1-48fc-a103-0bb7c2f5cd49");
  OneSignal.Notifications.requestPermission(false);
}

Future<AppLanguage> _storedLanguage() async {
  final result = await locator.get<GetLanguageUsecase>().trigger(
        GetLanguageParam(),
      );
  return result.fold((_) => AppLanguage.system, (language) => language);
}
