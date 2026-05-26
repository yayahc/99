import 'package:flutter/material.dart';

abstract class IAppColor {
  Color get primary;
  Color get gray;

  /// High-emphasis foreground (text) color. Dark in light mode, light in dark mode.
  Color get black;

  /// Inverse foreground — bright in both modes (used for text on a filled `primary`
  /// or selected button).
  Color get white;

  /// Scaffold background.
  Color get background;

  /// Elevated surface (cards, search bar, etc.). White-ish in light, dark in dark.
  Color get surface;
}
