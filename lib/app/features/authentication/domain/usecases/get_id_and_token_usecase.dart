part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class GetIDAndTokenUserUseCase extends UseCase<AppUserEntity?> {
  GetIDAndTokenUserUseCase({
    required this.authenticationRepository,
  });

  final AuthenticationRepository authenticationRepository;

  @override
  Future<AppUserEntity?> call() async {
    AppUserEntity? appUserEntity;
    final result = await authenticationRepository.getCurrentAppUser();
    result.when(
      remote: (data, meta) {
        appLog.d('GetIDAndTokenUserUseCase remote ${data?.toMap()}');
        appUserEntity = data;
      },
      localDb: (data, meta) {
        appLog.d('GetIDAndTokenUserUseCase local ${data?.toMap()}');
        appUserEntity = data;
      },
      error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
        appLog.d('GetIDAndTokenUserUseCase exception $error');
      },
    );
    return appUserEntity;
  }
}
