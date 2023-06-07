import 'package:get_it/get_it.dart';
import 'package:homemakers_merchant/app/features/profile/data/local/data_sources/local_usermodel_service.dart';
import 'package:homemakers_merchant/app/features/profile/domain/entities/user_model.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/manager/user_model_storage_controller.dart';
import 'package:homemakers_merchant/config/permission/permission_controller.dart';
import 'package:homemakers_merchant/config/permission/permission_service.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/config/translation/language_service.dart';
import 'package:homemakers_merchant/config/translation/language_service_hive.dart';
import 'package:homemakers_merchant/config/translation/translate_api.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/interface/storage_interface.dart';
import 'package:homemakers_merchant/core/keys/app_key.dart';
import 'package:homemakers_merchant/core/network/http/base_response_error_model.dart';
import 'package:homemakers_merchant/core/network/http/interceptor/token/fresh_token_interceptor.dart';
import 'package:homemakers_merchant/core/service/connectivity_bloc/connectivity_bloc.dart';
import 'package:homemakers_merchant/core/service/connectivity_bloc/src/connectivity_bloc/connectivity_service.dart';
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
  await translateApi.init(
      sourceLanguage: GlobalApp.defaultSourceTranslateLanguage);
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
}
