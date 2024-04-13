import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ninety/core/extensions/context_extension.dart';
import 'package:ninety/core/extensions/string_extension.dart';

import '../widgets/name_widget.dart';

class FavoriteNameScreen extends StatelessWidget {
  const FavoriteNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  Container _body(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: SingleChildScrollView(
        child: Column(
          children: [
            context.gaps.extra,
            _buildScreenTitle(context),
            context.gaps.extra,
            context.gaps.extra,
            const NamesWidget(
              names: [],
              isFav: true,
            ),
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
}
