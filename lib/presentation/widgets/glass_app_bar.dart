import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ninety/core/extensions/context_extension.dart';

class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final double? titleFontSize;
  final bool centerTitle;
  final bool showBack;
  final double? titleSpacing;
  final List<Widget> actions;

  const GlassAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.titleFontSize,
    this.centerTitle = true,
    this.showBack = false,
    this.titleSpacing,
    this.actions = const [],
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: centerTitle,
      titleSpacing: titleSpacing,
      automaticallyImplyLeading: false,
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
      leading: showBack
          ? IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: context.colors.black,
                size: 24.sp,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      title: titleWidget ??
          (title == null
              ? null
              : Text(
                  title!,
                  style: TextStyle(
                    fontSize: titleFontSize ?? 20.sp,
                    fontWeight: FontWeight.w800,
                    color: context.colors.black,
                  ),
                )),
      actions: [
        for (final action in actions)
          Padding(
            padding: EdgeInsetsDirectional.only(end: 16.sp),
            child: action,
          ),
      ],
    );
  }
}
