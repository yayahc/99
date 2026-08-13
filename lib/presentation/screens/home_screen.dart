import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ninety/core/extensions/context_extension.dart';
import 'package:ninety/l10n/app_localizations.dart';
import 'package:ninety/presentation/bloc/favorite_cubit.dart';
import 'package:ninety/presentation/bloc/name_cubit.dart';
import 'package:ninety/presentation/bloc/name_state.dart';

import 'package:ninety/di.dart';
import 'package:ninety/services/quran_audio/quran_audio_controller.dart';

import '../../domain/entities/name.dart';
import '../widgets/glass_surface.dart';
import '../widgets/name_card_widget.dart';
import '../widgets/wave_bars.dart';
import 'package:ninety/core/extensions/localized_name_extensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ValueNotifier<List<Name>> _names;
  late final ValueNotifier<List<Name>> _filteredNames;
  late final ValueNotifier<bool> _isLoading;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _names = ValueNotifier(<Name>[]);
    _filteredNames = ValueNotifier(<Name>[]);
    _isLoading = ValueNotifier(false);
    _searchController = TextEditingController();
    BlocProvider.of<FavoriteCubit>(context).loadFavotiresNames();
    BlocProvider.of<NameCubit>(context).loadNames();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _names.dispose();
    _filteredNames.dispose();
    _isLoading.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    final lang = context.languageCode;
    if (query.isEmpty) {
      _filteredNames.value = List.from(_names.value);
    } else {
      _filteredNames.value = _names.value
          .where((n) =>
              n.transliteration.toLowerCase().contains(query) ||
              n.translationIn(lang).toLowerCase().contains(query))
          .toList();
    }
  }

  Name? get _nameOfTheDay {
    if (_names.value.isEmpty) return null;
    final dayOfYear =
        DateTime.now().difference(DateTime(DateTime.now().year)).inDays;
    return _names.value[dayOfYear % _names.value.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const DrawlerMenu(),
      backgroundColor: context.colors.background,
      appBar: _buildAppBar(context),
      body: BlocListener<NameCubit, NameState>(
        listener: (context, state) => _watchState(state),
        child: Stack(
          children: [
            const _AmbientBackground(),
            _buildBody(context),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: 16.sp,
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withValues(alpha: 0.18),
                  Colors.white.withValues(alpha: 0.04),
                ],
              ),
              border: Border(
                bottom: BorderSide(color: Colors.white.withValues(alpha: 0.10)),
              ),
            ),
          ),
        ),
      ),
      title: _QuranAudioInvite(onTap: () => context.push('/quran')),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.sp),
          child: GestureDetector(
            onTap: () => context.push('/settings'),
            child: Icon(
              Icons.settings_rounded,
              color: context.colors.gold,
              size: 28.sp,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 16.sp),
          child: GestureDetector(
            onTap: () => context.push('/quiz'),
            child: Icon(
              Icons.school_rounded,
              color: context.colors.emerald,
              size: 28.sp,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 16.sp),
          child: GestureDetector(
            onTap: () => context.push('/favorite'),
            child: Icon(
              Icons.favorite_rounded,
              color: context.colors.rose,
              size: 28.sp,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListenableBuilder(
      listenable: _isLoading,
      builder: (context, _) {
        if (_isLoading.value) {
          return const Center(child: CupertinoActivityIndicator());
        }
        return ListenableBuilder(
          listenable: _filteredNames,
          builder: (context, _) {
            final showNameOfTheDay = _searchController.text.isEmpty;
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.sp, 16.sp, 16.sp, 0),
                    child: Column(
                      children: [
                        _buildSearchBar(context),
                        if (showNameOfTheDay) SizedBox(height: 16.sp),
                        if (showNameOfTheDay) _buildNameOfTheDayCard(context),
                        SizedBox(height: 16.sp),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16.sp),
                  sliver: SliverList.separated(
                    itemCount: _filteredNames.value.length,
                    separatorBuilder: (_, __) => SizedBox(height: 8.sp),
                    itemBuilder: (context, i) =>
                        NameCardWidget(name: _filteredNames.value[i]),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 24.sp)),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return GlassSurface(
      borderRadius: 16.sp,
      child: SizedBox(
        height: 52.sp,
        child: TextField(
          controller: _searchController,
          style: TextStyle(fontSize: 14.sp, color: context.colors.black),
          decoration: InputDecoration(
            hintText: l10n.searchHint,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey.shade400,
              size: 22.sp,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 14.sp),
          ),
        ),
      ),
    );
  }

  Widget _buildNameOfTheDayCard(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final name = _nameOfTheDay;
    if (name == null) return const SizedBox();
    return GestureDetector(
      onTap: () => context.push('/name', extra: name),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.sp),
        decoration: BoxDecoration(
          color: context.colors.emerald,
          borderRadius: BorderRadius.circular(8.sp),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.18),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: context.colors.emerald.withValues(alpha: 0.35),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.sp),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withValues(alpha: 0.18),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.5],
                  ),
                ),
              ),
            ),
            Positioned(
              right: -8.sp,
              top: -12.sp,
              child: Opacity(
                opacity: 0.12,
                child: Icon(
                  Icons.mosque,
                  size: 110.sp,
                  color: Colors.white,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.nameOfTheDay,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.8,
                  ),
                ),
                SizedBox(height: 10.sp),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name.transliteration,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 4.sp),
                          Text(
                            name.translationOf(context),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      name.arabe,
                      style: TextStyle(
                        color: const Color(0xFF81C784),
                        fontSize: 30.sp,
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
      ),
    );
  }

  void _watchState(NameState state) {
    switch (state) {
      case InitialNamesState():
      case NamesLoadingState():
        _isLoading.value = true;
      case NamesLoadedState():
        _isLoading.value = false;
        _names.value = state.names;
        _filteredNames.value = List.from(state.names);
      case ErrorLoadingNamesState():
        _isLoading.value = false;
    }
  }
}

class _AmbientBackground extends StatelessWidget {
  const _AmbientBackground();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          children: [
            Positioned(
              top: -60.sp,
              left: -40.sp,
              child:
                  _blob(context.colors.emerald.withValues(alpha: 0.22), 220.sp),
            ),
            Positioned(
              top: 120.sp,
              right: -70.sp,
              child: _blob(context.colors.gold.withValues(alpha: 0.14), 200.sp),
            ),
            Positioned(
              bottom: -80.sp,
              left: -30.sp,
              child:
                  _blob(context.colors.primary.withValues(alpha: 0.12), 240.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _blob(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withValues(alpha: 0)],
        ),
      ),
    );
  }
}

class _QuranAudioInvite extends StatelessWidget {
  final VoidCallback onTap;
  const _QuranAudioInvite({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final controller = locator.get<QuranAudioController>();
    return GestureDetector(
      onTap: onTap,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          final isPlaying = controller.isPlaying;
          final surah = controller.current;
          final label =
              isPlaying && surah != null ? surah.nameLatin : 'Listen Quran';
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [context.colors.emerald, context.colors.primary],
              ),
              borderRadius: BorderRadius.circular(22.sp),
              boxShadow: [
                BoxShadow(
                  color: context.colors.emerald.withValues(alpha: 0.25),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  transitionBuilder: (child, anim) =>
                      ScaleTransition(scale: anim, child: child),
                  child: isPlaying
                      ? Padding(
                          key: const ValueKey('wave'),
                          padding: EdgeInsets.symmetric(horizontal: 2.sp),
                          child: WaveBars(
                            color: Colors.white,
                            width: 16.sp,
                            height: 16.sp,
                          ),
                        )
                      : Icon(
                          Icons.play_arrow_rounded,
                          key: const ValueKey('play'),
                          color: Colors.white,
                          size: 22.sp,
                        ),
                ),
                SizedBox(width: 6.sp),
                AnimatedSize(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOut,
                  child: Text(
                    label,
                    key: ValueKey(label),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
