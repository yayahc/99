import 'package:go_router/go_router.dart';
import 'package:ninety/presentation/screens/favorite_name_screen.dart';
import 'package:ninety/presentation/screens/home_screen.dart';
import 'package:ninety/presentation/screens/name_item_screen.dart';

class AppRouter {
  static GoRouter get router => GoRouter(initialLocation: "/home", routes: [
        GoRoute(
          path: "/home",
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: "/favorite",
          builder: (context, state) => const FavoriteNameScreen(),
        ),
        GoRoute(
          path: "/name",
          builder: (context, state) => const NameItemScreen(),
        ),
      ]);
}
