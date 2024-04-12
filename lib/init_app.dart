import 'package:flutter/material.dart';
import 'di.dart';

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
}
