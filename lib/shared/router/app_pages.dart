// ignore_for_file: constant_identifier_names
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:homemakers_merchant/app/features/address/presentation/pages/address_form_page.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/about_us.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/login_page.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/otp_verification_page.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/phone_number_verification_page.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/privacy_and_policy_view.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/terms_and_conditions_view.dart';
import 'package:homemakers_merchant/app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:homemakers_merchant/app/features/onboarding/presentation/pages/splash_page.dart';
import 'package:homemakers_merchant/app/features/profile/common/document_type_enum.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/pages/bank/bank_information_page.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/pages/business_information_page.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/pages/document/business_document_page.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/pages/document/upload_document_page.dart';

part 'app_routes.dart';

class AppRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  static final shellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shell');

  AppRouter._();

  static const String INITIAL = Routes.DOCUMENT_LIST_PAGE;

  static final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: INITIAL,
    navigatorKey: rootNavigatorKey,
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
      GoRoute(
          path: Routes.AUTH_OTP_VERIFICATION,
          builder: (context, state) => OTPVerificationPage(
                phoneNumber: jsonDecode(state.extra as String)['mobileNumber']
                    .toString(),
              )),
      GoRoute(
        path: Routes.TERMS_AND_CONDITIONS,
        builder: (context, state) => const TermsAndConditionsPage(),
      ),
      GoRoute(
        path: Routes.PRIVACY_AND_POLICY,
        builder: (context, state) => const PrivacyAndPolicyPage(),
      ),
      GoRoute(
        path: Routes.ABOUT_US,
        builder: (context, state) => const AboutUsPage(),
      ),
      GoRoute(
        path: Routes.CREATE_BUSINESS_PROFILE_PAGE,
        builder: (context, state) => const BusinessInformationPage(),
      ),
      GoRoute(
        path: Routes.DOCUMENT_LIST_PAGE,
        builder: (context, state) => const BusinessDocumentPage(),
      ),
      GoRoute(
        path: Routes.UPLOAD_DOCUMENT_PAGE,
        builder: (context, state) => UploadDocumentPage(
            documentType: DocumentType.values
                .byName(jsonDecode(state.extra as String)['documentType'])),
      ),
      GoRoute(
        path: Routes.ADDRESS_FORM_PAGE,
        builder: (context, state) => const AddressFormPage(),
      ),
      GoRoute(
        path: Routes.BANK_INFORMATION_PAGE,
        builder: (context, state) => const BankInformationPage(),
      ),
    ],
  );

  static GoRouter get router => _router;
}
