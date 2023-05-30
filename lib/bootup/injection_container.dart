import 'package:get_it/get_it.dart';
import 'package:homemakers_merchant/app/features/profile/data/local/data_sources/local_usermodel_service.dart';
import 'package:homemakers_merchant/app/features/profile/domain/entities/user_model.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/manager/user_model_storage_controller.dart';
import 'package:homemakers_merchant/config/permission/permission_controller.dart';
import 'package:homemakers_merchant/config/permission/permission_service.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/interface/storage_interface.dart';
import 'package:homemakers_merchant/core/network/http/base_response_error_model.dart';
import 'package:homemakers_merchant/core/network/http/interceptor/token/fresh_token_interceptor.dart';
import 'package:homemakers_merchant/core/service/connectivity_bloc/connectivity_bloc.dart';
import 'package:homemakers_merchant/core/service/connectivity_bloc/src/connectivity_bloc/connectivity_service.dart';
import 'package:network_manager/network_manager.dart';

GetIt serviceLocator = GetIt.instance;

void setupGetIt() {
  _setupGetIt();
  _setUpModel();
  _setUpAppSetting();
  _setUpService();
  _setUpRepository();
  _setUpStateManagement();
  return;
}

void _setupGetIt() {
  serviceLocator.allowReassignment = true;
}

void _setUpModel() {
  serviceLocator.registerSingleton<UserModel>(UserModel());
}

void _setUpAppSetting() {
  // Init permission service
  serviceLocator.registerSingleton<IPermissionService>(
    PermissionServiceHive('permission_box'),
  );
  serviceLocator<IPermissionService>().init();
  serviceLocator.registerSingleton<PermissionController>(
    PermissionController(serviceLocator()),
  );
  serviceLocator<PermissionController>().loadAll();
  // User Model service
  serviceLocator.registerSingleton<IStorageService>(
      LocalUserModelService('user_model_box'));
  serviceLocator<IStorageService>().init();
  serviceLocator.registerSingleton<UserModelStorageController>(
    UserModelStorageController(serviceLocator()),
  );
  serviceLocator<UserModelStorageController>().loadAll();
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
