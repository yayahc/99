import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ninety/core/extensions/context_extension.dart';
import 'package:ninety/core/extensions/string_extension.dart';
import 'package:ninety/presentation/widgets/custom_app_bar.dart';

import '../../domain/entities/name.dart';
import '../widgets/arrow_back_widget.dart';

class NameItemScreen extends StatelessWidget {
  final Name name;
  const NameItemScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: _buildAppBar(context),
      body: Container(
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
    );
  }

  Column _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        name.translation.regular(fontColor: context.colors.black).body,
        context.gaps.small,
        name.details
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
            name.arabe.medium(fontColor: context.colors.black).title,
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

  InkWell _favoriteBtn() {
    return InkWell(
      borderRadius: BorderRadius.circular(8.sp),
      enableFeedback: true,
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(16.sp),
        alignment: Alignment.center,
        child: const Icon(Icons.favorite, color: Colors.red),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return CustomAppBar.build(leading: const ArrowBackWidget());
  }
}
