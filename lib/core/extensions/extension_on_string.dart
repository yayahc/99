import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ninety/core/theme/colors/i_app_colors.dart';
import 'package:ninety/dependencie_injection.dart';
import 'package:sizer/sizer.dart';

extension StringAsWidgetExtension on String {
  Text asWidget(
      {TextAlign? align,
      double? fontSize,
      Color? fontColor,
      FontWeight? fontWeight}) {
    return Text(
      this,
      textAlign: align ?? TextAlign.left,
      style: GoogleFonts.poppins(
        color: fontColor ?? locator.get<IAppColors>().white,
        fontSize: fontSize ?? 10.sp,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
    );
  }
}
