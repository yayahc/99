import 'package:flutter/material.dart';
import 'package:ninety/core/theme/colors/i_app_color.dart';
import 'package:ninety/di.dart';

class CustomAppBar {
  static AppBar build({Widget? leading, List<Widget>? actions}) {
    return AppBar(
        elevation: 0,
        backgroundColor: locator.get<IAppColor>().background,
        actions: actions,
        leading: leading);
  }
}
