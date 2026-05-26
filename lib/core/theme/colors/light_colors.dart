import 'dart:ui';

import 'package:injectable/injectable.dart';
import 'package:ninety/core/theme/colors/i_app_color.dart';

@Named('light')
@Singleton(as: IAppColor)
class LightColor implements IAppColor {
  @override
  Color get background => const Color.fromRGBO(238, 244, 239, 1);

  @override
  Color get black => const Color.fromRGBO(17, 17, 17, 1);

  @override
  Color get gray => const Color.fromRGBO(217, 217, 217, 1);

  @override
  Color get primary => const Color.fromRGBO(55, 185, 76, 1);

  @override
  Color get white => const Color.fromRGBO(250, 246, 246, 1);

  @override
  Color get surface => const Color(0xFFFFFFFF);

  @override
  Color get gold => const Color(0xFFD4A24C);

  @override
  Color get emerald => const Color(0xFF2E7D46);

  @override
  Color get rose => const Color(0xFFE04864);
}
