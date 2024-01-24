import 'package:get_it/get_it.dart';
import 'package:homeway_firebase/src/domain/repository/authentication_repository.dart';
import 'package:homeway_firebase/src/domain/repository/notification_repository.dart';

GetIt inject = GetIt.instance;

class HomewayFirebase {
  static Future<void> register() async {
    inject.allowReassignment = true;
    _registerRepository();
  }

  static void _registerRepository() {
    inject.registerLazySingleton<FirebaseAuthenticationRepository>(
      FirebaseAuthenticationRepositoryImpl.new,
    );
    inject.registerLazySingleton<FirebaseNotificationRepository>(
      FirebaseNotificationRepositoryImpl.new,
    );
  }
}
