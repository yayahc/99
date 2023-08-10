import 'package:flutter/material.dart';
import 'package:ninety/core/screens/names_list_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: NamesListScreen(),
      ),
    );
  }
}
