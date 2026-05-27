import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:ninety/data/datasources/local/reciters_data.dart';
import 'package:ninety/data/datasources/local/surahs_data.dart';
import 'package:ninety/domain/entities/reciter.dart';
import 'package:ninety/domain/entities/surah.dart';

@singleton
class QuranAudioController extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
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

  QuranAudioController() {
    _subs.add(_player.onPlayerStateChanged.listen((s) {
      _state = s;
      if (s == PlayerState.playing) _buffering = false;
      notifyListeners();
    }));
    _subs.add(_player.onPositionChanged.listen((p) {
      _position = p;
      notifyListeners();
    }));
    _subs.add(_player.onDurationChanged.listen((d) {
      _duration = d;
      notifyListeners();
    }));
    _subs.add(_player.onPlayerComplete.listen((_) => playNext()));
  }

  Future<void> selectReciter(Reciter r) async {
    if (r.slug == _reciter.slug) return;
    await _player.stop();
    _reciter = r;
    _current = null;
    _position = Duration.zero;
    _duration = Duration.zero;
    _buffering = false;
    notifyListeners();
  }

  Future<void> play(Surah surah) async {
    _current = surah;
    _position = Duration.zero;
    _duration = Duration.zero;
    _buffering = true;
    notifyListeners();
    try {
      await _player
          .play(UrlSource(RecitersData.audioUrl(_reciter, surah.number)));
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
    if (_state == PlayerState.playing) {
      await _player.pause();
    } else {
      await _player.resume();
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

  Future<void> seek(Duration d) => _player.seek(d);

  @override
  void dispose() {
    for (final s in _subs) {
      s.cancel();
    }
    _player.dispose();
    super.dispose();
  }
}
