import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ninety/core/extensions/context_extension.dart';
import 'package:ninety/data/datasources/local/reciters_data.dart';
import 'package:ninety/data/datasources/local/surahs_data.dart';
import 'package:ninety/di.dart';
import 'package:ninety/domain/entities/reciter.dart';
import 'package:ninety/domain/entities/surah.dart';
import 'package:ninety/services/quran_audio/quran_audio_controller.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = locator.get<QuranAudioController>();
    return Scaffold(
      backgroundColor: context.colors.background,
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return SafeArea(
            bottom: false,
            child: Column(
              children: [
                _Header(
                  onBack: () => context.pop(),
                  selected: controller.reciter,
                  onSelect: controller.selectReciter,
                ),
                _ReciterStrip(
                  selected: controller.reciter,
                  onSelect: controller.selectReciter,
                ),
                SizedBox(height: 8.sp),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.fromLTRB(
                      16.sp,
                      4.sp,
                      16.sp,
                      controller.current == null ? 24.sp : 120.sp,
                    ),
                    itemCount: SurahsData.all.length,
                    separatorBuilder: (_, __) => SizedBox(height: 8.sp),
                    itemBuilder: (context, i) {
                      final s = SurahsData.all[i];
                      final isCurrent = controller.current?.number == s.number;
                      return _SurahTile(
                        surah: s,
                        isCurrent: isCurrent,
                        isPlaying: isCurrent && controller.isPlaying,
                        onTap: () => controller.play(s),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomSheet: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          final current = controller.current;
          if (current == null) return const SizedBox.shrink();
          return _MiniPlayer(
            reciter: controller.reciter,
            surah: current,
            position: controller.position,
            duration: controller.duration,
            isPlaying: controller.isPlaying,
            isBuffering: controller.buffering,
            onPlayPause: controller.togglePlay,
            onNext: current.number < SurahsData.all.length
                ? controller.playNext
                : null,
            onPrev: current.number > 1 ? controller.playPrev : null,
            onSeek: (v) =>
                controller.seek(Duration(milliseconds: v.toInt())),
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onBack;
  final Reciter selected;
  final ValueChanged<Reciter> onSelect;
  const _Header({
    required this.onBack,
    required this.selected,
    required this.onSelect,
  });

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
          PopupMenuButton<Reciter>(
            tooltip: 'Select reciter',
            onSelected: onSelect,
            offset: Offset(0, 36.sp),
            color: context.colors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.sp),
            ),
            itemBuilder: (_) => [
              for (final r in RecitersData.all)
                PopupMenuItem<Reciter>(
                  value: r,
                  child: Row(
                    children: [
                      Icon(
                        r.slug == selected.slug
                            ? Icons.check_circle_rounded
                            : Icons.circle_outlined,
                        size: 18.sp,
                        color: r.slug == selected.slug
                            ? context.colors.primary
                            : Colors.grey.shade400,
                      ),
                      SizedBox(width: 10.sp),
                      Flexible(
                        child: Text(
                          r.nameLatin,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: context.colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
              decoration: BoxDecoration(
                color: context.colors.gold.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20.sp),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.record_voice_over_rounded,
                      size: 14.sp, color: context.colors.gold),
                  SizedBox(width: 6.sp),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 130.sp),
                    child: Text(
                      selected.nameLatin,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: context.colors.gold,
                      ),
                    ),
                  ),
                  SizedBox(width: 2.sp),
                  Icon(Icons.arrow_drop_down_rounded,
                      size: 18.sp, color: context.colors.gold),
                ],
              ),
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
