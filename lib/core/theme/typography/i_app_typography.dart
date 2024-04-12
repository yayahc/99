import 'package:flutter/material.dart';
import 'package:ninety/core/theme/typography/app_typography.dart';

abstract class IAppTypography {
  TextStyled light(
      {Color? color,
      FontWeight? fontWeight,
      double? fontSize,
      required String text});
  TextStyled medium(
      {Color? color,
      FontWeight? fontWeight,
      double? fontSize,
      required String text});
  TextStyled regular(
      {Color? color,
      FontWeight? fontWeight,
      double? fontSize,
      required String text});
}
