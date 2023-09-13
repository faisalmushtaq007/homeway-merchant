// ignore_for_file: constant_identifier_names
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:geocoder_buddy/geocoder_buddy.dart';
import 'package:go_router/go_router.dart';
import 'package:homemakers_merchant/app/features/address/index.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/about_us.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/login_page.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/otp_verification_page.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/phone_number_verification_page.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/privacy_and_policy_view.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/terms_and_conditions_view.dart';
import 'package:homemakers_merchant/app/features/chat/domain/entities/chat_types_entity.dart' as types;
import 'package:homemakers_merchant/app/features/chat/index.dart';
import 'package:homemakers_merchant/app/features/dashboard/index.dart';
import 'package:homemakers_merchant/app/features/faq/index.dart';
import 'package:homemakers_merchant/app/features/menu/index.dart';
import 'package:homemakers_merchant/app/features/notification/index.dart';
import 'package:homemakers_merchant/app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:homemakers_merchant/app/features/onboarding/presentation/pages/splash_page.dart';
import 'package:homemakers_merchant/app/features/order/index.dart';
import 'package:homemakers_merchant/app/features/payment/index.dart';
import 'package:homemakers_merchant/app/features/profile/index.dart';
import 'package:homemakers_merchant/app/features/rate_review/index.dart';
import 'package:homemakers_merchant/app/features/store/index.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/core/common/enum/generic_enum.dart';
import 'package:homemakers_merchant/utils/app_log.dart';

part 'app_routes.dart';

class AppRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  static final shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');
  static final userModelController = serviceLocator<UserModelStorageController>();

  AppRouter._();

  static const String INITIAL = Routes.NEW_MAP_PAGE;

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
            isoCode: args?['isoCode'] as String,
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
        path: Routes.NEW_DOCUMENT_LIST_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return NewBusinessDocumentPage(
            businessDocumentEntities: args?['businessDocumentUploadedEntities'] ?? <NewBusinessDocumentEntity>[] as List<NewBusinessDocumentEntity>,
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
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return AddressFormPage(
            addressModel: args?['addressModel'] as AddressModel?,
            allAddress: args?['allAddress'] ?? <AddressModel>[] as List<AddressModel>,
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
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return MainDashboardPage(
            isMainDrawerPage: args?['isMainDrawerPage'] ?? true,
          );
        },
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
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return AllStoresPage(
            selectItemUseCase: args?['selectItemUseCase'] ?? SelectItemUseCase.none,
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
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return PickupLocationFromMapPage(
            addressModel: args?['addressEntity'] as AddressModel?,
            allAddress: args?['addressEntities'] ?? <AddressModel>[] as List<AddressModel>,
            currentIndex: args?['currentIndex'] ?? -1 as int,
            hasNewAddress: args?['haveNewAddress'] ?? true as bool,
          );
        }, //state.extra as AddressModel
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
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return AllMenuPage(
            selectItemUseCase: args?['selectItemUseCase'] ?? SelectItemUseCase.none,
          );
        },
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
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return MenuAllAddonsPage(
            selectItemUseCase: args?['selectItemUseCase'] ?? SelectItemUseCase.none,
          );
        },
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
            pageKey: args?['pageKey'] ?? 1,
            pageSize: args?['pageSize'] ?? 10,
            searchItem: args?['searchItem'] ?? '',
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
            selectItemUseCase: args?['selectItemUseCase'] ?? SelectItemUseCase.none,
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
            message: args?['message'] ?? '',
            isRemoved: args?['isRemoved'] ?? false,
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
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return StoreOwnerAllDrivers(
            selectItemUseCase: args?['selectItemUseCase'] ?? SelectItemUseCase.none,
          );
        },
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
            selectItemUseCase: args?['selectItemUseCase'] ?? SelectItemUseCase.none,
            listOfAllStoreOwnDeliveryPartners: args?['allDriver'] ?? <StoreOwnDeliveryPartnersInfo>[],
            listOfAllSelectedStoreOwnDeliveryPartners: args?['selectedDriver'] ?? <StoreOwnDeliveryPartnersInfo>[],
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
            message: args?['message'] ?? '',
            isRemoved: args?['isRemoved'] ?? false,
          );
        },
      ),
      GoRoute(
        path: Routes.ALL_SAVED_ADDRESS_LIST,
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return AllSavedAddressPage(
            selectItemUseCase: args?['selectItemUseCase'] ?? SelectItemUseCase.none,
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
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return ManageOrderPage(
            storeEntity: args?['storeEntity'] as StoreEntity?,
            storeID: args?['storeID'] ?? -1,
          );
        },
      ),
      GoRoute(
        path: Routes.ORDER_DETAILS,
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return OrderDetailPage(
            orderEntity: args?['orderEntity'] as OrderEntity?,
            orderID: args?['orderID'] ?? -1,
          );
        },
      ),
      GoRoute(
        path: Routes.MAIN_CATEGORY_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return MainCategoryPage();
        },
      ),
      GoRoute(
        path: Routes.WALLET_DASHBOARD_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return WalletDashboardPage();
        },
      ),
      GoRoute(
        path: Routes.ALL_TRANSCATIONS_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return TransactionsPage(

          );
        },
      ),
      GoRoute(
        path: Routes.WITHDRAWAL_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return WithdrawalPage();
        },
      ),
      GoRoute(
        path: Routes.WITHDRAWAL_FORM_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return WithdrawalFormPage();
        },
      ),
      GoRoute(
        path: Routes.CHAT_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return ChatPage(
            room: args?['room'] as types.Room,
          );
        },
      ),
      GoRoute(
        path: Routes.ROOM_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return RoomsPage();
        },
      ),
      GoRoute(
        path: Routes.CHAT_USER_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return UsersPage();
        },
      ),
      GoRoute(
        path: Routes.NEW_MAP_PAGE,
        builder: (context, state) {
          final Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
          return NewMapPage();
        },
      ),

    ],
    /*redirect: (context, state) {
      bool hasCurrentUserLoggedIn = userModelController.userModel.hasCurrentUser;
      if (hasCurrentUserLoggedIn) {
        final int index = userModelController.userModel.currentUserStage + 1;
        switch (index) {
          case 1:
            {
              return Routes.CREATE_BUSINESS_PROFILE_PAGE;
            }
          case 2:
            {
              return Routes.CONFIRM_BUSINESS_TYPE_PAGE;
            }
          case 3:
            {
              return Routes.BANK_INFORMATION_PAGE;
            }
          case 4:
            {
              return Routes.DOCUMENT_LIST_PAGE;
            }
          case 5:
            {
              return Routes.PRIMARY_DASHBOARD_PAGE;
            }
          case _:
            {
              return state.matchedLocation;
            }
        }
      } else {
        return state.matchedLocation;
      }
    },*/
    refreshListenable: serviceLocator<UserModelStorageController>(),
  );

  static GoRouter get router => _router;
}
