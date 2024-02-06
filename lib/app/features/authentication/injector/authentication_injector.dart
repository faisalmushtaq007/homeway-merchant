part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class AuthenticationInjector {
  static void register() {
    _registerDataSource();
    _registerRepository();
    _registerUseCase();
  }

  static void _registerUseCase() {
    serviceLocator.registerLazySingleton<SendFirebaseOtpUseCase>(
      () => SendFirebaseOtpUseCase(
        firebaseAuthenticationRepository:
            serviceLocator<FirebaseAuthenticationRepository>(),
      ),
    );

    serviceLocator.registerLazySingleton<VerifyFirebaseOtpUseCase>(
      () => VerifyFirebaseOtpUseCase(
        firebaseAuthenticationRepository:
            serviceLocator<FirebaseAuthenticationRepository>(),
      ),
    );
  }

  static void _registerRepository() {}

  static void _registerDataSource() {}
}
