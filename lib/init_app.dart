import 'package:flutter/material.dart';
import 'core/theme/dynamic_icon.dart';
import 'di.dart';

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  DynamicIconManager.init();
  await configureDependencies();
}
