import 'package:go_router/go_router.dart';

import '../../features/home/ui/stores/pages/home_page.dart';
import '../../features/login/ui/login_page.dart';

final router = GoRouter(
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
);
