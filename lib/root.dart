import 'package:flutter/material.dart';
import 'package:ninety/core/screens/splash_screen.dart';
import 'package:sizer/sizer.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return const MaterialApp(
        home: SplashScreen(),
      );
    });
  }
}
