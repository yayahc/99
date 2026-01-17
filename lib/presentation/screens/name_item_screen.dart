import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ninety/core/extensions/context_extension.dart';
import 'package:ninety/core/extensions/name_extension.dart';
import 'package:ninety/core/extensions/string_extension.dart';
import 'package:ninety/presentation/bloc/favorite_cubit.dart';
import 'package:ninety/presentation/widgets/custom_app_bar.dart';

import '../../domain/entities/name.dart';
import '../bloc/favorite_state.dart';
import '../widgets/arrow_back_widget.dart';

class NameItemScreen extends StatefulWidget {
  final Name name;
  const NameItemScreen({super.key, required this.name});

  @override
  State<NameItemScreen> createState() => _NameItemScreenState();
}

class _NameItemScreenState extends State<NameItemScreen> {
  late final ValueNotifier<bool> _isFavorite;
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
        listener: (context, state) {
          _watchState(state);
        },
        child: Container(
            padding: EdgeInsets.only(right: 24.sp, left: 24.sp, top: 24.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                context.gaps.extra,
                context.gaps.small,
                _buildContent(context)
              ],
            )),
      ),
    );
  }

  Column _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        widget.name.translation.regular(fontColor: context.colors.black).body,
        context.gaps.small,
        widget.name.details
            .light(fontColor: context.colors.black, textAlign: TextAlign.left)
            .label
      ],
    );
  }

  Row _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _playBtn(context),
        Row(
          children: [
            _favoriteBtn(),
            context.gaps.small,
            context.gaps.small,
            widget.name.arabe.medium(fontColor: context.colors.black).title,
          ],
        )
      ],
    );
  }

  InkWell _playBtn(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.sp),
      enableFeedback: true,
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(10.sp),
        child: CircleAvatar(
          backgroundColor: context.colors.primary,
          child: Icon(Icons.play_arrow, color: context.colors.white),
        ),
      ),
    );
  }

  Widget _favoriteBtn() {
    return ListenableBuilder(
        listenable: _isFavorite,
        builder: (context, _) {
          return InkWell(
            borderRadius: BorderRadius.circular(8.sp),
            enableFeedback: true,
            onTap: !_isFavorite.value
                ? () => BlocProvider.of<FavoriteCubit>(context)
                    .addNameToFavorite(widget.name.id)
                : () => BlocProvider.of<FavoriteCubit>(context)
                    .removeNameToFavorite(widget.name.id),
            child: Container(
              padding: EdgeInsets.all(16.sp),
              alignment: Alignment.center,
              child: Icon(Icons.favorite,
                  color: _isFavorite.value ? Colors.red : Colors.grey),
            ),
          );
        });
  }

  AppBar _buildAppBar(BuildContext context) {
    return CustomAppBar.build(leading: const ArrowBackWidget());
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
