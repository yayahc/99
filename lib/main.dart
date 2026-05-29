import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ninety/init_app.dart';
import 'package:ninety/services/audio_player/audio_player_service.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'root.dart';

Future<void> main() async {
  await init();
  AudioPlayerService().init();
  AudioPlayerService.instance.listen();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const Root());

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("df6856bc-d3d1-48fc-a103-0bb7c2f5cd49");
  OneSignal.Notifications.requestPermission(false);
}
