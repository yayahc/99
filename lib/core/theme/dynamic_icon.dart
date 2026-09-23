import 'package:dynamic_app_icon_flutter_plus/dynamic_app_icon_flutter_plus.dart';

class DynamicIconManager {
  static List<String> availableIcons = [];
  static bool isSupported = false;

  static Future<void> init() async {
    final bool supported =
        await DynamicAppIconFlutterPlus.supportsAlternateIcons;
    if (supported) {
      isSupported = supported;
      final icons = await getIcons();
      print('DynamicIconManager: available icons: $icons');
      final _ = await getCurrentIcon();
      print('DynamicIconManager: current icon: $_');
      await resetIcon();
    }
  }

  static Future<List<String>> getIcons() async {
    List<String> icons = await DynamicAppIconFlutterPlus.getAvailableIcons();
    availableIcons = icons;
    return icons;
  }

  static Future<String?> getCurrentIcon() async {
    String? currentIcon =
        await DynamicAppIconFlutterPlus.getAlternateIconName();
    return currentIcon;
  }

  static Future<void> setIcon(String? iconName) async {
    await DynamicAppIconFlutterPlus.setAlternateIconName(iconName);
  }

  static Future<void> resetIcon() async =>
      await DynamicAppIconFlutterPlus.setAlternateIconName(null);
}
