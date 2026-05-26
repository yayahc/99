import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ninety/core/theme/colors/i_app_color.dart';

class AppTheme {
  static ThemeData light(IAppColor colors) => _build(colors, Brightness.light);
  static ThemeData dark(IAppColor colors) => _build(colors, Brightness.dark);

  static ThemeData _build(IAppColor colors, Brightness brightness) {
    final base = brightness == Brightness.dark
        ? ThemeData.dark(useMaterial3: true)
        : ThemeData.light(useMaterial3: true);

    final isDark = brightness == Brightness.dark;

    return base.copyWith(
      brightness: brightness,
      scaffoldBackgroundColor: colors.background,
      cardColor: colors.surface,
      colorScheme: base.colorScheme.copyWith(
        brightness: brightness,
        primary: colors.primary,
        surface: colors.surface,
        onSurface: colors.black,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        foregroundColor: colors.black,
        elevation: 0,
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(base.textTheme).apply(
        bodyColor: colors.black,
        displayColor: colors.black,
      ),
    );
  }
}
