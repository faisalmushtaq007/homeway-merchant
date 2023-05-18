import 'injection_container.dart';

class AppStartConfig {
  AppStartConfig._privateConstructor();

  static var shared = AppStartConfig._privateConstructor();

  Future<void> startApp() async {
    setupGetIt();
    return;
  }
}
