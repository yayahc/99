import 'core/common/screens/splash_screen.dart';
import 'routes.dart';

class AppRouter {
  static getRoutes() {
    return {Routes.splash: (context) => const SplashScreen()};
  }
}
