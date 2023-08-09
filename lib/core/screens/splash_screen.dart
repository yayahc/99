import 'package:flutter/material.dart';
import 'package:ninety/core/screens/names_page_view.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: NamesPageView(),
      ),
    );
  }
}
