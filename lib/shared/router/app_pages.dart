// ignore_for_file: constant_identifier_names
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:homemakers_merchant/app/features/address/domain/entities/address_model.dart';
import 'package:homemakers_merchant/app/features/address/presentation/pages/address_form_page.dart';
import 'package:homemakers_merchant/app/features/address/presentation/pages/pickup_location_from_map.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/about_us.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/login_page.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/otp_verification_page.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/phone_number_verification_page.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/privacy_and_policy_view.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/terms_and_conditions_view.dart';

import 'package:homemakers_merchant/app/features/dashboard/presentation/pages/main_dashboard_page.dart';
import 'package:homemakers_merchant/app/features/dashboard/presentation/pages/primary_dashboard_page.dart';
import 'package:homemakers_merchant/app/features/dashboard/presentation/pages/welcome_page.dart';
import 'package:homemakers_merchant/app/features/menu/presentation/pages/all_menu_page.dart';
import 'package:homemakers_merchant/app/features/menu/presentation/pages/menu_description_page.dart';
import 'package:homemakers_merchant/app/features/menu/presentation/pages/new_menu_greeting_page.dart';
import 'package:homemakers_merchant/app/features/menu/presentation/pages/save_menu_page.dart';
import 'package:homemakers_merchant/app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:homemakers_merchant/app/features/onboarding/presentation/pages/splash_page.dart';
import 'package:homemakers_merchant/app/features/profile/common/document_type_enum.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/pages/bank/bank_information_page.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/pages/business/business_information_page.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/pages/document/business_document_page.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/pages/document/upload_document_page.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/pages/business/select_business_type_page.dart';
import 'package:homemakers_merchant/app/features/store/domain/entities/store_entity.dart';
import 'package:homemakers_merchant/app/features/store/presentation/pages/all_stores_page.dart';
import 'package:homemakers_merchant/app/features/store/presentation/pages/new_store_greeting_page.dart';
import 'package:homemakers_merchant/app/features/store/presentation/pages/save_store_page.dart';

part 'app_routes.dart';

class AppRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  static final shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

  AppRouter._();

  static const String INITIAL = Routes.ALL_MENU_PAGE;

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
                phoneNumber: jsonDecode(state.extra as String)['mobileNumber'].toString(), //Testing purpose'+966 56 135 6754',
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
        builder: (context, state) => UploadDocumentPage(documentType: DocumentType.values.byName(jsonDecode(state.extra as String)['documentType'])),
      ),
      GoRoute(
        path: Routes.ADDRESS_FORM_PAGE,
        builder: (context, state) => const AddressFormPage(),
      ),
      GoRoute(
        path: Routes.BANK_INFORMATION_PAGE,
        builder: (context, state) => const BankInformationPage(),
      ),
      GoRoute(
        path: Routes.WELCOME_PAGE,
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: Routes.PRIMARY_DASHBOARD_PAGE,
        builder: (context, state) => const PrimaryDashboardPage(),
      ),
      GoRoute(
        path: Routes.MAIN_DASHBOARD_PAGE,
        builder: (context, state) => const MainDashboardPage(),
      ),
      GoRoute(
        path: Routes.SAVE_STORE_PAGE,
        builder: (context, state) => const SaveStorePage(),
      ),
      GoRoute(
        path: Routes.ALL_STORES_PAGE,
        builder: (context, state) => const AllStoresPage(),
      ),
      GoRoute(
        path: Routes.NEW_STORE_GREETING_PAGE,
        builder: (context, state) => NewStoreGreetingPage(storeEntity: state.extra as StoreEntity),
      ),
      GoRoute(
        path: Routes.PICKUP_LOCATION_FROM_MAP_PAGE,
        // (TODO:Prasant): Replace and Set object of address model
        builder: (context, state) => PickupLocationFromMapPage(addressModel: AddressModel() ?? state.extra as AddressModel),
      ),
      GoRoute(
        path: Routes.CONFIRM_BUSINESS_TYPE_PAGE,
        builder: (context, state) => const ConfirmBusinessTypePage(),
      ),
      GoRoute(
        path: Routes.ALL_MENU_PAGE,
        builder: (context, state) => const AllMenuPage(),
      ),
      GoRoute(
        path: Routes.SAVE_MENU_PAGE,
        builder: (context, state) => const SaveMenuPage(),
      ),
      GoRoute(
        path: Routes.NEW_MENU_GREETING_PAGE,
        builder: (context, state) => const NewMenuGreetingPage(),
      ),
      GoRoute(
        path: Routes.MENU_DESCRIPTION_PAGE,
        builder: (context, state) => const MenuDescriptionPage(),
      ),
    ],
  );

  static GoRouter get router => _router;
}
