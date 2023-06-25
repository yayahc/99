import 'package:flutter/material.dart';

import 'router.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: AppRouter.getRoutes(),
    );
  }
}
