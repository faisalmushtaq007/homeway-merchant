import 'package:get_it/get_it.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/manager/otp_verification/otp_verification_bloc.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/manager/phone_number_verification_bloc.dart';
import 'package:homemakers_merchant/app/features/permission/presentation/bloc/permission_bloc.dart';
import 'package:homemakers_merchant/app/features/profile/data/local/data_sources/local_usermodel_service.dart';
import 'package:homemakers_merchant/app/features/profile/domain/entities/user_model.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/manager/user_model_storage_controller.dart';
import 'package:homemakers_merchant/config/permission/permission_controller.dart';
import 'package:homemakers_merchant/config/permission/permission_service.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/config/translation/language_service.dart';
import 'package:homemakers_merchant/config/translation/language_service_hive.dart';
import 'package:homemakers_merchant/config/translation/multiple_language_download.dart';
import 'package:homemakers_merchant/config/translation/translate_api.dart';
import 'package:homemakers_merchant/config/translation/app_translator.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/interface/storage_interface.dart';
import 'package:homemakers_merchant/core/keys/app_key.dart';
import 'package:homemakers_merchant/core/network/http/base_response_error_model.dart';
import 'package:homemakers_merchant/core/network/http/interceptor/token/fresh_token_interceptor.dart';
import 'package:homemakers_merchant/core/service/connectivity_bloc/connectivity_bloc.dart';
import 'package:homemakers_merchant/core/service/connectivity_bloc/src/connectivity_bloc/connectivity_service.dart';
import 'package:homemakers_merchant/shared/widgets/universal/phone_number_text_field/phone_form_field_bloc.dart';
import 'package:homemakers_merchant/theme/theme_controller.dart';
import 'package:homemakers_merchant/theme/theme_service.dart';
import 'package:homemakers_merchant/theme/theme_service_hive.dart';
import 'package:isolate_manager/isolate_manager.dart';
import 'package:network_manager/network_manager.dart';

GetIt serviceLocator = GetIt.instance;

Future<void> setupGetIt() async {
  _setupGetIt();
  _setUpModel();
  await _setUpAppSetting();
  _setUpService();
  _setUpRepository();
  _setUpStateManagement();
  return;
}

void _setupGetIt() {
  serviceLocator.allowReassignment = true;
  serviceLocator.registerSingleton<AppKey>(AppKey());
}

void _setUpModel() {
  serviceLocator.registerSingleton<UserModel>(UserModel());
}

Future<void> _setUpAppSetting() async {
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

void _setUpService() {
  serviceLocator
      .registerSingleton<ConnectivityService>(ConnectivityService())
      .initConnectivityService();
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
    ..registerFactory<NetworkManager<BaseResponseErrorModel>>(
      () => NetworkManager(
        isEnableLogger: true,
        options: BaseOptions(
          baseUrl: GlobalApp.baseUrl,
        ),
        //This is optional.
        errorModel: BaseResponseErrorModel(),
        additionalInterceptors: [
          serviceLocator(),
        ],
      ),
    );
}

void _setUpRepository() {}

void _setUpStateManagement() {
  serviceLocator.registerFactory<ConnectivityBloc>(ConnectivityBloc.new);
  serviceLocator.registerFactory<PhoneFormFieldBloc>(PhoneFormFieldBloc.new);
  serviceLocator.registerFactory<PhoneNumberVerificationBloc>(
    () => PhoneNumberVerificationBloc(
      phoneFormFieldBloc: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<OtpVerificationBloc>(OtpVerificationBloc.new);
  serviceLocator.registerFactory<PermissionBloc>(PermissionBloc.new);
}
