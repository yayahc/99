import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart' hide PlayerState;
import 'package:ninety/data/datasources/local/reciters_data.dart';
import 'package:ninety/data/datasources/local/surahs_data.dart';
import 'package:ninety/domain/entities/reciter.dart';
import 'package:ninety/domain/entities/surah.dart';
import 'package:ninety/services/audio/background_audio_handler.dart';
import 'package:ninety/services/audio_player/audio_player_service.dart';

@singleton
class QuranAudioController extends ChangeNotifier {
  final BackgroundAudioHandler _handler;
  final List<StreamSubscription<dynamic>> _subs = [];

  Reciter _reciter = RecitersData.all.first;
  Surah? _current;
  PlayerState _state = PlayerState.stopped;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool _buffering = false;

  Reciter get reciter => _reciter;
  Surah? get current => _current;
  PlayerState get state => _state;
  bool get isPlaying => _state == PlayerState.playing;
  Duration get position => _position;
  Duration get duration => _duration;
  bool get buffering => _buffering;

  QuranAudioController(this._handler) {
    _handler.onComplete = _onTrackComplete;

    _subs.add(_handler.player.playerStateStream.listen((s) {
      if (_handler.kind != AudioKind.quran) {
        if (_state != PlayerState.stopped) {
          _state = PlayerState.stopped;
          _buffering = false;
          notifyListeners();
        }
        return;
      }
      final processing = s.processingState;
      _buffering = processing == ProcessingState.loading ||
          processing == ProcessingState.buffering;
      if (processing == ProcessingState.completed) {
        _state = PlayerState.completed;
      } else if (s.playing) {
        _state = PlayerState.playing;
      } else {
        _state = PlayerState.paused;
      }
      notifyListeners();
    }));

    _subs.add(_handler.player.positionStream.listen((p) {
      if (_handler.kind != AudioKind.quran) return;
      _position = p;
      notifyListeners();
    }));

    _subs.add(_handler.player.durationStream.listen((d) {
      if (_handler.kind != AudioKind.quran) return;
      _duration = d ?? Duration.zero;
      notifyListeners();
    }));
  }

  void _onTrackComplete() {
    if (_handler.kind == AudioKind.quran) {
      playNext();
    }
  }

  Future<void> selectReciter(Reciter r) async {
    if (r.slug == _reciter.slug) return;
    if (_handler.kind == AudioKind.quran) {
      await _handler.stop();
    }
    _reciter = r;
    _current = null;
    _position = Duration.zero;
    _duration = Duration.zero;
    _buffering = false;
    _state = PlayerState.stopped;
    notifyListeners();
  }

  Future<void> play(Surah surah) async {
    _current = surah;
    _position = Duration.zero;
    _duration = Duration.zero;
    _buffering = true;
    notifyListeners();
    try {
      await _handler.playUrl(
        url: RecitersData.audioUrl(_reciter, surah.number),
        kind: AudioKind.quran,
        item: MediaItem(
          id: 'quran/${_reciter.slug}/${surah.number}',
          album: 'Holy Quran',
          title: '${surah.number}. ${surah.nameLatin} · ${surah.meaning}',
          artist: _reciter.nameLatin,
        ),
      );
    } catch (_) {
      _buffering = false;
      notifyListeners();
    }
  }

  Future<void> togglePlay() async {
    if (_current == null) {
      await play(SurahsData.all.first);
      return;
    }
    if (_handler.kind != AudioKind.quran) {
      // Something else (a Name) is on the shared player — restart the surah.
      await play(_current!);
      return;
    }
    if (_state == PlayerState.playing) {
      await _handler.pause();
    } else {
      await _handler.play();
    }
  }

  Future<void> playNext() async {
    if (_current == null) return;
    final next = _current!.number + 1;
    if (next > SurahsData.all.length) return;
    await play(SurahsData.all[next - 1]);
  }

  Future<void> playPrev() async {
    if (_current == null) return;
    final prev = _current!.number - 1;
    if (prev < 1) return;
    await play(SurahsData.all[prev - 1]);
  }

  Future<void> seek(Duration d) {
    _position = d;
    notifyListeners();
    return _handler.seek(d);
  }

  @override
  void dispose() {
    for (final s in _subs) {
      s.cancel();
    }
    if (_handler.onComplete == _onTrackComplete) {
      _handler.onComplete = null;
    }
    super.dispose();
  }
}
