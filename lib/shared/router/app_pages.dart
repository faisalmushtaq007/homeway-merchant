// ignore_for_file: constant_identifier_names
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:geocoder_buddy/geocoder_buddy.dart';
import 'package:go_router/go_router.dart';
import 'package:homemakers_merchant/app/features/address/index.dart';
import 'package:homemakers_merchant/app/features/analysis/index.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/about_us.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/otp_verification_page.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/phone_number_verification_page.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/privacy_and_policy_view.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/terms_and_conditions_view.dart';
import 'package:homemakers_merchant/app/features/chat/domain/entities/chat_types_entity.dart'
    as types;
import 'package:homemakers_merchant/app/features/chat/index.dart';
import 'package:homemakers_merchant/app/features/common/index.dart';
import 'package:homemakers_merchant/app/features/dashboard/index.dart';
import 'package:homemakers_merchant/app/features/faq/index.dart';
import 'package:homemakers_merchant/app/features/menu/index.dart';
import 'package:homemakers_merchant/app/features/notification/index.dart';
import 'package:homemakers_merchant/app/features/onboarding/index.dart';
import 'package:homemakers_merchant/app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:homemakers_merchant/app/features/onboarding/presentation/pages/splash_page.dart';
import 'package:homemakers_merchant/app/features/order/index.dart';
import 'package:homemakers_merchant/app/features/payment/index.dart';
import 'package:homemakers_merchant/app/features/profile/index.dart';
import 'package:homemakers_merchant/app/features/rate_review/index.dart';
import 'package:homemakers_merchant/app/features/setting/index.dart';
import 'package:homemakers_merchant/app/features/store/index.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/core/common/enum/generic_enum.dart';
import 'package:homemakers_merchant/utils/app_log.dart';
import 'package:logger/logger.dart';

part 'app_routes.dart';

class AppRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  static final shellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shell');
  static final userModelController =
      serviceLocator<UserModelStorageController>();

  AppRouter._();

  static const String INITIAL = Routes.AUTH_PHONE_NUMBER_VERIFICATION;

  static final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: INITIAL,
    navigatorKey: rootNavigatorKey,
    observers: <NavigatorObserver>[AppNavigationObserver()],
    routes: [
      GoRoute(
        path: Routes.INITIAL_SPLASH_PAGE,
        builder: (context, state) => const InitialSplashScreenPage(),
      ),
      GoRoute(
        path: Routes.SPLASH,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: Routes.INITIAL,
        builder: (context, state) => const OnBoardingPage(),
      ),

      GoRoute(
        path: Routes.AUTH_PHONE_NUMBER_VERIFICATION,
        builder: (context, state) => const PhoneNumberVerificationPage(),
      ),
      GoRoute(
        path: Routes.AUTH_OTP_VERIFICATION,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return OTPVerificationPage(
            phoneNumber: args?['phoneNumber'] as String,
            countryDialCode: args?['countryDialCode'] ?? '' as String,
            phoneNumberWithFormat: args?['phoneNumberWithFormat'] as String,
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
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return BusinessInformationPage(
            businessProfileEntity:
                args?['businessProfileEntity'] as BusinessProfileEntity?,
            hasEditBusinessProfile:
                args?['hasEditBusinessProfile'] ?? false as bool,
            currentIndex: args?['currentIndex'] ?? -1 as int,
            selectionUseCase:
                args?['selectionUseCase'] ?? SelectionUseCase.saveAndNext,
          );
        },
      ),
      GoRoute(
        path: Routes.DOCUMENT_LIST_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return BusinessDocumentPage(
            businessDocumentUploadedEntities:
                args?['businessDocumentUploadedEntities'] ??
                    <BusinessDocumentUploadedEntity>[]
                        as List<BusinessDocumentUploadedEntity>,
            hasEditBusinessDocument:
                args?['hasEditBusinessDocument'] ?? false as bool,
            currentIndex: args?['currentIndex'] ?? -1 as int,
            selectionUseCase:
                args?['selectionUseCase'] ?? SelectionUseCase.saveAndNext,
          );
        },
      ),
      GoRoute(
        path: Routes.NEW_DOCUMENT_LIST_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return NewBusinessDocumentPage(
            businessDocumentEntities:
                args?['businessDocumentUploadedEntities'] ??
                    <NewBusinessDocumentEntity>[]
                        as List<NewBusinessDocumentEntity>,
            hasEditBusinessDocument:
                args?['hasEditBusinessDocument'] ?? false as bool,
            currentIndex: args?['currentIndex'] ?? -1 as int,
            selectionUseCase:
                args?['selectionUseCase'] ?? SelectionUseCase.saveAndNext,
          );
        },
      ),
      GoRoute(
        path: Routes.UPLOAD_DOCUMENT_PAGE,
        builder: (context, state) {
          String documentType = 'other';
          String selectionUseCase = 'saveAndNext';
          if (state.extra != null) {
            documentType =
                jsonDecode(state.extra! as String)['documentType'] ?? 'other';
            selectionUseCase =
                jsonDecode(state.extra! as String)['selectionUseCase'] ??
                    'saveAndNext';
            return UploadDocumentPage(
              documentType: DocumentType.values.byName(
                documentType,
              ),
              selectionUseCase:
                  SelectionUseCase.values.byName(selectionUseCase),
            );
          } else {
            return UploadDocumentPage(
              documentType: DocumentType.values.byName(
                jsonDecode(state.extra! as String)['documentType'],
              ),
            );
          }
        },
      ),
      GoRoute(
        path: Routes.ADDRESS_FORM_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return AddressFormPage(
            addressModel: args?['addressModel'] as AddressModel?,
            allAddress:
                args?['allAddress'] ?? <AddressModel>[] as List<AddressModel>,
            currentIndex: args?['currentIndex'] ?? -1 as int,
            hasNewAddress: args?['hasNewAddress'] ?? false as bool,
            latitude: args?['latitude'] ?? 0.0 as double,
            locationData: args?['locationData'] as GBData?,
            longitude: args?['longitude'] ?? 0.0 as double,
            hasViewAddress: args?['hasViewAddress'] ?? false as bool,
          );
        },
      ),
      GoRoute(
          path: Routes.BANK_INFORMATION_PAGE,
          builder: (context, state) {
            final Map<String, dynamic>? args =
                state.extra as Map<String, dynamic>?;
            return BankInformationPage(
              paymentBankEntity:
                  args?['paymentBankEntity'] as PaymentBankEntity?,
              hasEditBankInformation:
                  args?['hasEditBankInformation'] ?? false as bool,
              currentIndex: args?['currentIndex'] ?? -1 as int,
              selectionUseCase:
                  args?['selectionUseCase'] ?? SelectionUseCase.saveAndNext,
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
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return MainDashboardPage(
            isMainDrawerPage: args?['isMainDrawerPage'] ?? true,
          );
        },
      ),
      GoRoute(
        path: Routes.SAVE_STORE_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return SaveStorePage(
            storeEntity: args?['storeEntity'] as StoreEntity?,
            haveNewStore: args?['haveNewStore'] ?? true as bool,
            currentIndex: args?['currentIndex'] ?? -1 as int,
          );
        },
      ),
      GoRoute(
        path: Routes.ALL_STORES_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return AllStoresPage(
            selectItemUseCase:
                args?['selectItemUseCase'] ?? SelectItemUseCase.none,
          );
        },
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
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return PickupLocationFromMapPage(
            addressModel: args?['addressEntity'] as AddressModel?,
            allAddress: args?['addressEntities'] ??
                <AddressModel>[] as List<AddressModel>,
            currentIndex: args?['currentIndex'] ?? -1 as int,
            hasNewAddress: args?['haveNewAddress'] ?? true as bool,
          );
        }, //state.extra as AddressModel
      ),
      GoRoute(
        path: Routes.CONFIRM_BUSINESS_TYPE_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return ConfirmBusinessTypePage(
            businessProfileEntity:
                args?['businessProfileEntity'] as BusinessProfileEntity?,
            hasEditBusinessProfile:
                args?['hasEditBusinessProfile'] ?? false as bool,
            currentIndex: args?['currentIndex'] ?? -1 as int,
            businessTypeEntity:
                args?['businessTypeEntity'] as BusinessTypeEntity?,
            selectionUseCase:
                args?['selectionUseCase'] ?? SelectionUseCase.saveAndNext,
          );
        },
      ),
      GoRoute(
        path: Routes.ALL_MENU_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return AllMenuPage(
            selectItemUseCase:
                args?['selectItemUseCase'] ?? SelectItemUseCase.none,
          );
        },
      ),
      GoRoute(
        path: Routes.SAVE_MENU_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return SaveMenuPage(
            menuEntity: args?['menuEntity'] as MenuEntity?,
            haveNewMenu: args?['haveNewMenu'] ?? true as bool,
            currentIndex: args?['currentIndex'] ?? -1 as int,
          );
        },
      ),
      GoRoute(
        path: Routes.REFORM_SAVE_MENU_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return ReFormSaveMenuPage(
            menuEntity: args?['menuEntity'] as MenuEntity?,
            haveNewMenu: args?['haveNewMenu'] ?? true as bool,
            currentIndex: args?['currentIndex'] ?? -1 as int,
            selectionUseCase:
                args?['selectionUseCase'] ?? SelectionUseCase.saveAndNext,
          );
        },
      ),
      GoRoute(
        path: Routes.NEW_MENU_GREETING_PAGE,
        builder: (context, state) =>
            NewMenuGreetingPage(menuEntity: state.extra! as MenuEntity),
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
        path: Routes.MENU_PRICE_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return ConfirmMenuPricePage(
            selectionUseCase:
                args?['selectionUseCase'] ?? SelectionUseCase.saveAndNext,
            menuEntity: args?['menuEntity'] ?? MenuEntity(),
            haveNewMenu: args?['haveNewMenu'] ?? true,
            currentIndex: args?['currentIndex'] ?? -1,
          );
        },
      ),
      GoRoute(
        path: Routes.UPLOAD_MENU_IMAGE_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return UploadMenuImagePage(
            selectionUseCase:
                args?['selectionUseCase'] ?? SelectionUseCase.saveAndNext,
            menuEntity: args?['menuEntity'] ?? MenuEntity(),
            haveNewMenu: args?['haveNewMenu'] ?? true,
            currentIndex: args?['currentIndex'] ?? -1,
          );
        },
      ),
      GoRoute(
        path: Routes.ALL_ADDONS_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return MenuAllAddonsPage(
            selectItemUseCase:
                args?['selectItemUseCase'] ?? SelectItemUseCase.none,
          );
        },
      ),
      GoRoute(
        path: Routes.SAVE_ADDONS_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return SaveAddonsPage(
            addons: args?['addons'] as Addons?,
            haveNewAddons: args?['haveNewAddons'] ?? true as bool,
            haveOwnAddons: args?['haveOwnAddons'] ?? true as bool,
            currentIndex: args?['currentIndex'] ?? -1 as int,
            pageKey: args?['pageKey'] ?? 1,
            pageSize: args?['pageSize'] ?? 10,
            searchItem: args?['searchItem'] ?? '',
          );
        },
      ),
      GoRoute(
        path: Routes.NEW_ADDONS_GREETING_PAGE,
        builder: (context, state) =>
            NewAddonsGreetingPage(addonsEntity: state.extra! as Addons),
      ),
      GoRoute(
        path: Routes.BIND_MENU_WITH_STORE_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return BindMenuWithStore(
            listOfAllMenus:
                args?['allMenu'] ?? <MenuEntity>[] as List<MenuEntity>,
            listOfAllSelectedMenus:
                args?['selectedMenus'] ?? <MenuEntity>[] as List<MenuEntity>,
            selectItemUseCase:
                args?['selectItemUseCase'] ?? SelectItemUseCase.none,
          );
        },
      ),
      GoRoute(
        path: Routes.BIND_MENU_WITH_STORE_GREETING_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return BindMenuWithStoreGreetingPage(
            menuEntities:
                args?['allMenu'] ?? <MenuEntity>[] as List<MenuEntity>,
            storeEntities:
                args?['allStore'] ?? <MenuEntity>[] as List<StoreEntity>,
            message: args?['message'] ?? '',
            isRemoved: args?['isRemoved'] ?? false,
          );
        },
      ),
      GoRoute(
        path: Routes.STORE_PREVIEW_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return StoreDetailsPage(
            storeEntity: args?['store'] ?? StoreEntity() as StoreEntity,
            index: args?['index'] ?? -1 as int,
            storeEntities:
                args?['allStores'] ?? <StoreEntity>[] as List<StoreEntity>,
          );
        },
      ),
      GoRoute(
        path: Routes.MENU_PREVIEW_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return MenuDetailsPage(
            menuEntity: args?['menu'] ?? MenuEntity() as MenuEntity,
            index: args?['index'] ?? -1 as int,
            menuEntities:
                args?['allMenus'] ?? <MenuEntity>[] as List<MenuEntity>,
          );
        },
      ),
      GoRoute(
        path: Routes.STORE_DETAILS_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return StoreDetailsPage(
            storeEntity: args?['store'] ?? StoreEntity() as StoreEntity,
            index: args?['index'] ?? -1 as int,
            storeEntities:
                args?['allStores'] ?? <StoreEntity>[] as List<StoreEntity>,
          );
        },
      ),
      GoRoute(
        path: Routes.MENU_DETAILS_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return MenuDetailsPage(
            menuEntity: args?['menu'] ?? MenuEntity() as MenuEntity,
            index: args?['index'] ?? -1 as int,
            menuEntities:
                args?['allMenus'] ?? <MenuEntity>[] as List<MenuEntity>,
          );
        },
      ),
      //SaveDriverPage
      // All Drivers
      // New Driver Greetings
      GoRoute(
        path: Routes.ALL_DRIVER_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return StoreOwnerAllDrivers(
            selectItemUseCase:
                args?['selectItemUseCase'] ?? SelectItemUseCase.none,
          );
        },
      ),
      GoRoute(
        path: Routes.SAVE_DRIVER_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return SaveDriverPage(
            storeOwnDeliveryPartnersInfo: args?['storeOwnDeliveryPartnersInfo']
                as StoreOwnDeliveryPartnersInfo?,
            haveStoreOwnNewDeliveryPartnersInfo:
                args?['haveNewDriver'] ?? true as bool,
            currentIndex: args?['currentIndex'] ?? -1 as int,
          );
        },
      ),
      GoRoute(
        path: Routes.NEW_DRIVER_GREETING_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return NewDriverGreetingPage(
            storeOwnDeliveryPartnerEntity:
                args?['storeOwnDeliveryPartnerEntity']
                    as StoreOwnDeliveryPartnersInfo,
          );
        },
      ),

      GoRoute(
        path: Routes.BIND_DRIVER_WITH_STORE_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return BindDriverWithStore(
            selectItemUseCase:
                args?['selectItemUseCase'] ?? SelectItemUseCase.none,
            listOfAllStoreOwnDeliveryPartners:
                args?['allDriver'] ?? <StoreOwnDeliveryPartnersInfo>[],
            listOfAllSelectedStoreOwnDeliveryPartners:
                args?['selectedDriver'] ?? <StoreOwnDeliveryPartnersInfo>[],
          );
        },
      ),
      GoRoute(
        path: Routes.BIND_DRIVER_WITH_STORE_GREETING_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return BindDriverWithStoreGreetingPage(
            storeOwnDeliveryPartnersEntities: args?['allDriver'] ??
                <StoreOwnDeliveryPartnersInfo>[]
                    as List<StoreOwnDeliveryPartnersInfo>,
            storeEntities:
                args?['allStore'] ?? <MenuEntity>[] as List<StoreEntity>,
            message: args?['message'] ?? '',
            isRemoved: args?['isRemoved'] ?? false,
          );
        },
      ),
      GoRoute(
        path: Routes.ALL_SAVED_ADDRESS_LIST,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return AllSavedAddressPage(
            selectItemUseCase:
                args?['selectItemUseCase'] ?? SelectItemUseCase.none,
          );
        },
      ),
      GoRoute(
        path: Routes.NOTIFICATIONS,
        builder: (context, state) => const NotificationPage(),
      ),
      GoRoute(
        path: Routes.RATE_AND_REVIEW_PAGE,
        builder: (context, state) => const RateAndReviewPage(),
      ),
      GoRoute(
        path: Routes.FAQ_PAGE,
        builder: (context, state) => const FaqPage(),
      ),
      GoRoute(
        path: Routes.MANAGE_ORDER_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return ManageOrderPage(
            storeEntity: args?['storeEntity'] as StoreEntity?,
            storeID: args?['storeID'] ?? -1,
          );
        },
      ),
      GoRoute(
        path: Routes.ORDER_DETAILS,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return OrderDetailPage(
            orderEntity: args?['orderEntity'] as OrderEntity?,
            orderID: args?['orderID'] ?? -1,
          );
        },
      ),
      GoRoute(
        path: Routes.MAIN_CATEGORY_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return const MainCategoryPage();
        },
      ),
      GoRoute(
        path: Routes.WALLET_DASHBOARD_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return const WalletDashboardPage();
        },
      ),
      GoRoute(
        path: Routes.ALL_TRANSCATIONS_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return const TransactionsPage();
        },
      ),
      GoRoute(
        path: Routes.WITHDRAWAL_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return const WithdrawalPage();
        },
      ),
      GoRoute(
        path: Routes.WITHDRAWAL_FORM_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return const WithdrawalFormPage();
        },
      ),
      GoRoute(
        path: Routes.CHAT_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return ChatPage(
            room: args?['room'] as types.Room,
          );
        },
      ),
      GoRoute(
        path: Routes.ROOM_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return const RoomsPage();
        },
      ),
      GoRoute(
        path: Routes.CHAT_USER_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return const UsersPage();
        },
      ),
      GoRoute(
        path: Routes.NEW_MAP_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return const NewMapPage();
        },
      ),
      GoRoute(
        path: Routes.ORDER_ANALYSIS_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return const OrderAnalysis();
        },
      ),
      GoRoute(
        path: Routes.PROFILE_SETTING_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return const ProfileSettingPage();
        },
      ),
      GoRoute(
        path: Routes.CHANGE_PHONE_NUMBER_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return ChangePhoneNumberPage(
              changePhoneNumberPurpose: args?['changePhoneNumberPurpose'] ??
                  ChangePhoneNumberPurpose.profile,
              phoneNumberWithoutDialCode: args?['phoneNumber'] ?? '',
              country: args?['country'] ?? '',
              dialCode: args?['dialCode'] ?? '',
              id: args?['id'] ?? -1);
        },
      ),
      GoRoute(
        path: Routes.COMMON_OTP_VERIFICATION_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return CommonOtpVerification(
            userNewEnteredPhoneNumber: args?['newPhoneNumber'] ?? '',
            userExistingEnteredPhoneNumber: args?['existingPhoneNumber'] ?? '',
            userExistingEnteredPhoneNumberWithoutDialCode:
                args?['existingPhoneNumberWithoutDialCode'] ?? '',
            userNewEnteredPhoneNumberWithoutDialCode:
                args?['newPhoneNumberWithoutDialCode'] ?? '',
            country: args?['country'] ?? '',
            dialCode: args?['dialCode'] ?? '',
            id: args?['id'] ?? -1,
          );
        },
      ),
      GoRoute(
        path: Routes.PAYMENT_GATEWAY,
        builder: (context, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return const PaymentGatewayPage();
        },
      ),
      //
    ],
    restorationScopeId: 'merchant_router',
    onException: (_, GoRouterState state, GoRouter router) {
      //router.go('/404', extra: state.uri.toString());
    },
    redirect: (context, state) async {
      // no need to redirect at all
      return null;
    },
  );

  static GoRouter get router => _router;
}

/// The Navigator observer.
class AppNavigationObserver extends NavigatorObserver {
  /// Creates a [AppNavigationObserver].
  AppNavigationObserver() {
    //log.onRecord.listen((LogRecord e) => debugPrint('$e'));
  }

  /// The logged message.
  final Logger log = appLog; //Logger('AppNavigationObserver');

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      log.i('didPush: ${route.str}, previousRoute= ${previousRoute?.str}');

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      log.i('didPop: ${route.str}, previousRoute= ${previousRoute?.str}');

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      log.i('didRemove: ${route.str}, previousRoute= ${previousRoute?.str}');

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) =>
      log.i('didReplace: new= ${newRoute?.str}, old= ${oldRoute?.str}');

  @override
  void didStartUserGesture(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) =>
      log.i('didStartUserGesture: ${route.str}, '
          'previousRoute= ${previousRoute?.str}');

  @override
  void didStopUserGesture() => log.i('didStopUserGesture');
}

extension on Route<dynamic> {
  String get str => 'route(${settings.name}: ${settings.arguments})';
}
