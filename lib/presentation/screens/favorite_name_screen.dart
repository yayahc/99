import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ninety/core/extensions/context_extension.dart';
import 'package:ninety/l10n/app_localizations.dart';
import 'package:ninety/presentation/bloc/favorite_cubit.dart';

import '../../domain/entities/name.dart';
import '../bloc/favorite_state.dart';
import '../widgets/glass_app_bar.dart';
import '../widgets/name_card_widget.dart';
import 'package:ninety/core/extensions/localized_name_extensions.dart';

class FavoriteNameScreen extends StatefulWidget {
  const FavoriteNameScreen({super.key});

  @override
  State<FavoriteNameScreen> createState() => _FavoriteNameScreenState();
}

class _FavoriteNameScreenState extends State<FavoriteNameScreen> {
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
    _searchController.addListener(_onSearchChanged);
    BlocProvider.of<FavoriteCubit>(context).loadFavotiresNames();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: _buildAppBar(context),
      body: BlocListener<FavoriteCubit, FavoriteNamesState>(
        listener: (context, state) => _watchState(state),
        child: _buildBody(context),
      ),
    );
  }

  GlassAppBar _buildAppBar(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return GlassAppBar(title: l10n.favoriteTitle, showBack: true);
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
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.sp, 16.sp, 16.sp, 0),
                    child: Column(
                      children: [
                        _buildSearchBar(context),
                        SizedBox(height: 16.sp),
                      ],
                    ),
                  ),
                ),
                if (_filteredNames.value.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: _buildEmptyState(context),
                  )
                else
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
        borderRadius: BorderRadius.circular(8.sp),
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

  Widget _buildEmptyState(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 56.sp,
            color: Colors.grey.shade300,
          ),
          SizedBox(height: 16.sp),
          Text(
            l10n.noSavedNames,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade400,
            ),
          ),
          SizedBox(height: 8.sp),
          Text(
            l10n.noSavedNamesSubtitle,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey.shade400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _watchState(FavoriteNamesState state) {
    switch (state) {
      case InitialFavoriteNamesState():
      case FavoriteNamesLoadingState():
        _isLoading.value = true;
      case FavoriteNamesLoadedState():
        _isLoading.value = false;
        _names.value = state.names;
        _filteredNames.value = List.from(state.names);
      case ErrorLoadingFavoriteNamesState():
        _isLoading.value = false;
        _names.value = [];
        _filteredNames.value = [];
      case AddFavoriteNamesState():
      case FavoriteNamesAddedState():
        break;
      case ErrorAddingFavoriteNamesState():
        context.showSnackBar(state.error);
      case RemoveFavoriteNamesState():
      case FavoriteNamesRemovedState():
        break;
      case ErrorRemovingFavoriteNamesState():
        context.showSnackBar(state.error);
    }
  }
}
