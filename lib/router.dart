import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ninety/domain/entities/name.dart';
import 'package:ninety/presentation/screens/favorite_name_screen.dart';
import 'package:ninety/presentation/screens/home_screen.dart';
import 'package:ninety/presentation/screens/name_item_screen.dart';

class AppRouter {
  static GoRouter get router =>
      GoRouter(initialLocation: "/home", debugLogDiagnostics: true, routes: [
        GoRoute(
          path: "/home",
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: "/favorite",
          builder: (context, state) => const FavoriteNameScreen(),
        ),
        GoRoute(
          pageBuilder: (context, state) {
            final name = state.extra as Name;
            return MaterialPage<void>(child: NameItemScreen(name: name));
          },
          path: "/name",
        ),
      ]);
}
