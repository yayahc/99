import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ninety/domain/entities/name.dart';
import 'package:ninety/presentation/screens/favorite_name_screen.dart';
import 'package:ninety/presentation/screens/home_screen.dart';
import 'package:ninety/presentation/screens/name_item_screen.dart';
import 'package:ninety/presentation/screens/quiz_screen.dart';
import 'package:ninety/presentation/screens/quran_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: "/home",
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: "/home",
        pageBuilder: (context, state) => _buildPageWithSlideTransition(
          context,
          state,
          const HomeScreen(),
        ),
      ),
      GoRoute(
        path: "/favorite",
        pageBuilder: (context, state) => _buildPageWithSlideTransition(
          context,
          state,
          const FavoriteNameScreen(),
        ),
      ),
      GoRoute(
        path: "/quiz",
        pageBuilder: (context, state) => _buildPageWithSlideTransition(
          context,
          state,
          const QuizScreen(),
        ),
      ),
      GoRoute(
        path: "/quran",
        pageBuilder: (context, state) => _buildPageWithSlideTransition(
          context,
          state,
          const QuranScreen(),
        ),
      ),
      GoRoute(
        path: "/name",
        pageBuilder: (context, state) {
          final name = state.extra as Name;
          return _buildPageWithSlideTransition(
            context,
            state,
            NameItemScreen(name: name),
          );
        },
      ),
    ],
  );

  static Page<void> _buildPageWithSlideTransition(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeOutCubic;

        final tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
