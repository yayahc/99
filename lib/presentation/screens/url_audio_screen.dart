import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ninety/core/extensions/context_extension.dart';

class UrlAudioScreen extends StatefulWidget {
  const UrlAudioScreen({super.key});

// https://download.quranicaudio.com/quran/abdurrahmaan_as-sudays/001.mp3
  static const _url =
      'https://download.quranicaudio.com/quran/abdurrahmaan_as-sudays/001.mp3';

  @override
  State<UrlAudioScreen> createState() => _UrlAudioScreenState();
}

class _UrlAudioScreenState extends State<UrlAudioScreen> {
  late final AudioPlayer _player;
  PlayerState _state = PlayerState.stopped;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  String? _error;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _player.onPlayerStateChanged.listen((s) {
      if (mounted) setState(() => _state = s);
    });
    _player.onPositionChanged.listen((p) {
      if (mounted) setState(() => _position = p);
    });
    _player.onDurationChanged.listen((d) {
      if (mounted) setState(() => _duration = d);
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _togglePlay() async {
    setState(() => _error = null);
    try {
      if (_state == PlayerState.playing) {
        await _player.pause();
      } else {
        await _player.play(UrlSource(UrlAudioScreen._url));
      }
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    }
  }

  Future<void> _stop() async {
    await _player.stop();
    if (mounted) setState(() => _position = Duration.zero);
  }

  String _fmt(Duration d) {
    final mm = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final ss = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$mm:$ss';
  }

  @override
  Widget build(BuildContext context) {
    final isPlaying = _state == PlayerState.playing;
    final isBuffering =
        _state == PlayerState.playing && _duration == Duration.zero;
    final total = _duration.inMilliseconds == 0
        ? 1.0
        : _duration.inMilliseconds.toDouble();
    final value =
        _position.inMilliseconds.clamp(0, _duration.inMilliseconds).toDouble();

    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        backgroundColor: context.colors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: context.colors.black),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Audio test',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: context.colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Surah Al-Fatiha — Abdurrahmaan As-Sudays',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: context.colors.black,
              ),
            ),
            SizedBox(height: 8.sp),
            Text(
              UrlAudioScreen._url,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.sp,
                color: Colors.grey.shade500,
              ),
            ),
            const Spacer(),
            Slider(
              min: 0,
              max: total,
              value: value.clamp(0, total),
              onChanged: _duration == Duration.zero
                  ? null
                  : (v) => _player.seek(Duration(milliseconds: v.toInt())),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_fmt(_position),
                      style: TextStyle(
                          fontSize: 12.sp, color: context.colors.black)),
                  Text(_fmt(_duration),
                      style: TextStyle(
                          fontSize: 12.sp, color: context.colors.black)),
                ],
              ),
            ),
            SizedBox(height: 16.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 36.sp,
                  onPressed: _stop,
                  icon: Icon(Icons.stop_rounded, color: context.colors.black),
                ),
                SizedBox(width: 24.sp),
                GestureDetector(
                  onTap: _togglePlay,
                  child: Container(
                    width: 72.sp,
                    height: 72.sp,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.colors.primary,
                    ),
                    alignment: Alignment.center,
                    child: isBuffering
                        ? SizedBox(
                            width: 24.sp,
                            height: 24.sp,
                            child: const CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 3),
                          )
                        : Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 40.sp,
                          ),
                  ),
                ),
                SizedBox(width: 24.sp + 36.sp),
              ],
            ),
            if (_error != null) ...[
              SizedBox(height: 16.sp),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red, fontSize: 12.sp),
              ),
            ],
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
