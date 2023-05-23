// ignore_for_file: constant_identifier_names
import 'package:go_router/go_router.dart';
import 'package:homemakers_merchant/counter/counter.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const String INITIAL = Routes.SPLASH;

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: INITIAL,
        builder: (context, state) => const CounterPage(),
      ),
    ],
  );
}
