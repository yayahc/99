import 'package:flutter/material.dart';
import 'package:ninety/core/theme/colors/i_app_colors.dart';

class LightColorsImpl implements IAppColors {
  late Color _white;
  late Color _background;

  LightColorsImpl() {
    initializeColors();
  }

  void initializeColors() {
    _white = const Color(0XFFFFFFFF);
    _background = const Color(0XFF112233);
  }

  @override
  Color get background => _white;

  @override
  Color get white => _background;
}
