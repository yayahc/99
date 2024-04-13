import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ninety/core/theme/typography/i_app_typography.dart';
import 'package:ninety/di.dart';
import '../theme/typography/app_typography.dart';

extension StringAsWidgetExtension on String {
  TextStyled light({Color? fontColor, TextAlign? textAlign}) {
    return locator
        .get<IAppTypography>()
        .light(color: fontColor, text: this, textAlign: textAlign);
  }

  TextStyled regular({Color? fontColor, TextAlign? textAlign}) {
    return locator
        .get<IAppTypography>()
        .regular(color: fontColor, text: this, textAlign: textAlign);
  }

  TextStyled medium({Color? fontColor, TextAlign? textAlign}) {
    return locator
        .get<IAppTypography>()
        .medium(color: fontColor, text: this, textAlign: textAlign);
  }
}

extension TextStyledExtension on TextStyled {
  Text get label => Text(
        text,
        style: style.copyWith(fontSize: 12.sp),
        textAlign: textAlign,
      );
  Text get body =>
      Text(text, style: style.copyWith(fontSize: 16.sp), textAlign: textAlign);
  Text get title =>
      Text(text, style: style.copyWith(fontSize: 24.sp), textAlign: textAlign);
}
