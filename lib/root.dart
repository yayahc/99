import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'presentation/screens/home_screen.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return const MaterialApp(
        home: HomeScreen(),
      );
    });
  }
}
