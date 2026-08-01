import 'dart:ui';

import 'package:injectable/injectable.dart';
import 'package:ninety/core/theme/colors/i_app_color.dart';

@Named('dark')
@Singleton(as: IAppColor)
class DarkColor implements IAppColor {
  @override
  Color get background => const Color.fromRGBO(2, 20, 5, 1);

  /// In dark mode `black` is the high-emphasis foreground (text) color — bright,
  /// so widgets using `context.colors.black` for text remain readable.
  @override
  Color get black => const Color.fromRGBO(238, 244, 239, 1);

  @override
  Color get gray => const Color.fromRGBO(74, 73, 73, 0.40);

  @override
  Color get primary => const Color.fromRGBO(55, 185, 76, 1);

  @override
  Color get white => const Color.fromRGBO(250, 246, 246, 1);

  /// Slightly elevated above `background` — used for card / search-bar surfaces.
  @override
  Color get surface => const Color(0xFF12241A);

  @override
  Color get gold => const Color.fromARGB(255, 218, 189, 137);

  @override
  Color get emerald => const Color(0xFF2E7D46);

  @override
  Color get rose => const Color(0xFFE04864);
}
