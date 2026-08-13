import 'dart:async';
import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

/// Identifies which surface owns the current media session.
///
/// Used by the per-surface controllers (names of Allah, Quran) so each only
/// reflects state when its own content is actually playing.
enum AudioKind { none, name, quran }

/// The single playback unit for the app. Wraps one `just_audio` player and
/// exposes it as an `audio_service` handler so playback survives backgrounding
/// and surfaces in lock-screen / Control Center / notification controls.
class BackgroundAudioHandler extends BaseAudioHandler with SeekHandler {
  final AudioPlayer _player = AudioPlayer();

  AudioKind _kind = AudioKind.none;
  AudioKind get kind => _kind;

  /// Identifier of the active item within its kind (e.g. asset path for a
  /// name, surah number string for the Quran). `null` when idle.
  String? _currentId;
  String? get currentId => _currentId;

  AudioPlayer get player => _player;

  /// Optional callback fired when the currently-playing track finishes
  /// naturally (used by Quran auto-advance).
  VoidCallback? onComplete;

  BackgroundAudioHandler() {
    _player.playbackEventStream.listen(_broadcastState);
    _player.processingStateStream.listen((s) {
      if (s == ProcessingState.completed) {
        onComplete?.call();
      }
    });
  }

  Future<void> playAsset({
    required String assetPath,
    required AudioKind kind,
    required MediaItem item,
    double volume = 1,
  }) async {
    _kind = kind;
    _currentId = item.id;
    mediaItem.add(item);
    await _player.setVolume(volume);
    await _player.setAsset(assetPath);
    await _player.play();
  }

  Future<void> playUrl({
    required String url,
    required AudioKind kind,
    required MediaItem item,
    double volume = 1,
  }) async {
    _kind = kind;
    _currentId = item.id;
    mediaItem.add(item);
    await _player.setVolume(volume);
    await _player.setUrl(url);
    await _player.play();
  }

  Future<void> setVolume(double volume) => _player.setVolume(volume);

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() async {
    await _player.stop();
    _kind = AudioKind.none;
    _currentId = null;
    mediaItem.add(null);
    await super.stop();
  }

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  void _broadcastState(PlaybackEvent event) {
    final playing = _player.playing;
    playbackState.add(playbackState.value.copyWith(
      controls: [
        MediaControl.skipToPrevious,
        if (playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.skipToNext,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    ));
  }
}
