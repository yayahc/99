import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ninety/core/extensions/context_extension.dart';
import 'package:ninety/core/extensions/name_extension.dart';
import 'package:ninety/domain/entities/name.dart';
import 'package:ninety/presentation/bloc/favorite_cubit.dart';
import 'package:ninety/presentation/bloc/favorite_state.dart';
import 'package:ninety/services/audio_player/audio_player_service.dart';

class NameCardWidget extends StatelessWidget {
  final Name name;

  const NameCardWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/name', extra: name),
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(16.sp),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 14.sp),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 20.sp,
              child: Text(
                '${name.id}',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(width: 12.sp),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name.transliteration,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: context.colors.black,
                    ),
                  ),
                  SizedBox(height: 3.sp),
                  Text(
                    name.translation,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.sp),
            Text(
              name.arabe,
              style: TextStyle(
                fontSize: 22.sp,
                color: context.colors.primary,
                fontWeight: FontWeight.w500,
              ),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(width: 12.sp),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _PlayButton(name: name),
                SizedBox(height: 8.sp),
                _FavoriteButton(name: name),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  final Name name;

  const _PlayButton({required this.name});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        AudioPlayerService.playerStateNotifier,
        AudioPlayerService.currentSourceNotifier,
      ]),
      builder: (context, _) {
        final isPlaying = AudioPlayerService.playerStateNotifier.value ==
                PlayerState.playing &&
            AudioPlayerService.currentSourceNotifier.value == name.audioPath;
        return GestureDetector(
          onTap: () {
            if (isPlaying) {
              AudioPlayerService.player.pause();
            } else {
              AudioPlayerService.playableStream.add(name.toAudioSource);
            }
          },
          child: Container(
            width: 28.sp,
            height: 28.sp,
            decoration: const BoxDecoration(
              color: Color(0xFF4A5568),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
              size: 16.sp,
            ),
          ),
        );
      },
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  final Name name;

  const _FavoriteButton({required this.name});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteNamesState>(
      builder: (context, _) {
        final isFav =
            context.read<FavoriteCubit>().favoriteNameIds.contains(name.id);
        return GestureDetector(
          onTap: () {
            if (isFav) {
              context.read<FavoriteCubit>().removeNameToFavorite(name.id);
            } else {
              context.read<FavoriteCubit>().addNameToFavorite(name.id);
            }
          },
          child: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            color: isFav ? Colors.redAccent : Colors.grey.shade400,
            size: 20.sp,
          ),
        );
      },
    );
  }
}
