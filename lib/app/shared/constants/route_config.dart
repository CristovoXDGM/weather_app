import 'package:go_router/go_router.dart';

import '../../features/home/ui/stores/pages/home_page.dart';
import '../../features/login/ui/login_page.dart';

final router = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: "/home",
        builder: (context, state) => const HomePage(),
      ),
    ],
    redirect: (context, GoRouterState state) {
      final String location = state.matchedLocation;

      if (location == "/") {
        return null;
      }

      return null;
    });
