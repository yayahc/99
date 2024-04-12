import 'package:flutter/material.dart';
import 'package:ninety/core/theme/typography/i_app_typography.dart';
import 'package:ninety/di.dart';
import 'package:sizer/sizer.dart';
import '../theme/typography/app_typography.dart';

extension StringAsWidgetExtension on String {
  TextStyled light({
    Color? fontColor,
  }) {
    return locator.get<IAppTypography>().light(color: fontColor, text: this);
  }

  TextStyled regular({
    Color? fontColor,
  }) {
    return locator.get<IAppTypography>().regular(color: fontColor, text: this);
  }

  TextStyled medium({
    Color? fontColor,
  }) {
    return locator.get<IAppTypography>().medium(color: fontColor, text: this);
  }
}

extension TextStyledExtension on TextStyled {
  Text get label => Text(text, style: style.copyWith(fontSize: 12.sp));
  Text get body => Text(text, style: style.copyWith(fontSize: 16.sp));
  Text get title => Text(text, style: style.copyWith(fontSize: 24.sp));
}
