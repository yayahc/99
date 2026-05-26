import 'package:flutter/material.dart';
import 'package:ninety/core/theme/colors/i_app_color.dart';
import 'package:ninety/core/theme/gaps/i_app_gap.dart';
import 'package:ninety/di.dart';

extension ContextExtensions on BuildContext {
  IAppColor get colors {
    final isDark = Theme.of(this).brightness == Brightness.dark;
    return locator.get<IAppColor>(instanceName: isDark ? 'dark' : 'light');
  }

  IAppGap get gaps => locator.get<IAppGap>();

  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).removeCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
  }
}
