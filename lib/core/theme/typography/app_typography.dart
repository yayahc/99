import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:ninety/core/theme/colors/i_app_color.dart';
import 'package:ninety/di.dart';
import 'i_app_typography.dart';

@Singleton(as: IAppTypography)
class AppTypography implements IAppTypography {
  @override
  TextStyled light(
      {Color? color,
      FontWeight? fontWeight,
      double? fontSize,
      TextAlign? textAlign,
      required String text}) {
    return TextStyled(
        style: defaultStyle(
            color: color, fontSize: fontSize, fontWeight: FontWeight.w300),
        text: text,
        textAlign: textAlign);
  }

  @override
  TextStyled medium(
      {Color? color,
      FontWeight? fontWeight,
      double? fontSize,
      TextAlign? textAlign,
      required String text}) {
    return TextStyled(
        style: defaultStyle(
            color: color, fontSize: fontSize, fontWeight: FontWeight.w500),
        text: text,
        textAlign: textAlign);
  }

  @override
  TextStyled regular(
      {Color? color,
      FontWeight? fontWeight,
      double? fontSize,
      TextAlign? textAlign,
      required String text}) {
    return TextStyled(
        style: defaultStyle(fontSize: fontSize, color: color),
        text: text,
        textAlign: textAlign);
  }
}

class TextStyled {
  final TextStyle style;
  final TextAlign? textAlign;
  final String text;

  TextStyled({required this.style, required this.text, this.textAlign});
}

TextStyle defaultStyle(
    {Color? color, FontWeight? fontWeight, double? fontSize}) {
  return GoogleFonts.poppins(
    color: color ?? locator.get<IAppColor>().white,
    fontSize: fontSize ?? 12,
    fontWeight: fontWeight ?? FontWeight.w400,
  );
}
