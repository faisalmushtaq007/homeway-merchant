part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class AuthenticationInjector extends BaseInjector {
  @override
  void registerUseCase() {
    serviceLocator.registerLazySingleton<SendOtpUseCase>(
      () => SendOtpUseCase(
        authenticationRepository: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<VerifyOtpUseCase>(
      () => VerifyOtpUseCase(
        authenticationRepository: serviceLocator(),
      ),
    );
  }

  @override
  void registerRepository() {
    serviceLocator.registerSingleton<AuthenticationRepository>(
      AuthenticationRepositoryImplement(
          remoteDataSource: serviceLocator(),
          userLocalDbRepository: serviceLocator()),
    );
  }

  @override
  void registerStateManagement() {
    // PhoneNumberVerificationBloc
    serviceLocator.registerFactory<PhoneNumberVerificationBloc>(
      () => PhoneNumberVerificationBloc(
        phoneFormFieldBloc: serviceLocator(),
        sendOtpUseCase: serviceLocator(),
      ),
    );

    // OtpVerificationBloc
    serviceLocator.registerFactory<OtpVerificationBloc>(
      () => OtpVerificationBloc(
        sendOtpUseCase: serviceLocator(),
        verifyOtpUseCase: serviceLocator(),
      ),
    );
  }

  @override
  void registerDataSource() {
    serviceLocator.registerSingleton<AuthenticationDataSource>(
        AuthenticationRemoteDataSource());
  }
}
