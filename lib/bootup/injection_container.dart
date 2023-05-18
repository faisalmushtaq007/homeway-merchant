import 'package:get_it/get_it.dart';
import 'package:homemakers_merchant/app/shared/service/connectivity_bloc/connectivity_bloc.dart';
import 'package:homemakers_merchant/app/shared/service/connectivity_bloc/src/connectivity_bloc/connectivity_service.dart';

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
  serviceLocator.registerSingleton<ConnectivityService>(ConnectivityService())
    ..initConnectivityService();
}

void _setUpRepository() {}

void _setUpStateManagement() {
  serviceLocator.registerFactory<ConnectivityBloc>(ConnectivityBloc.new);
}
