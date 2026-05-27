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
import 'package:ninety/services/audio_player/audio_player_service.dart';

import '../../domain/entities/name.dart';
import '../widgets/name_card_widget.dart';
import '../widgets/theme_toggle_button.dart';

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
    AudioPlayerService.instance.listen();
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
    if (query.isEmpty) {
      _filteredNames.value = List.from(_names.value);
    } else {
      _filteredNames.value = _names.value
          .where((n) =>
              n.transliteration.toLowerCase().contains(query) ||
              n.translation.toLowerCase().contains(query))
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
        child: _buildBody(context),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AppBar(
      backgroundColor: context.colors.background,
      elevation: 0,
      // centerTitle: true,
      title: Text(
        l10n.appTitle,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w800,
          color: context.colors.black,
        ),
      ),
      // leading: Builder(builder: (ctx) {
      //   return IconButton(
      //     icon: Icon(
      //       Icons.menu,
      //       color: context.colors.black,
      //       size: 24.sp,
      //     ),
      //     onPressed: () => Scaffold.of(ctx).openDrawer(),
      //   );
      // }),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.sp),
          child: const ThemeToggleButton(),
        ),
        Padding(
          padding: EdgeInsets.only(right: 16.sp),
          child: GestureDetector(
            onTap: () => context.push('/audio-test'),
            child: Icon(
              Icons.headphones_rounded,
              color: context.colors.primary,
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
    return Container(
      height: 52.sp,
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(16.sp),
      ),
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
          borderRadius: BorderRadius.circular(20.sp),
        ),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
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
                            name.translation,
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
