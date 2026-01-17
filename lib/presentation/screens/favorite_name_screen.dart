import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ninety/core/extensions/context_extension.dart';
import 'package:ninety/core/extensions/string_extension.dart';
import 'package:ninety/presentation/bloc/favorite_cubit.dart';

import '../../domain/entities/name.dart';
import '../bloc/favorite_state.dart';
import '../widgets/name_widget.dart';

class FavoriteNameScreen extends StatefulWidget {
  const FavoriteNameScreen({super.key});

  @override
  State<FavoriteNameScreen> createState() => _FavoriteNameScreenState();
}

class _FavoriteNameScreenState extends State<FavoriteNameScreen> {
  late final ValueNotifier<List<Name>> _names;
  late final ValueNotifier<bool> _isLoading;

  @override
  void initState() {
    super.initState();
    _names = ValueNotifier(<Name>[]);
    _isLoading = ValueNotifier(false);
    BlocProvider.of<FavoriteCubit>(context).loadFavotiresNames();
  }

  @override
  void dispose() {
    _names.dispose();
    _isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: _appBar(context),
      body: BlocListener<FavoriteCubit, FavoriteNamesState>(
        listener: (context, state) {
          _watchState(state);
        },
        child: _body(context),
      ),
    );
  }

  Container _body(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            context.gaps.extra,
            _buildScreenTitle(context),
            context.gaps.extra,
            context.gaps.extra,
            ListenableBuilder(
                listenable: _isLoading,
                builder: (context, _) {
                  return _isLoading.value
                      ? const CupertinoActivityIndicator()
                      : ListenableBuilder(
                          listenable: _names,
                          builder: (context, _) {
                            return _names.value.isEmpty
                                ? const Center(child: Text('...'))
                                : NamesWidget(
                                    names: _names.value,
                                  );
                          });
                }),
          ],
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.colors.background,
      leading: InkWell(
        borderRadius: BorderRadius.circular(8.sp),
        onTap: () => context.pop(),
        child: Container(
          alignment: Alignment.center,
          child: Icon(Icons.arrow_back, color: context.colors.black),
        ),
      ),
    );
  }

  SizedBox _buildScreenTitle(BuildContext context) {
    return SizedBox(
      width: 193.sp,
      height: 71.sp,
      child: "Your favorite names"
          .medium(fontColor: context.colors.black, textAlign: TextAlign.center)
          .title,
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
      case ErrorLoadingFavoriteNamesState():
        _isLoading.value = false;
        _names.value.clear();
      case AddFavoriteNamesState():
      case FavoriteNamesAddedState():
        break;
      case ErrorAddingFavoriteNamesState():
        _isLoading.value = false;
        context.showSnackBar((state).error);
      case RemoveFavoriteNamesState():
      case FavoriteNamesRemovedState():
        break;
      case ErrorRemovingFavoriteNamesState():
        _isLoading.value = false;
        context.showSnackBar((state).error);
    }
  }
}
