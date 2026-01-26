import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ninety/init_app.dart';
import 'package:ninety/services/audio_player/audio_player_service.dart';
import 'root.dart';

Future<void> main() async {
  await init();
  AudioPlayerService().init();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(const Root()));
}
