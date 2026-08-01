import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ninety/core/extensions/context_extension.dart';
import 'package:ninety/core/extensions/name_extension.dart';
import 'package:ninety/presentation/bloc/favorite_cubit.dart';

import '../../domain/entities/name.dart';
import '../../services/audio_player/audio_player_service.dart';
import '../../services/share/share_name_service.dart';
import '../bloc/favorite_state.dart';

class NameItemScreen extends StatefulWidget {
  final Name name;
  const NameItemScreen({super.key, required this.name});

  @override
  State<NameItemScreen> createState() => _NameItemScreenState();
}

class _NameItemScreenState extends State<NameItemScreen> {
  late final ValueNotifier<bool> _isFavorite;
  final GlobalKey _shareKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _isFavorite = ValueNotifier(widget.name.isFavorite(context));
  }

  @override
  void dispose() {
    _isFavorite.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: _buildAppBar(context),
      body: BlocListener<FavoriteCubit, FavoriteNamesState>(
        listener: (context, state) => _watchState(state),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(16.sp, 16.sp, 16.sp, 100.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeroCard(context),
              SizedBox(height: 12.sp),
              _buildDetailsCard(context),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildPlayButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: context.colors.background,
      elevation: 0,
      centerTitle: true,
      title: Text(
        widget.name.transliteration,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w800,
          color: context.colors.black,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: context.colors.black, size: 24.sp),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.sp),
          child: GestureDetector(
            onTap: () => _shareName(context),
            child: Icon(Icons.share, color: Colors.grey.shade400, size: 26.sp),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 16.sp),
          child: ListenableBuilder(
            listenable: _isFavorite,
            builder: (context, _) => GestureDetector(
              onTap: () => _isFavorite.value
                  ? context
                      .read<FavoriteCubit>()
                      .removeNameToFavorite(widget.name.id)
                  : context
                      .read<FavoriteCubit>()
                      .addNameToFavorite(widget.name.id),
              child: Icon(
                _isFavorite.value ? Icons.favorite : Icons.favorite_border,
                color:
                    _isFavorite.value ? Colors.redAccent : Colors.grey.shade400,
                size: 26.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroCard(BuildContext context) {
    return RepaintBoundary(
        key: _shareKey,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.colors.emerald,
            borderRadius: BorderRadius.circular(8.sp),
          ),
          padding: EdgeInsets.all(22.sp),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Positioned(
                right: -1.sp,
                bottom: -16.sp,
                child: Opacity(
                  opacity: 0.10,
                  child: Icon(Icons.mosque, size: 120.sp, color: Colors.white),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.sp),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name.transliteration,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 4.sp),
                            Text(
                              widget.name.translation,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        widget.name.arabe,
                        style: TextStyle(
                          color: const Color(0xFF81C784),
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget _buildPlayButton() {
    return ListenableBuilder(
      listenable: Listenable.merge([
        AudioPlayerService.playerStateNotifier,
        AudioPlayerService.currentSourceNotifier,
      ]),
      builder: (context, _) {
        final isPlaying = AudioPlayerService.playerStateNotifier.value ==
                PlayerState.playing &&
            AudioPlayerService.currentSourceNotifier.value ==
                widget.name.audioPath;
        return GestureDetector(
          onTap: () => isPlaying
              ? AudioPlayerService.player.pause()
              : AudioPlayerService.playableStream
                  .add(widget.name.toAudioSource),
          child: Container(
            height: 50.sp,
            margin: EdgeInsets.symmetric(horizontal: 24.sp),
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            decoration: BoxDecoration(
              color: context.colors.emerald,
              borderRadius: BorderRadius.circular(24.sp),
              boxShadow: [
                BoxShadow(
                  color: context.colors.emerald.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  isPlaying ? Icons.pause_circle : Icons.play_circle,
                  color: Colors.white,
                  size: 24.sp,
                ),
                SizedBox(width: 8.sp),
                Text(
                  isPlaying ? 'Pause' : 'Play audio',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailsCard(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(8.sp),
        boxShadow: [
          BoxShadow(
            color: context.colors.emerald.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(20.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'MEANING',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: context.colors.primary,
              letterSpacing: 1.4,
            ),
          ),
          SizedBox(height: 10.sp),
          Text(
            widget.name.details,
            style: TextStyle(
              fontSize: 14.sp,
              color: context.colors.black,
              fontWeight: FontWeight.w400,
              height: 1.65,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _shareName(BuildContext context) async {
    final boundary =
        _shareKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) return;

    final image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();

    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/shared_name_${widget.name.id}.png');
    await file.writeAsBytes(pngBytes);

    final shareService = ShareNameService(widget.name.transliteration);
    await shareService.share(XFile(file.path));
  }

  void _watchState(FavoriteNamesState state) {
    switch (state) {
      case InitialFavoriteNamesState():
      case FavoriteNamesLoadingState():
      case FavoriteNamesLoadedState():
      case ErrorLoadingFavoriteNamesState():
      case AddFavoriteNamesState():
        break;
      case FavoriteNamesAddedState():
        _isFavorite.value = true;
      case ErrorAddingFavoriteNamesState():
        context.showSnackBar((state).error);
      case RemoveFavoriteNamesState():
        break;
      case FavoriteNamesRemovedState():
        _isFavorite.value = false;
      case ErrorRemovingFavoriteNamesState():
        context.showSnackBar((state).error);
    }
  }
}
