import 'package:go_router/go_router.dart';
import 'package:riverpodtodo/features/list/presentation/list_screen.dart';
import 'package:riverpodtodo/features/login/presentation/login_screen.dart';
import 'package:riverpodtodo/features/register/presentation/register_screen.dart';
import 'package:riverpodtodo/features/splash/presentation/splash_screen.dart';

class RouteNames {
  static const splash = "splash";
  static const list = "list";
  static const login = "login";
  static const register = "register";
}

class RoutePath {
  static const splash = "/splash";
  static const list = "/list";
  static const login = "/login";
  static const register = "/register";
}

final appRouter = GoRouter(routes: [
  GoRoute(
    name: RouteNames.splash,
    path: RoutePath.splash,
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    name: RouteNames.login,
    path: RoutePath.login,
    builder: (context, state) => LoginScreen(),
  ),
  GoRoute(
    name: RouteNames.register,
    path: RoutePath.register,
    builder: (context, state) => RegisterScreen(),
  ),
  GoRoute(
    name: RouteNames.list,
    path: RoutePath.list,
    builder: (context, state) => const ListScreen(),
  ),
], initialLocation: RoutePath.splash);
