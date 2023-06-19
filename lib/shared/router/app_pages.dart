// ignore_for_file: constant_identifier_names
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/login_page.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/phone_number_verification_page.dart';
import 'package:homemakers_merchant/app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:homemakers_merchant/app/features/onboarding/presentation/pages/splash_page.dart';

part 'app_routes.dart';

class AppRouter {
  static final _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');
  static final _shellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shell');
  AppRouter._();

  static const String INITIAL = Routes.AUTH_PHONE_NUMBER_VERIFICATION;

  static final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: INITIAL,
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: Routes.SPLASH,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: Routes.INITIAL,
        builder: (context, state) => const OnBoardingPage(),
      ),
      GoRoute(
        path: Routes.LOGIN,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: Routes.AUTH_PHONE_NUMBER_VERIFICATION,
        builder: (context, state) => const PhoneNumberVerificationPage(),
      ),
    ],
  );

  static GoRouter get router => _router;
}
