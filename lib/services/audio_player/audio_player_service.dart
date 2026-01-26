import 'dart:async';
import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:ninety/core/extensions/extensions.dart';
import '../../core/models/name_source.dart';

class AudioPlayerService {
  static late final StreamController<NameAudioSource> _playableStream;
  static StreamController<NameAudioSource> get playableStream =>
      _playableStream;
  static late final AudioPlayer _player;
  static AudioPlayer get player => _player;
  static late final AudioPlayerService _instance;
  static AudioPlayerService get instance => _instance;
  static late final ValueNotifier<PlayerState> _playerStateNotifier;
  static ValueNotifier<PlayerState> get playerStateNotifier =>
      _playerStateNotifier;

  void init() {
    _instance = AudioPlayerService();
    _player = AudioPlayer();
    _playableStream = StreamController<NameAudioSource>();
    _playerStateNotifier = ValueNotifier(PlayerState.stopped);
  }

  void dispose() {
    playableStream.close();
    _player.dispose();
  }

  void listen() {
    _listenToStateEvent();
    playableStream.stream.listen((nameSource) {
      try {
        _player.play(
            AssetSource((nameSource.path ?? nameSource.url ?? '').normalyze));
      } catch (e) {
        log(e.toString());
      }
    });
  }

  void _listenToStateEvent() {
    _player.onPlayerStateChanged
        .listen((PlayerState s) => _playerStateNotifier.value = s);
  }
}
