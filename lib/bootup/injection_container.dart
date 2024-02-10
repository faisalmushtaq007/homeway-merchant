import 'package:get_it/get_it.dart';
import 'package:homemakers_merchant/app/features/address/index.dart';
import 'package:homemakers_merchant/app/features/address/presentation/manager/address_bloc.dart';
import 'package:homemakers_merchant/app/features/analysis/presentation/manager/order/order_analysis_bloc.dart';
import 'package:homemakers_merchant/app/features/authentication/index.dart';

import 'package:homemakers_merchant/app/features/authentication/presentation/manager/otp_verification/otp_verification_bloc.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/manager/phone_number_verification_bloc.dart';
import 'package:homemakers_merchant/app/features/menu/index.dart';
import 'package:homemakers_merchant/app/features/notification/index.dart';
import 'package:homemakers_merchant/app/features/order/index.dart';
import 'package:homemakers_merchant/app/features/order/presentation/manager/all/all_order_bloc.dart';
import 'package:homemakers_merchant/app/features/order/presentation/manager/cancel/cancel_order_bloc.dart';
import 'package:homemakers_merchant/app/features/order/presentation/manager/deliver/deliver_order_bloc.dart';
import 'package:homemakers_merchant/app/features/order/presentation/manager/new/new_order_bloc.dart';
import 'package:homemakers_merchant/app/features/order/presentation/manager/onprocess/on_process_order_bloc.dart';
import 'package:homemakers_merchant/app/features/order/presentation/manager/recents/recent_order_bloc.dart';
import 'package:homemakers_merchant/app/features/order/presentation/manager/schedule/schedule_order_bloc.dart';
import 'package:homemakers_merchant/app/features/payment/presentation/manager/wallet/wallet_bloc.dart';
import 'package:homemakers_merchant/app/features/permission/presentation/bloc/permission_bloc.dart';
import 'package:homemakers_merchant/app/features/profile/index.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/manager/bank/payment_bank_bloc.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/manager/document/bloc/new_business_document_bloc.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/manager/document/business_document_bloc.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/manager/profile/business_profile_bloc.dart';
import 'package:homemakers_merchant/app/features/rate_review/index.dart';
import 'package:homemakers_merchant/app/features/store/index.dart';
import 'package:homemakers_merchant/config/permission/permission_controller.dart';
import 'package:homemakers_merchant/config/permission/permission_service.dart';
import 'package:homemakers_merchant/config/translation/app_translator.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/config/translation/language_service.dart';
import 'package:homemakers_merchant/config/translation/language_service_hive.dart';
import 'package:homemakers_merchant/config/translation/multiple_language_download.dart';
import 'package:homemakers_merchant/config/translation/translate_api.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/interface/storage_interface.dart';
import 'package:homemakers_merchant/core/keys/app_key.dart';
import 'package:homemakers_merchant/core/local/database/app_database.dart';
import 'package:homemakers_merchant/core/network/http/base_response_error_model.dart';
import 'package:homemakers_merchant/core/network/http/interceptor/token/fresh_token_interceptor.dart';
import 'package:homemakers_merchant/core/service/connectivity_bloc/connectivity_bloc.dart';
import 'package:homemakers_merchant/core/service/connectivity_bloc/src/connectivity_bloc/connectivity_service.dart';
import 'package:homemakers_merchant/shared/widgets/universal/phone_number_text_field/phone_form_field_bloc.dart';
import 'package:homemakers_merchant/shared/widgets/universal/wrap_and_more/src/wrap_and_more_controller.dart';
import 'package:homemakers_merchant/theme/theme_controller.dart';
import 'package:homemakers_merchant/theme/theme_service.dart';
import 'package:homemakers_merchant/theme/theme_service_hive.dart';
import 'package:homemakers_merchant/utils/universal_platform/src/universal_platform.dart';
import 'package:homeway_firebase/homeway_firebase.dart';
import 'package:network_manager/network_manager.dart';

GetIt serviceLocator = GetIt.instance;

Future<void> setupGetIt() async {
  serviceLocator.allowReassignment = true;
  _setupFirebase();
  await AppDatabase.instance.database;
  _setupGetIt();
  _setUpModel();
  await _setUpAppSetting();
  _setUpNetworkService();
  _setUpRestAPIService();
  _setUpRepository();
  _setUpUseCases();
  _setUpStateManagement();
  _registerAuthenticationFeature();
  return;
}

void _setupGetIt() {
  serviceLocator.allowReassignment = true;
  serviceLocator.registerSingleton<AppKey>(
    AppKey(),
  );
}

void _setUpModel() {
  serviceLocator
      .registerLazySingleton<BusinessProfileEntity>(BusinessProfileEntity.new);
  // Addons entity
  serviceLocator.registerLazySingleton<Addons>(
    Addons.new,
  );
  serviceLocator.registerLazySingleton<List<Addons>>(() => <Addons>[]);
  // Menu entity
  serviceLocator.registerLazySingleton<MenuEntity>(
    MenuEntity.new,
  );
  serviceLocator.registerLazySingleton<List<MenuEntity>>(() => <MenuEntity>[]);
  // Driver entity
  serviceLocator.registerLazySingleton<StoreOwnDeliveryPartnersInfo>(
    StoreOwnDeliveryPartnersInfo.new,
  );
  serviceLocator
      .registerLazySingleton<List<StoreOwnDeliveryPartnersInfo>>(() => []);
  // Store entity
  serviceLocator.registerLazySingleton<StoreEntity>(
    () => StoreEntity(
      menuEntities: serviceLocator(),
      storeOwnDeliveryPartnersInfo: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<List<StoreEntity>>(() => []);
  // App user entity
  serviceLocator.registerSingleton<AppUserEntity>(
    AppUserEntity(
      businessProfile: serviceLocator(),
      stores: serviceLocator(),
      menus: serviceLocator(),
      drivers: serviceLocator(),
      addons: serviceLocator(),
    ),
  );
}

Future<void> _setUpAppSetting() async {
  // Wrap and More Controller
  serviceLocator
      .registerSingleton<WrapAndMoreController>(WrapAndMoreController());
  // Manager Order Controller
  serviceLocator.registerSingleton<ManageOrderController>(
    ManageOrderController(),
  );
  await serviceLocator<ManageOrderController>().loadAll();
  serviceLocator.registerSingleton<ThemeService>(
      ThemeServiceHive('app_color_scheme_box'));
  //final ThemeService themeService = ThemeServicePrefs();
  //final ThemeService themeService = ThemeServiceHive('app_color_scheme_box');
  // Initialize the theme service.
  await serviceLocator<ThemeService>().init();
  serviceLocator
      .registerSingleton<ThemeController>(ThemeController(serviceLocator()));
  // Create a ThemeController that uses the ThemeService.
  //final ThemeController themeController = ThemeController(themeService);
  // Load preferred theme settings, while the app is loading, before MaterialApp
  // is created, this prevents a theme change when the app is first displayed.
  await serviceLocator<ThemeController>().loadAll();
  //await themeController.loadAll();
  // Only use Google fonts via asset provided fonts.
  // Init permission service
  serviceLocator.registerSingleton<IPermissionService>(
    PermissionServiceHive(GlobalApp.permissionBoxName),
  );
  await serviceLocator<IPermissionService>().init();
  serviceLocator.registerSingleton<PermissionController>(
    PermissionController(serviceLocator()),
  );
  await serviceLocator<PermissionController>().loadAll();
  // User Model service
  serviceLocator.registerSingleton<IStorageService>(
      LocalUserModelService(GlobalApp.storageBoxName));
  await serviceLocator<IStorageService>().init();

  serviceLocator.registerSingleton<UserModelStorageController>(
    UserModelStorageController(serviceLocator()),
  );
  await serviceLocator<UserModelStorageController>().loadAll();

  //Language selection
  serviceLocator.registerSingleton<ILanguageService>(
    LanguageServiceHive(GlobalApp.languageBoxName),
  );
  await serviceLocator<ILanguageService>().init();
  serviceLocator.registerSingleton<LanguageController>(
    LanguageController(serviceLocator()),
  );
  await serviceLocator<LanguageController>().loadAll();
  // TranslateApi
  final TranslateApi translateApi = TranslateApi(
    languageService: serviceLocator<ILanguageService>(),
    boxName: GlobalApp.languageBoxName,
  );
  serviceLocator.registerSingleton<TranslateApi>(
    translateApi,
  );
  // TranslateApi init
  //await translateApi.init(sourceLanguage: GlobalApp.defaultSourceTranslateLanguage, targetLanguage: GlobalApp.defaultSourceTranslateLanguage);
  // Multiple language download
  final MultipleLanguageDownload multipleLanguageDownload =
      MultipleLanguageDownload(
    languageService: serviceLocator<ILanguageService>(),
    boxName: GlobalApp.languageBoxName,
  );
  await multipleLanguageDownload.init();
  final AppTranslator appTranslator = AppTranslator(
    languageService: serviceLocator<ILanguageService>(),
    boxName: GlobalApp.languageBoxName,
    multipleLanguageDownload: multipleLanguageDownload,
  );
  await appTranslator.init(
    languageController: serviceLocator(),
    sourceLanguage:
        serviceLocator<LanguageController>().sourceTranslateLanguage,
    targetLanguage:
        serviceLocator<LanguageController>().targetTranslateLanguage,
    sourceAppLanguage: serviceLocator<LanguageController>().sourceApplanguage,
    targetAppLanguage: serviceLocator<LanguageController>().targetAppLanguage,
    initTextDirection: serviceLocator<LanguageController>().targetTextDirection,
  );
}

void _setUpNetworkService() {
  serviceLocator
      .registerSingleton<ConnectivityService>(ConnectivityService())
      .initConnectivityService();
}

void _setUpRestAPIService() {
  serviceLocator
    ..registerSingleton<FreshTokenInterceptor<OAuth2Token>>(
      FreshTokenInterceptor.oAuth2(
        tokenStorage: HiveTokenStorage(),
        refreshToken: (token, httpClient) async {
          return const OAuth2Token(
            accessToken: 'initial_access_token',
            refreshToken: 'initial_refresh_token',
          );
        },
      ),
    )
    ..registerFactory<INetworkManager<BaseResponseErrorModel>>(
          () => NetworkManager<BaseResponseErrorModel>(
        isEnableLogger: true,
        options: BaseOptions(
          baseUrl: GlobalApp.developmentUrl,
        ),
        //This is optional.
        errorModel: BaseResponseErrorModel(),
        /*errorModelFromData: (data) {

        },*/
        fileManager: LocalSembast(),
        additionalInterceptors: [
          serviceLocator<FreshTokenInterceptor<OAuth2Token>>(),
        ],
      ),
    )
    ..registerFactory<INetworkManager<BaseResponseErrorModel>>(
          () => NetworkManager<BaseResponseErrorModel>(
        isEnableLogger: true,
        options: BaseOptions(
          baseUrl: GlobalApp.productionUrl,
        ),
        //This is optional.
        errorModel: BaseResponseErrorModel(),
        /*errorModelFromData: (data) {

        },*/
        fileManager: LocalSembast(),
        additionalInterceptors: [
          serviceLocator<FreshTokenInterceptor<OAuth2Token>>(),
        ],
      ),
      instanceName: 'production',
    )
    ..registerFactory<INetworkManager<BaseResponseErrorModel>>(
          () => NetworkManager<BaseResponseErrorModel>(
        isEnableLogger: true,
        options: BaseOptions(
          baseUrl: 'http://localhost:3000',
        ),
        //This is optional.
        errorModel: BaseResponseErrorModel(),
        /*errorModelFromData: (data) {

        },*/
        fileManager: LocalSembast(),
        additionalInterceptors: [
          serviceLocator<FreshTokenInterceptor<OAuth2Token>>(),
        ],
      ),
      instanceName: 'localhost',
    );
}

void _setUpUseCases() {
  // Store
  serviceLocator.registerLazySingleton<SaveStoreUseCase>(
    () => SaveStoreUseCase(
      storeRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<SaveAllStoreUseCase>(
    () => SaveAllStoreUseCase(
      storeRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<EditStoreUseCase>(
    () => EditStoreUseCase(
      storeRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetStoreUseCase>(
    () => GetStoreUseCase(
      storeRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetAllStoreUseCase>(
    () => GetAllStoreUseCase(
      storeRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetAllStorePaginationUseCase>(
    () => GetAllStorePaginationUseCase(
      storeRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<DeleteStoreUseCase>(
    () => DeleteStoreUseCase(
      storeRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<DeleteAllStoreUseCase>(
    () => DeleteAllStoreUseCase(
      storeRepository: serviceLocator(),
    ),
  );
  // Driver
  serviceLocator.registerLazySingleton<SaveDriverUseCase>(
    () => SaveDriverUseCase(
      storeRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<SaveAllDriverUseCase>(
    () => SaveAllDriverUseCase(
      storeRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<EditDriverUseCase>(
    () => EditDriverUseCase(
      storeRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetDriverUseCase>(
    () => GetDriverUseCase(
      storeRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetAllDriverUseCase>(
    () => GetAllDriverUseCase(
      storeRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetAllDriverPaginationUseCase>(
    () => GetAllDriverPaginationUseCase(
      storeRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<DeleteDriverUseCase>(
    () => DeleteDriverUseCase(
      storeRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<DeleteAllDriverUseCase>(
    () => DeleteAllDriverUseCase(
      storeRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<BindDriverWithStoreUseCase>(
    () => BindDriverWithStoreUseCase(
      storeRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<UnBindDriverWithStoreUseCase>(
    () => UnBindDriverWithStoreUseCase(
      storeRepository: serviceLocator(),
    ),
  );
  //Menu
  serviceLocator.registerLazySingleton<SaveMenuUseCase>(
    () => SaveMenuUseCase(
      menuRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<EditMenuUseCase>(
    () => EditMenuUseCase(
      menuRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetMenuUseCase>(
    () => GetMenuUseCase(
      menuRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetAllMenuUseCase>(
    () => GetAllMenuUseCase(
      menuRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetAllMenuPaginationUseCase>(
    () => GetAllMenuPaginationUseCase(
      menuRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<SaveAllMenuUseCase>(
    () => SaveAllMenuUseCase(
      menuRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<DeleteMenuUseCase>(
    () => DeleteMenuUseCase(
      menuRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<DeleteAllMenuUseCase>(
    () => DeleteAllMenuUseCase(
      menuRepository: serviceLocator(),
    ),
  );
  //Addons
  serviceLocator.registerLazySingleton<SaveAddonsUseCase>(
    () => SaveAddonsUseCase(
      menuRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<EditAddonsUseCase>(
    () => EditAddonsUseCase(
      menuRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetAddonsUseCase>(
    () => GetAddonsUseCase(
      menuRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetAllAddonsUseCase>(
    () => GetAllAddonsUseCase(
      menuRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetAllAddonsPaginationUseCase>(
    () => GetAllAddonsPaginationUseCase(
      menuRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<SaveAllAddonsUseCase>(
    () => SaveAllAddonsUseCase(
      menuRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<DeleteAddonsUseCase>(
    () => DeleteAddonsUseCase(
      menuRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<DeleteAllAddonsUseCase>(
    () => DeleteAllAddonsUseCase(
      menuRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<BindAddonsWithMenuUseCase>(
    () => BindAddonsWithMenuUseCase(
      menuRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<BindMenuWithStoreUseCase>(
    () => BindMenuWithStoreUseCase(
      menuRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<UnBindMenuWithStoreUseCase>(
    () => UnBindMenuWithStoreUseCase(
      menuRepository: serviceLocator(),
    ),
  );

  // User
  serviceLocator.registerLazySingleton<DeleteAppUserUseCase>(
    () => DeleteAppUserUseCase(
      authenticationRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<EditAppUserUseCase>(
    () => EditAppUserUseCase(
      authenticationRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<SaveAppUserUseCase>(
    () => SaveAppUserUseCase(
      authenticationRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetAppUserUseCase>(
    () => GetAppUserUseCase(
      authenticationRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetAllAppUserUseCase>(
    () => GetAllAppUserUseCase(
      authenticationRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetAllAppUserPaginationUseCase>(
    () => GetAllAppUserPaginationUseCase(
      authenticationRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<DeleteAppUserUseCase>(
    () => DeleteAppUserUseCase(
      authenticationRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<DeleteAllAppUserUseCase>(
    () => DeleteAllAppUserUseCase(
      authenticationRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetIDAndTokenUserUseCase>(
    () => GetIDAndTokenUserUseCase(
      authenticationRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetOrSaveNewCurrentAppUserUseCase>(
    () => GetOrSaveNewCurrentAppUserUseCase(),
  );
  serviceLocator.registerLazySingleton<GetCurrentAppUserUseCase>(
    () => GetCurrentAppUserUseCase(
      authenticationRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<SaveAllAppUserUseCase>(
    () => SaveAllAppUserUseCase(
      authenticationRepository: serviceLocator(),
    ),
  );

  //Profile
  serviceLocator.registerLazySingleton<DeleteBusinessProfileUseCase>(
    () => DeleteBusinessProfileUseCase(
      userBusinessProfileRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<EditBusinessProfileUseCase>(
    () => EditBusinessProfileUseCase(
      userBusinessProfileRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<SaveBusinessProfileUseCase>(
    () => SaveBusinessProfileUseCase(
      userBusinessProfileRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<SaveAllBusinessProfileUseCase>(
    () => SaveAllBusinessProfileUseCase(
      userBusinessProfileRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetBusinessProfileUseCase>(
    () => GetBusinessProfileUseCase(
      userBusinessProfileRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetAllBusinessProfileUseCase>(
    () => GetAllBusinessProfileUseCase(
      userBusinessProfileRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetAllBusinessProfilePaginationUseCase>(
    () => GetAllBusinessProfilePaginationUseCase(
      userBusinessProfileRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<DeleteBusinessProfileUseCase>(
    () => DeleteBusinessProfileUseCase(
      userBusinessProfileRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<DeleteAllBusinessProfileUseCase>(
    () => DeleteAllBusinessProfileUseCase(
      userBusinessProfileRepository: serviceLocator(),
    ),
  );
  //Document
  serviceLocator.registerLazySingleton<SaveDocumentUseCase>(
    () => SaveDocumentUseCase(
      userBusinessDocumentRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<SaveAllDocumentUseCase>(
    () => SaveAllDocumentUseCase(
      userBusinessDocumentRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<EditDocumentUseCase>(
    () => EditDocumentUseCase(
      userBusinessDocumentRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetDocumentUseCase>(
    () => GetDocumentUseCase(
      userBusinessDocumentRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetAllDocumentUseCase>(
    () => GetAllDocumentUseCase(
      userBusinessDocumentRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetAllDocumentPaginationUseCase>(
    () => GetAllDocumentPaginationUseCase(
      userBusinessDocumentRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<DeleteDocumentUseCase>(
    () => DeleteDocumentUseCase(
      userBusinessDocumentRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<DeleteAllDocumentUseCase>(
    () => DeleteAllDocumentUseCase(
      userBusinessDocumentRepository: serviceLocator(),
    ),
  );
  //Payment Bank
  serviceLocator.registerLazySingleton<SavePaymentBankUseCase>(
    () => SavePaymentBankUseCase(
      userPaymentBankRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<SaveAllPaymentBankUseCase>(
    () => SaveAllPaymentBankUseCase(
      userPaymentBankRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<EditPaymentBankUseCase>(
    () => EditPaymentBankUseCase(
      userPaymentBankRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetPaymentBankUseCase>(
    () => GetPaymentBankUseCase(
      userPaymentBankRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetAllPaymentBankUseCase>(
    () => GetAllPaymentBankUseCase(
      userPaymentBankRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetAllPaymentBankPaginationUseCase>(
    () => GetAllPaymentBankPaginationUseCase(
      userPaymentBankRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<DeletePaymentBankUseCase>(
    () => DeletePaymentBankUseCase(
      userPaymentBankRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<DeleteAllPaymentBankUseCase>(
    () => DeleteAllPaymentBankUseCase(
      userPaymentBankRepository: serviceLocator(),
    ),
  );
  // Address
  //Payment Bank
  serviceLocator.registerLazySingleton<SaveAddressUseCase>(
    () => SaveAddressUseCase(
      userAddressRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<EditAddressUseCase>(
    () => EditAddressUseCase(
      userAddressRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetAddressUseCase>(
    () => GetAddressUseCase(
      userAddressRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetAllAddressUseCase>(
    () => GetAllAddressUseCase(
      userAddressRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetAllAddressPaginationUseCase>(
    () => GetAllAddressPaginationUseCase(
      userAddressRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<SaveAllAddressUseCase>(
    () => SaveAllAddressUseCase(
      userAddressRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<DeleteAddressUseCase>(
    () => DeleteAddressUseCase(
      userAddressRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<DeleteAllAddressUseCase>(
    () => DeleteAllAddressUseCase(
      userAddressRepository: serviceLocator(),
    ),
  );
  // Notification
  serviceLocator.registerLazySingleton<SaveNotificationUseCase>(
    () => SaveNotificationUseCase(
      userNotificationRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<EditNotificationUseCase>(
    () => EditNotificationUseCase(
      userNotificationRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetNotificationUseCase>(
    () => GetNotificationUseCase(
      userNotificationRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetAllNotificationUseCase>(
    () => GetAllNotificationUseCase(
      userNotificationRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<DeleteNotificationUseCase>(
    () => DeleteNotificationUseCase(
      userNotificationRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<DeleteAllNotificationUseCase>(
    () => DeleteAllNotificationUseCase(
      userNotificationRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<SaveAllNotificationUseCase>(
    () => SaveAllNotificationUseCase(
      userNotificationRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<EditAllNotificationUseCase>(
    () => EditAllNotificationUseCase(
      userNotificationRepository: serviceLocator(),
    ),
  );
  // Rate and Review
  serviceLocator.registerLazySingleton<SaveRateAndReviewUseCase>(
    () => SaveRateAndReviewUseCase(
      userRateAndReviewRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<EditRateAndReviewUseCase>(
    () => EditRateAndReviewUseCase(
      userRateAndReviewRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetRateAndReviewUseCase>(
    () => GetRateAndReviewUseCase(
      userRateAndReviewRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetAllRateAndReviewUseCase>(
    () => GetAllRateAndReviewUseCase(
      userRateAndReviewRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<DeleteRateAndReviewUseCase>(
    () => DeleteRateAndReviewUseCase(
      userRateAndReviewRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<DeleteAllRateAndReviewUseCase>(
    () => DeleteAllRateAndReviewUseCase(
      userRateAndReviewRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<SaveAllRateAndReviewUseCase>(
    () => SaveAllRateAndReviewUseCase(
      userRateAndReviewRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<EditAllRateAndReviewUseCase>(
    () => EditAllRateAndReviewUseCase(
      userRateAndReviewRepository: serviceLocator(),
    ),
  );
  // Order
  serviceLocator.registerLazySingleton<SaveOrderUseCase>(
    () => SaveOrderUseCase(
      orderRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<EditOrderUseCase>(
    () => EditOrderUseCase(
      orderRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetOrderUseCase>(
    () => GetOrderUseCase(
      orderRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetAllOrderUseCase>(
    () => GetAllOrderUseCase(
      orderRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetAllOnProcessOrderUseCase>(
    () => GetAllOnProcessOrderUseCase(
      orderRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetAllNewOrderUseCase>(
    () => GetAllNewOrderUseCase(
      orderRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetAllRecentOrderUseCase>(
    () => GetAllRecentOrderUseCase(
      orderRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetAllDeliverOrderUseCase>(
    () => GetAllDeliverOrderUseCase(
      orderRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetAllScheduleOrderUseCase>(
    () => GetAllScheduleOrderUseCase(
      orderRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetAllCancelOrderUseCase>(
    () => GetAllCancelOrderUseCase(
      orderRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<DeleteOrderUseCase>(
    () => DeleteOrderUseCase(
      oderRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<DeleteAllOrderUseCase>(
    () => DeleteAllOrderUseCase(
      orderRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<SaveAllOrderUseCase>(
    () => SaveAllOrderUseCase(
      orderRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<EditAllOrderUseCase>(
    () => EditAllOrderUseCase(
      orderRepository: serviceLocator(),
    ),
  );
  // Category
  serviceLocator.registerLazySingleton<GetAllCategoryUseCase>(
    () => GetAllCategoryUseCase(
      menuRepository: serviceLocator(),
    ),
  );
}

void _setUpRepository() {
  serviceLocator.registerSingleton<UserLocalDbRepository<AppUserEntity>>(
      UserLocalDbRepository<AppUserEntity>());
  serviceLocator.registerSingleton<AddonsLocalDbRepository<Addons>>(
      AddonsLocalDbRepository<Addons>());
  serviceLocator.registerSingleton<
      StoreOwnDeliveryPartnersLocalDbRepository<StoreOwnDeliveryPartnersInfo>>(
    StoreOwnDeliveryPartnersLocalDbRepository<StoreOwnDeliveryPartnersInfo>(),
  );
  serviceLocator.registerSingleton<StoreLocalDbRepository<StoreEntity>>(
      StoreLocalDbRepository<StoreEntity>());
  serviceLocator.registerSingleton<MenuLocalDbRepository<MenuEntity>>(
      MenuLocalDbRepository<MenuEntity>());
  // Category
  serviceLocator.registerSingleton<CategoryLocalDbRepository<Category>>(
      CategoryLocalDbRepository<Category>());

  // Store
  serviceLocator.registerSingleton<StoreDataSource>(StoreRemoteDataSource());
  // Store and Driver local data source
  serviceLocator.registerSingleton<
      StoreOwnDriverBindingWithStoreLocalDbRepository<
          StoreOwnDeliveryPartnersInfo, StoreEntity>>(
    StoreOwnDriverBindingWithStoreLocalDbRepository<
        StoreOwnDeliveryPartnersInfo, StoreEntity>(
      storeLocalDbRepository: serviceLocator(),
      storeOwnDriverLocalDbRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerSingleton<
      StoreOwnDriverBindingWithCurrentUserLocalDbRepository<
          StoreOwnDeliveryPartnersInfo, AppUserEntity>>(
    StoreOwnDriverBindingWithCurrentUserLocalDbRepository<
        StoreOwnDeliveryPartnersInfo, AppUserEntity>(
      storeOwnDriverLocalDbRepository: serviceLocator(),
      userLocalDbRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerSingleton<
      StoreBindingWithUserLocalDbRepository<StoreEntity, AppUserEntity>>(
    StoreBindingWithUserLocalDbRepository<StoreEntity, AppUserEntity>(
      userLocalDbRepository: serviceLocator(),
      storeLocalDbRepository: serviceLocator(),
    ),
  );
  // Menu and Addons local data source
  serviceLocator.registerSingleton<
      MenuBindingWithStoreLocalDbDbRepository<MenuEntity, StoreEntity>>(
    MenuBindingWithStoreLocalDbDbRepository<MenuEntity, StoreEntity>(
      menuLocalDbRepository: serviceLocator(),
      storeLocalDbRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerSingleton<
      MenuBindingWithCurrentUserLocalDbDbRepository<MenuEntity, AppUserEntity>>(
    MenuBindingWithCurrentUserLocalDbDbRepository<MenuEntity, AppUserEntity>(
      menuLocalDbRepository: serviceLocator(),
      userLocalDbRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerSingleton<
      AddonsBindingWithMenuLocalDbDbRepository<Addons, MenuEntity>>(
    AddonsBindingWithMenuLocalDbDbRepository<Addons, MenuEntity>(
      menuLocalDbRepository: serviceLocator(),
      addonsLocalDbRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerSingleton<
      AddonsBindingWithCurrentUserLocalDbDbRepository<Addons, AppUserEntity>>(
    AddonsBindingWithCurrentUserLocalDbDbRepository<Addons, AppUserEntity>(
      addonsLocalDbRepository: serviceLocator(),
      userLocalDbRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerSingleton<StoreRepository>(
    StoreRepositoryImplement(
      remoteDataSource: serviceLocator(),
      storeLocalDataSource:
          serviceLocator<StoreLocalDbRepository<StoreEntity>>(),
      driverLocalDataSource: serviceLocator<
          StoreOwnDeliveryPartnersLocalDbRepository<
              StoreOwnDeliveryPartnersInfo>>(),
      storeBindingWithUserLocalDataSource: serviceLocator(),
      storeOwnDriverBindingWithCurrentUserLocalDataSource: serviceLocator(),
      storeOwnDriverBindingWithStoreLocalDataSource: serviceLocator(),
    ),
  );
  // Menu

  serviceLocator.registerSingleton<MenuDataSource>(MenuRemoteDataSource());
  serviceLocator.registerSingleton<MenuRepository>(
    MenuRepositoryImplement(
      remoteDataSource: serviceLocator(),
      menuLocalDataSource: serviceLocator(),
      addonsLocalDataSource: serviceLocator(),
      menuBindingWithStoreLocalDataSource: serviceLocator(),
      menuBindingWithCurrentUserLocalDataSource: serviceLocator(),
      addonsBindingWithMenuLocalDataSource: serviceLocator(),
      addonsBindingWithCurrentUserLocalDataSource: serviceLocator(),
      categoryLocalDbRepository: serviceLocator(),
    ),
  );
  // User
  // local db
  serviceLocator.registerSingleton<UserLocalDbRepository<AppUserEntity>>(
      UserLocalDbRepository<AppUserEntity>());
  serviceLocator.registerSingleton<
          UserBusinessProfileLocalDbRepository<BusinessProfileEntity>>(
      UserBusinessProfileLocalDbRepository<BusinessProfileEntity>());
  serviceLocator.registerSingleton<
      UserBusinessDocumentLocalDbRepository<NewBusinessDocumentEntity>>(
    UserBusinessDocumentLocalDbRepository<NewBusinessDocumentEntity>(),
  );
  serviceLocator
      .registerSingleton<UserPaymentBankLocalDbRepository<PaymentBankEntity>>(
          UserPaymentBankLocalDbRepository<PaymentBankEntity>());
  // remote
  serviceLocator
      .registerSingleton<ProfileDataSource>(ProfileRemoteDataSource());
  //repository UserPaymentBankRepository
  serviceLocator.registerSingleton<UserPaymentBankRepository>(
    PaymentBankRepositoryImplement(
      remoteDataSource: serviceLocator(),
      paymentBankLocalDataSource: serviceLocator(),
    ),
  );
  //repository UserBusinessProfileRepository
  serviceLocator.registerSingleton<UserBusinessProfileRepository>(
    BusinessProfileRepositoryImplement(
      remoteDataSource: serviceLocator(),
      businessProfileLocalDataSource: serviceLocator(),
    ),
  );
  //repository UserBusinessDocumentRepository
  serviceLocator.registerSingleton<UserBusinessDocumentRepository>(
    BusinessDocumentRepositoryImplement(
      remoteDataSource: serviceLocator(),
      businessDocumentLocalDataSource: serviceLocator(),
    ),
  );
  /*serviceLocator.registerSingleton<MenuRepository>(
    MenuRepositoryImplement(
      remoteDataSource: serviceLocator(),
      menuLocalDataSource: serviceLocator(),
      addonsLocalDataSource: serviceLocator(),
      addonsBindingWithCurrentUserLocalDataSource: serviceLocator(),
      addonsBindingWithMenuLocalDataSource: serviceLocator(),
      menuBindingWithCurrentUserLocalDataSource: serviceLocator(),
      menuBindingWithStoreLocalDataSource: serviceLocator(),
      categoryLocalDbRepository: serviceLocator(),
    ),
  );*/
  // repository
  serviceLocator.registerSingleton<AddressLocalDbRepository<AddressModel>>(
      AddressLocalDbRepository<AddressModel>());
  // remote
  serviceLocator
      .registerSingleton<AddressDataSource>(AddressRemoteDataSource());
  //repository UserPaymentBankRepository
  serviceLocator.registerSingleton<UserAddressRepository>(
    AddressRepositoryImplement(
      remoteDataSource: serviceLocator(),
      addressLocalDataSource: serviceLocator(),
    ),
  );
  // Bindings Menu
  serviceLocator.registerSingleton<
      MenuBindingWithStoreLocalDbDbRepository<MenuEntity, StoreEntity>>(
    MenuBindingWithStoreLocalDbDbRepository<MenuEntity, StoreEntity>(
      menuLocalDbRepository: serviceLocator(),
      storeLocalDbRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerSingleton<
      MenuBindingWithCurrentUserLocalDbDbRepository<MenuEntity, AppUserEntity>>(
    MenuBindingWithCurrentUserLocalDbDbRepository(
      menuLocalDbRepository: serviceLocator(),
      userLocalDbRepository: serviceLocator(),
    ),
  );

  //Binding Addons
  serviceLocator.registerSingleton<
      AddonsBindingWithMenuLocalDbDbRepository<Addons, MenuEntity>>(
    AddonsBindingWithMenuLocalDbDbRepository<Addons, MenuEntity>(
      menuLocalDbRepository: serviceLocator(),
      addonsLocalDbRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerSingleton<
      AddonsBindingWithCurrentUserLocalDbDbRepository<Addons, AppUserEntity>>(
    AddonsBindingWithCurrentUserLocalDbDbRepository<Addons, AppUserEntity>(
      addonsLocalDbRepository: serviceLocator(),
      userLocalDbRepository: serviceLocator(),
    ),
  );

  // Binding Drivers
  serviceLocator.registerSingleton<
      StoreOwnDriverBindingWithStoreLocalDbRepository<
          StoreOwnDeliveryPartnersInfo, StoreEntity>>(
    StoreOwnDriverBindingWithStoreLocalDbRepository<
        StoreOwnDeliveryPartnersInfo, StoreEntity>(
      storeOwnDriverLocalDbRepository: serviceLocator(),
      storeLocalDbRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerSingleton<
      StoreOwnDriverBindingWithCurrentUserLocalDbRepository<
          StoreOwnDeliveryPartnersInfo, AppUserEntity>>(
    StoreOwnDriverBindingWithCurrentUserLocalDbRepository<
        StoreOwnDeliveryPartnersInfo, AppUserEntity>(
      storeOwnDriverLocalDbRepository: serviceLocator(),
      userLocalDbRepository: serviceLocator(),
    ),
  );

  // Binding Store
  serviceLocator.registerSingleton<
      StoreBindingWithUserLocalDbRepository<StoreEntity, AppUserEntity>>(
    StoreBindingWithUserLocalDbRepository<StoreEntity, AppUserEntity>(
      storeLocalDbRepository: serviceLocator(),
      userLocalDbRepository: serviceLocator(),
    ),
  );

  // Notification
  serviceLocator
      .registerSingleton<NotificationLocalDbRepository<NotificationEntity>>(
          NotificationLocalDbRepository<NotificationEntity>());
  // remote
  serviceLocator.registerSingleton<NotificationDataSource>(
      NotificationRemoteDataSource());
  //repository UserPaymentBankRepository
  serviceLocator.registerSingleton<NotificationRepository>(
    NotificationRepositoryImplement(
      remoteDataSource: serviceLocator(),
      notificationLocalDataSource: serviceLocator(),
    ),
  );
  // Rate and Review
  serviceLocator
      .registerSingleton<RateAndReviewLocalDbRepository<RateAndReviewEntity>>(
          RateAndReviewLocalDbRepository<RateAndReviewEntity>());
  // remote
  serviceLocator.registerSingleton<RateAndReviewDataSource>(
      RateAndReviewRemoteDataSource());
  //repository UserPaymentBankRepository
  serviceLocator.registerSingleton<RateAndReviewRepository>(
    RateAndReviewRepositoryImplement(
      remoteDataSource: serviceLocator(),
      notificationLocalDataSource: serviceLocator(),
    ),
  );

  // Order
  // Notification
  serviceLocator.registerSingleton<OrderLocalDbRepository<OrderEntity>>(
      OrderLocalDbRepository<OrderEntity>());
  // remote
  serviceLocator.registerSingleton<OrderDataSource>(OrderRemoteDataSource());
  //repository UserPaymentBankRepository
  serviceLocator.registerSingleton<OrderRepository>(
    OrderRepositoryImplement(
      remoteDataSource: serviceLocator(),
      orderLocalDataSource: serviceLocator(),
    ),
  );
}

void _setUpStateManagement() {
  serviceLocator.registerFactory<ConnectivityBloc>(ConnectivityBloc.new);
  serviceLocator.registerFactory<PhoneFormFieldBloc>(PhoneFormFieldBloc.new);

  // PermissionBloc
  serviceLocator.registerFactory<PermissionBloc>(PermissionBloc.new);
  // Document Bloc
  serviceLocator
      .registerFactory<BusinessDocumentBloc>(() => BusinessDocumentBloc());
  // Bank Bloc
  serviceLocator.registerFactory<PaymentBankBloc>(() => PaymentBankBloc());
  //BusinessProfileBloc
  serviceLocator
      .registerFactory<BusinessProfileBloc>(() => BusinessProfileBloc());
  // Menu Bloc
  serviceLocator.registerFactory<MenuBloc>(() => MenuBloc());
  // Store Bloc
  serviceLocator.registerFactory<StoreBloc>(() => StoreBloc());
  // Address Bloc
  serviceLocator.registerFactory<AddressBloc>(() => AddressBloc());
  //WalletBloc
  serviceLocator.registerFactory<WalletBloc>(() => WalletBloc());
  serviceLocator.registerFactory<AllOrderBloc>(() => AllOrderBloc());
  serviceLocator.registerFactory<RecentOrderBloc>(() => RecentOrderBloc());
  serviceLocator.registerFactory<CancelOrderBloc>(() => CancelOrderBloc());
  serviceLocator.registerFactory<NewOrderBloc>(() => NewOrderBloc());
  serviceLocator.registerFactory<DeliverOrderBloc>(() => DeliverOrderBloc());
  serviceLocator.registerFactory<ScheduleOrderBloc>(() => ScheduleOrderBloc());
  serviceLocator
      .registerFactory<OnProcessOrderBloc>(() => OnProcessOrderBloc());
  serviceLocator.registerFactory<NewBusinessDocumentBloc>(
      () => NewBusinessDocumentBloc());
  serviceLocator.registerFactory<OrderAnalysisBloc>(() => OrderAnalysisBloc());
}

void _setupFirebase() {
  HomewayFirebase.register();
  //serviceLocator<Home>
}

void _registerAuthenticationFeature() {
  AuthenticationInjector().register();
}
