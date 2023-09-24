part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class GetAppUserUseCase
    extends UseCaseByID<AppUserEntity, int, DataSourceState<AppUserEntity>> {
  GetAppUserUseCase({
    required this.authenticationRepository,
  });

  final AuthenticationRepository authenticationRepository;
  @override
  Future<DataSourceState<AppUserEntity>> call(
      {required int id, AppUserEntity? input}) async {
    return authenticationRepository.getAppUser(
        appUserEntity: input, userID: id);
  }
}
