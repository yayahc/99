import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ninety/core/extensions/context_extension.dart';
import 'package:ninety/data/datasources/local/reciters_data.dart';
import 'package:ninety/data/datasources/local/surahs_data.dart';
import 'package:ninety/domain/entities/reciter.dart';
import 'package:ninety/domain/entities/surah.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  late final AudioPlayer _player;

  Reciter _reciter = RecitersData.all.first;
  Surah? _current;
  PlayerState _state = PlayerState.stopped;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool _buffering = false;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _player.onPlayerStateChanged.listen((s) {
      if (!mounted) return;
      setState(() {
        _state = s;
        if (s == PlayerState.playing) _buffering = false;
      });
    });
    _player.onPositionChanged.listen((p) {
      if (mounted) setState(() => _position = p);
    });
    _player.onDurationChanged.listen((d) {
      if (mounted) setState(() => _duration = d);
    });
    _player.onPlayerComplete.listen((_) => _playNext());
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _selectReciter(Reciter r) async {
    if (r.slug == _reciter.slug) return;
    await _player.stop();
    if (!mounted) return;
    setState(() {
      _reciter = r;
      _current = null;
      _position = Duration.zero;
      _duration = Duration.zero;
      _buffering = false;
    });
  }

  Future<void> _play(Surah surah) async {
    setState(() {
      _current = surah;
      _position = Duration.zero;
      _duration = Duration.zero;
      _buffering = true;
    });
    try {
      await _player
          .play(UrlSource(RecitersData.audioUrl(_reciter, surah.number)));
    } catch (_) {
      if (mounted) setState(() => _buffering = false);
    }
  }

  Future<void> _togglePlay() async {
    if (_current == null) {
      await _play(SurahsData.all.first);
      return;
    }
    if (_state == PlayerState.playing) {
      await _player.pause();
    } else {
      await _player.resume();
    }
  }

  Future<void> _playNext() async {
    if (_current == null) return;
    final next = _current!.number + 1;
    if (next > SurahsData.all.length) return;
    await _play(SurahsData.all[next - 1]);
  }

  Future<void> _playPrev() async {
    if (_current == null) return;
    final prev = _current!.number - 1;
    if (prev < 1) return;
    await _play(SurahsData.all[prev - 1]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _Header(onBack: () => context.pop()),
            _ReciterHero(reciter: _reciter),
            _ReciterStrip(
              selected: _reciter,
              onSelect: _selectReciter,
            ),
            SizedBox(height: 8.sp),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(
                  16.sp,
                  4.sp,
                  16.sp,
                  _current == null ? 24.sp : 120.sp,
                ),
                itemCount: SurahsData.all.length,
                separatorBuilder: (_, __) => SizedBox(height: 8.sp),
                itemBuilder: (context, i) {
                  final s = SurahsData.all[i];
                  final isCurrent = _current?.number == s.number;
                  return _SurahTile(
                    surah: s,
                    isCurrent: isCurrent,
                    isPlaying: isCurrent && _state == PlayerState.playing,
                    onTap: () => _play(s),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomSheet: _current == null
          ? null
          : _MiniPlayer(
              reciter: _reciter,
              surah: _current!,
              position: _position,
              duration: _duration,
              isPlaying: _state == PlayerState.playing,
              isBuffering: _buffering,
              onPlayPause: _togglePlay,
              onNext:
                  _current!.number < SurahsData.all.length ? _playNext : null,
              onPrev: _current!.number > 1 ? _playPrev : null,
              onSeek: (v) => _player.seek(Duration(milliseconds: v.toInt())),
            ),
    );
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onBack;
  const _Header({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.sp, 8.sp, 16.sp, 8.sp),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: Icon(Icons.arrow_back_rounded, color: context.colors.black),
          ),
          Text(
            'Quran',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              color: context.colors.black,
            ),
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 4.sp),
            decoration: BoxDecoration(
              color: context.colors.gold.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20.sp),
            ),
            child: Text(
              '114 surahs',
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                color: context.colors.gold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReciterHero extends StatelessWidget {
  final Reciter reciter;
  const _ReciterHero({required this.reciter});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.sp, 4.sp, 16.sp, 12.sp),
      padding: EdgeInsets.all(20.sp),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.colors.emerald,
            context.colors.primary,
          ],
        ),
        borderRadius: BorderRadius.circular(24.sp),
        boxShadow: [
          BoxShadow(
            color: context.colors.emerald.withValues(alpha: 0.25),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56.sp,
            height: 56.sp,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.18),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.graphic_eq_rounded,
                color: Colors.white, size: 28.sp),
          ),
          SizedBox(width: 14.sp),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NOW RECITING',
                  style: TextStyle(
                    fontSize: 10.sp,
                    letterSpacing: 1.6,
                    fontWeight: FontWeight.w700,
                    color: Colors.white.withValues(alpha: 0.75),
                  ),
                ),
                SizedBox(height: 4.sp),
                Text(
                  reciter.nameLatin,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Text(
            reciter.nameArabic,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReciterStrip extends StatelessWidget {
  final Reciter selected;
  final ValueChanged<Reciter> onSelect;
  const _ReciterStrip({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.sp,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        itemCount: RecitersData.all.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.sp),
        itemBuilder: (context, i) {
          final r = RecitersData.all[i];
          final isSelected = r.slug == selected.slug;
          return GestureDetector(
            onTap: () => onSelect(r),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
              decoration: BoxDecoration(
                color:
                    isSelected ? context.colors.black : context.colors.surface,
                borderRadius: BorderRadius.circular(20.sp),
                border: Border.all(
                  color:
                      isSelected ? context.colors.black : Colors.grey.shade300,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                r.nameLatin,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color:
                      isSelected ? context.colors.white : context.colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SurahTile extends StatelessWidget {
  final Surah surah;
  final bool isCurrent;
  final bool isPlaying;
  final VoidCallback onTap;
  const _SurahTile({
    required this.surah,
    required this.isCurrent,
    required this.isPlaying,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(horizontal: 14.sp, vertical: 12.sp),
        decoration: BoxDecoration(
          color: isCurrent
              ? context.colors.primary.withValues(alpha: 0.10)
              : context.colors.surface,
          borderRadius: BorderRadius.circular(16.sp),
          border: Border.all(
            color: isCurrent ? context.colors.primary : Colors.transparent,
            width: 1.4,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40.sp,
              height: 40.sp,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCurrent
                    ? context.colors.primary
                    : context.colors.gold.withValues(alpha: 0.12),
              ),
              alignment: Alignment.center,
              child: Text(
                surah.number.toString(),
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w800,
                  color: isCurrent ? Colors.white : context.colors.gold,
                ),
              ),
            ),
            SizedBox(width: 12.sp),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    surah.nameLatin,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: context.colors.black,
                    ),
                  ),
                  SizedBox(height: 2.sp),
                  Text(
                    surah.meaning,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.sp),
            Text(
              surah.nameArabic,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
                color: context.colors.black,
              ),
            ),
            SizedBox(width: 8.sp),
            Icon(
              isPlaying
                  ? Icons.graphic_eq_rounded
                  : (isCurrent
                      ? Icons.pause_circle_filled_rounded
                      : Icons.play_circle_fill_rounded),
              size: 22.sp,
              color: isCurrent ? context.colors.primary : Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniPlayer extends StatelessWidget {
  final Reciter reciter;
  final Surah surah;
  final Duration position;
  final Duration duration;
  final bool isPlaying;
  final bool isBuffering;
  final VoidCallback onPlayPause;
  final VoidCallback? onNext;
  final VoidCallback? onPrev;
  final ValueChanged<double> onSeek;
  const _MiniPlayer({
    required this.reciter,
    required this.surah,
    required this.position,
    required this.duration,
    required this.isPlaying,
    required this.isBuffering,
    required this.onPlayPause,
    required this.onSeek,
    this.onNext,
    this.onPrev,
  });

  String _fmt(Duration d) {
    final mm = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final ss = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$mm:$ss';
  }

  @override
  Widget build(BuildContext context) {
    final total =
        duration.inMilliseconds == 0 ? 1.0 : duration.inMilliseconds.toDouble();
    final value =
        position.inMilliseconds.clamp(0, duration.inMilliseconds).toDouble();

    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.sp)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 24,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(16.sp, 12.sp, 16.sp, 16.sp),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  width: 44.sp,
                  height: 44.sp,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colors.primary.withValues(alpha: 0.15),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    surah.number.toString(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                      color: context.colors.primary,
                    ),
                  ),
                ),
                SizedBox(width: 12.sp),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${surah.nameLatin} · ${surah.meaning}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: context.colors.black,
                        ),
                      ),
                      SizedBox(height: 2.sp),
                      Text(
                        reciter.nameLatin,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  iconSize: 28.sp,
                  onPressed: onPrev,
                  icon: Icon(Icons.skip_previous_rounded,
                      color: onPrev == null
                          ? Colors.grey.shade400
                          : context.colors.black),
                ),
                GestureDetector(
                  onTap: onPlayPause,
                  child: Container(
                    width: 44.sp,
                    height: 44.sp,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.colors.primary,
                    ),
                    alignment: Alignment.center,
                    child: isBuffering
                        ? SizedBox(
                            width: 18.sp,
                            height: 18.sp,
                            child: const CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2.5),
                          )
                        : Icon(
                            isPlaying
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 26.sp,
                          ),
                  ),
                ),
                IconButton(
                  iconSize: 28.sp,
                  onPressed: onNext,
                  icon: Icon(Icons.skip_next_rounded,
                      color: onNext == null
                          ? Colors.grey.shade400
                          : context.colors.black),
                ),
              ],
            ),
            SizedBox(height: 4.sp),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 3,
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
              ),
              child: Slider(
                min: 0,
                max: total,
                value: value.clamp(0, total),
                activeColor: context.colors.primary,
                inactiveColor: Colors.grey.shade300,
                onChanged: duration == Duration.zero ? null : onSeek,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_fmt(position),
                      style: TextStyle(
                          fontSize: 11.sp, color: Colors.grey.shade500)),
                  Text(_fmt(duration),
                      style: TextStyle(
                          fontSize: 11.sp, color: Colors.grey.shade500)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
