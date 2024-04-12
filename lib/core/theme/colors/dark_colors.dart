import 'dart:ui';

import 'package:ninety/core/theme/colors/i_app_color.dart';

class DarkColor implements IAppColor {
  @override
  Color get background => const Color.fromRGBO(2, 20, 5, 1);

  @override
  Color get black => const Color.fromRGBO(17, 17, 17, 1);

  @override
  Color get gray => const Color.fromRGBO(74, 73, 73, 0.20);

  @override
  Color get primary => const Color.fromRGBO(55, 185, 76, 1);

  @override
  Color get white => const Color.fromRGBO(250, 246, 246, 1);
}
