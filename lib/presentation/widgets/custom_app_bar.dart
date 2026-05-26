import 'package:flutter/material.dart';
import 'package:ninety/core/extensions/context_extension.dart';

class CustomAppBar {
  static AppBar build(BuildContext context,
      {Widget? leading, List<Widget>? actions}) {
    return AppBar(
        elevation: 0,
        backgroundColor: context.colors.background,
        actions: actions,
        leading: leading);
  }
}
