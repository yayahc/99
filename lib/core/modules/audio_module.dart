import 'package:audio_service/audio_service.dart';
import 'package:injectable/injectable.dart';
import 'package:ninety/services/audio/background_audio_handler.dart';

@module
abstract class AudioModule {
  @preResolve
  @singleton
  Future<BackgroundAudioHandler> get audioHandler => AudioService.init(
        builder: BackgroundAudioHandler.new,
        config: const AudioServiceConfig(
          androidNotificationChannelId: 'dev.ninety.audio',
          androidNotificationChannelName: 'Playback',
          androidNotificationOngoing: true,
          androidStopForegroundOnPause: true,
        ),
      );
}
