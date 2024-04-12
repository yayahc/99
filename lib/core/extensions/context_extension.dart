import 'package:flutter/material.dart';
import 'package:ninety/core/theme/colors/i_app_color.dart';
import 'package:ninety/core/theme/gaps/i_app_gap.dart';
import 'package:ninety/di.dart';

extension ContextExtensions on BuildContext {
  IAppColor get colors => locator.get<IAppColor>();
  IAppGap get gaps => locator.get<IAppGap>();
}
