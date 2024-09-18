import 'package:go_router/go_router.dart';

import '../../features/home/ui/stores/pages/home_page.dart';

final router = GoRouter(
  initialLocation: "/",
  routes: [
    // GoRoute(
    //   path: "/",
    //   builder: (context, state) => const LoginPage(),
    // ),
    GoRoute(
      path: "/",
      builder: (context, state) => const HomePage(),
    ),
  ],
);
