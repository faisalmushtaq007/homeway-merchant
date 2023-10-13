import 'package:get_it/get_it.dart';
import 'package:network_manager/src/connectivity_service.dart';

GetIt serviceLocator = GetIt.instance;

void setupGetIt() {
  _setUpService();
  return;
}

void _setUpService() {
  serviceLocator
      .registerSingleton<ConnectivityService>(ConnectivityService())
      .initConnectivityService();
}
