// ignore_for_file: constant_identifier_names
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:homemakers_merchant/app/features/address/index.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/about_us.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/login_page.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/otp_verification_page.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/phone_number_verification_page.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/privacy_and_policy_view.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/terms_and_conditions_view.dart';
import 'package:homemakers_merchant/app/features/dashboard/presentation/pages/main_dashboard_page.dart';
import 'package:homemakers_merchant/app/features/dashboard/presentation/pages/primary_dashboard_page.dart';
import 'package:homemakers_merchant/app/features/dashboard/presentation/pages/welcome_page.dart';
import 'package:homemakers_merchant/app/features/menu/index.dart';
import 'package:homemakers_merchant/app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:homemakers_merchant/app/features/onboarding/presentation/pages/splash_page.dart';
import 'package:homemakers_merchant/app/features/profile/index.dart';
import 'package:homemakers_merchant/app/features/store/index.dart';

part 'app_routes.dart';

class AppRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  static final shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

  AppRouter._();

  static const String INITIAL = Routes.ADDRESS_FORM_PAGE;

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
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return OTPVerificationPage(
            phoneNumber: args?['mobileNumber'] as String,
            countryDialCode: args?['countryDialCode'] ?? '' as String,
            phoneNumberWithoutFormat: args?['phoneNumberWithoutFormat'] as String,
          );
        },
      ),
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
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return BusinessInformationPage(
            businessProfileEntity: args?['businessProfileEntity'] as BusinessProfileEntity?,
            hasEditBusinessProfile: args?['hasEditBusinessProfile'] ?? false as bool,
            currentIndex: args?['currentIndex'] ?? -1 as int,
          );
        },
      ),
      GoRoute(
        path: Routes.DOCUMENT_LIST_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return BusinessDocumentPage(
            businessDocumentUploadedEntities:
                args?['businessDocumentUploadedEntities'] ?? <BusinessDocumentUploadedEntity>[] as List<BusinessDocumentUploadedEntity>,
            hasEditBusinessDocument: args?['hasEditBusinessDocument'] ?? false as bool,
            currentIndex: args?['currentIndex'] ?? -1 as int,
          );
        },
      ),
      GoRoute(
        path: Routes.UPLOAD_DOCUMENT_PAGE,
        builder: (context, state) => UploadDocumentPage(documentType: DocumentType.values.byName(jsonDecode(state.extra! as String)['documentType'])),
      ),
      GoRoute(
        path: Routes.ADDRESS_FORM_PAGE,
        builder: (context, state) => const AddressFormPage(),
      ),
      GoRoute(
          path: Routes.BANK_INFORMATION_PAGE,
          builder: (context, state) {
            final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
            return BankInformationPage(
              paymentBankEntity: args?['paymentBankEntity'] as PaymentBankEntity?,
              hasEditBankInformation: args?['hasEditBankInformation'] ?? false as bool,
              currentIndex: args?['currentIndex'] ?? -1 as int,
            );
          }),
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
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return SaveStorePage(
            storeEntity: args?['storeEntity'] as StoreEntity?,
            haveNewStore: args?['haveNewStore'] ?? true as bool,
            currentIndex: args?['currentIndex'] ?? -1 as int,
          );
        },
      ),
      GoRoute(
        path: Routes.ALL_STORES_PAGE,
        builder: (context, state) => const AllStoresPage(),
      ),
      GoRoute(
        path: Routes.NEW_STORE_GREETING_PAGE,
        builder: (context, state) {
          return NewStoreGreetingPage(
            storeEntity: state.extra! as StoreEntity,
          );
        },
      ),
      GoRoute(
        path: Routes.PICKUP_LOCATION_FROM_MAP_PAGE,
        // (TODO(prasant):Prasant): Replace and Set object of address model
        builder: (context, state) => PickupLocationFromMapPage(
          addressModel: AddressModel(),
        ), //state.extra as AddressModel
      ),
      GoRoute(
        path: Routes.CONFIRM_BUSINESS_TYPE_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return ConfirmBusinessTypePage(
            businessProfileEntity: args?['businessProfileEntity'] as BusinessProfileEntity?,
            hasEditBusinessProfile: args?['hasEditBusinessProfile'] ?? false as bool,
            currentIndex: args?['currentIndex'] ?? -1 as int,
            businessTypeEntity: args?['businessTypeEntity'] as BusinessTypeEntity?,
          );
        },
      ),
      GoRoute(
        path: Routes.ALL_MENU_PAGE,
        builder: (context, state) => const AllMenuPage(),
      ),
      GoRoute(
        path: Routes.SAVE_MENU_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return SaveMenuPage(
            menuEntity: args?['menuEntity'] as MenuEntity?,
            haveNewMenu: args?['haveNewMenu'] ?? true as bool,
            currentIndex: args?['currentIndex'] ?? -1 as int,
          );
        },
      ),
      GoRoute(
        path: Routes.NEW_MENU_GREETING_PAGE,
        builder: (context, state) => NewMenuGreetingPage(menuEntity: state.extra! as MenuEntity),
      ),
      GoRoute(
        path: Routes.MENU_DESCRIPTION_PAGE,
        builder: (context, state) => const MenuDescriptionPage(),
      ),
      GoRoute(
        path: Routes.MENU_FORM1_PAGE,
        builder: (context, state) => const MenuForm1Page(),
      ),
      GoRoute(
        path: Routes.MENU_FORM2_PAGE,
        builder: (context, state) => const MenuForm2Page(),
      ),
      GoRoute(
        path: Routes.MENU_FORM3_PAGE,
        builder: (context, state) => const MenuForm3Page(),
      ),
      GoRoute(
        path: Routes.MENU_FORM4_PAGE,
        builder: (context, state) => const MenuForm4Page(),
      ),
      GoRoute(
        path: Routes.MENU_FORM5_PAGE,
        builder: (context, state) => const MenuForm5Page(),
      ),
      GoRoute(
        path: Routes.ALL_ADDONS_PAGE,
        builder: (context, state) => const MenuAllAddonsPage(),
      ),
      GoRoute(
        path: Routes.SAVE_ADDONS_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return SaveAddonsPage(
            addons: args?['addons'] as Addons?,
            haveNewAddons: args?['haveNewAddons'] ?? true as bool,
            haveOwnAddons: args?['haveOwnAddons'] ?? true as bool,
            currentIndex: args?['currentIndex'] ?? -1 as int,
          );
        },
      ),
      GoRoute(
        path: Routes.NEW_ADDONS_GREETING_PAGE,
        builder: (context, state) => NewAddonsGreetingPage(addonsEntity: state.extra! as Addons),
      ),
      GoRoute(
        path: Routes.BIND_MENU_WITH_STORE_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return BindMenuWithStore(
            listOfAllMenus: args?['allMenu'] ?? <MenuEntity>[] as List<MenuEntity>,
            listOfAllSelectedMenus: args?['selectedMenus'] ?? <MenuEntity>[] as List<MenuEntity>,
          );
        },
      ),
      GoRoute(
        path: Routes.BIND_MENU_WITH_STORE_GREETING_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return BindMenuWithStoreGreetingPage(
            menuEntities: args?['allMenu'] ?? <MenuEntity>[] as List<MenuEntity>,
            storeEntities: args?['allStore'] ?? <MenuEntity>[] as List<StoreEntity>,
          );
        },
      ),
      GoRoute(
        path: Routes.STORE_PREVIEW_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return StoreDetailsPage(
            storeEntity: args?['store'] ?? StoreEntity() as StoreEntity,
            index: args?['index'] ?? -1 as int,
            storeEntities: args?['allStores'] ?? <StoreEntity>[] as List<StoreEntity>,
          );
        },
      ),
      GoRoute(
        path: Routes.MENU_PREVIEW_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return MenuDetailsPage(
            menuEntity: args?['menu'] ?? MenuEntity() as MenuEntity,
            index: args?['index'] ?? -1 as int,
            menuEntities: args?['allMenus'] ?? <MenuEntity>[] as List<MenuEntity>,
          );
        },
      ),
      GoRoute(
        path: Routes.STORE_DETAILS_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return StoreDetailsPage(
            storeEntity: args?['store'] ?? StoreEntity() as StoreEntity,
            index: args?['index'] ?? -1 as int,
            storeEntities: args?['allStores'] ?? <StoreEntity>[] as List<StoreEntity>,
          );
        },
      ),
      GoRoute(
        path: Routes.MENU_DETAILS_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return MenuDetailsPage(
            menuEntity: args?['menu'] ?? MenuEntity() as MenuEntity,
            index: args?['index'] ?? -1 as int,
            menuEntities: args?['allMenus'] ?? <MenuEntity>[] as List<MenuEntity>,
          );
        },
      ),
      //SaveDriverPage
      // All Drivers
      // New Driver Greetings
      GoRoute(
        path: Routes.ALL_DRIVER_PAGE,
        builder: (context, state) => const StoreOwnerAllDrivers(),
      ),
      GoRoute(
        path: Routes.SAVE_DRIVER_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return SaveDriverPage(
            storeOwnDeliveryPartnersInfo: args?['storeOwnDeliveryPartnersInfo'] as StoreOwnDeliveryPartnersInfo?,
            haveStoreOwnNewDeliveryPartnersInfo: args?['haveNewDriver'] ?? true as bool,
            currentIndex: args?['currentIndex'] ?? -1 as int,
          );
        },
      ),
      GoRoute(
        path: Routes.NEW_DRIVER_GREETING_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return NewDriverGreetingPage(
            storeOwnDeliveryPartnerEntity: args?['storeOwnDeliveryPartnerEntity'] as StoreOwnDeliveryPartnersInfo,
          );
        },
      ),

      GoRoute(
        path: Routes.BIND_DRIVER_WITH_STORE_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return BindDriverWithStore(
            listOfAllStoreOwnDeliveryPartners: args?['allDriver'] ?? <StoreOwnDeliveryPartnersInfo>[] as List<StoreOwnDeliveryPartnersInfo>,
            listOfAllSelectedStoreOwnDeliveryPartners: args?['selectedDriver'] ?? <StoreOwnDeliveryPartnersInfo>[] as List<StoreOwnDeliveryPartnersInfo>,
          );
        },
      ),
      GoRoute(
        path: Routes.BIND_DRIVER_WITH_STORE_GREETING_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return BindDriverWithStoreGreetingPage(
            storeOwnDeliveryPartnersEntities: args?['allDriver'] ?? <StoreOwnDeliveryPartnersInfo>[] as List<StoreOwnDeliveryPartnersInfo>,
            storeEntities: args?['allStore'] ?? <MenuEntity>[] as List<StoreEntity>,
          );
        },
      ),
      // Address - ALL_SAVED_ADDRESS_LIST
      GoRoute(
        path: Routes.ALL_SAVED_ADDRESS_LIST,
        builder: (context, state) => const AllSavedAddressPage(),
      ),
    ],
  );

  static GoRouter get router => _router;
}
