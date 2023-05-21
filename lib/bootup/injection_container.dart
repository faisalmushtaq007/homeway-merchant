import 'package:get_it/get_it.dart';
import 'package:homemakers_merchant/app/shared/const/app.dart';
import 'package:homemakers_merchant/app/shared/network/http/base_response_error_model.dart';
import 'package:homemakers_merchant/app/shared/network/http/base_response_model.dart';
import 'package:homemakers_merchant/app/shared/service/connectivity_bloc/connectivity_bloc.dart';
import 'package:homemakers_merchant/app/shared/service/connectivity_bloc/src/connectivity_bloc/connectivity_service.dart';
import 'package:network_manager/network_manager.dart';

GetIt serviceLocator = GetIt.instance;

void setupGetIt() {
  _setUpAppSetting();
  _setUpService();
  _setUpRepository();
  _setUpStateManagement();
  return;
}

void _setUpAppSetting() {}

void _setUpService() {
  serviceLocator
      .registerSingleton<ConnectivityService>(ConnectivityService())
      .initConnectivityService();

  serviceLocator.registerFactory<NetworkManager<BaseResponseErrorModel>>(
    () => NetworkManager(
      isEnableLogger: true,
      options: BaseOptions(
        baseUrl: GlobalApp.baseUrl,
      ),
      //This is optional.
      errorModel: BaseResponseErrorModel(),
      /*additionalInterceptors: [
        InterceptorToken(),
        //TempWikiInterceptorToken(),
        LogInterceptor(
          responseHeader: false,
          responseBody: true,
          requestBody: true,
          request: true,
          requestHeader: true,
        ),
      ], */
    ),
  );
}

void _setUpRepository() {}

void _setUpStateManagement() {
  serviceLocator.registerFactory<ConnectivityBloc>(ConnectivityBloc.new);
}
