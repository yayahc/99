import 'dart:async';
import 'dart:developer';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:ninety/di.dart';
import 'package:ninety/services/audio/background_audio_handler.dart';

import '../../core/models/name_source.dart';

/// Local replacement for the old `audioplayers.PlayerState` enum so the rest of
/// the UI can keep its existing pattern. Only `playing` and `paused`/`stopped`
/// distinctions are observed elsewhere.
enum PlayerState { stopped, playing, paused, completed }

/// Thin wrapper that exposes the names-of-Allah audio surface in the shape the
/// UI already knows about (static notifiers + a play-request stream), while
/// delegating actual playback to [BackgroundAudioHandler] so it survives the
/// app being backgrounded.
class AudioPlayerService {
  static late final StreamController<NameAudioSource> _playableStream;
  static StreamController<NameAudioSource> get playableStream =>
      _playableStream;

  static late final AudioPlayerService _instance;
  static AudioPlayerService get instance => _instance;

  static late final ValueNotifier<PlayerState> _playerStateNotifier;
  static ValueNotifier<PlayerState> get playerStateNotifier =>
      _playerStateNotifier;

  static late final ValueNotifier<String?> _currentSourceNotifier;
  static ValueNotifier<String?> get currentSourceNotifier =>
      _currentSourceNotifier;

  static BackgroundAudioHandler get _handler =>
      locator.get<BackgroundAudioHandler>();

  /// Facade kept for backward compatibility. UI calls
  /// `AudioPlayerService.player.pause()`.
  static PlayerFacade get player => PlayerFacade(_handler);

  void init() {
    _instance = AudioPlayerService();
    _playableStream = StreamController<NameAudioSource>();
    _playerStateNotifier = ValueNotifier(PlayerState.stopped);
    _currentSourceNotifier = ValueNotifier(null);
  }

  void dispose() {
    _playableStream.close();
  }

  void listen() {
    _listenToHandlerState();
    _playableStream.stream.listen(_play);
  }

  Future<void> _play(NameAudioSource nameSource) async {
    final asset = nameSource.path ?? nameSource.url;
    if (asset == null) return;
    try {
      _currentSourceNotifier.value = asset;
      await _handler.playAsset(
        assetPath: asset,
        kind: AudioKind.name,
        item: MediaItem(
          id: asset,
          album: '99 Names of Allah',
          title: _titleFromAsset(asset),
          artist: 'Asma ul Husna',
        ),
      );
    } catch (e) {
      log(e.toString());
    }
  }

  void _listenToHandlerState() {
    _handler.playbackState.listen((state) {
      // Only reflect the names audio surface here. When the Quran is in
      // control of the shared player we want the name buttons to look idle.
      if (_handler.kind != AudioKind.name) {
        _playerStateNotifier.value = PlayerState.stopped;
        _currentSourceNotifier.value = null;
        return;
      }
      if (state.processingState == AudioProcessingState.completed) {
        _playerStateNotifier.value = PlayerState.completed;
        _currentSourceNotifier.value = null;
        return;
      }
      _playerStateNotifier.value =
          state.playing ? PlayerState.playing : PlayerState.paused;
      _currentSourceNotifier.value = _handler.currentId;
    });
  }

  String _titleFromAsset(String asset) {
    final segments = asset.split('/');
    final file = segments.isEmpty ? asset : segments.last;
    return file.replaceAll('.mp3', '').replaceAll('_', ' ');
  }
}

class PlayerFacade {
  final BackgroundAudioHandler _handler;
  PlayerFacade(this._handler);

  Future<void> pause() => _handler.pause();
  Future<void> resume() => _handler.play();
  Future<void> stop() => _handler.stop();
}
