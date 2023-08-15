part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class DeleteAppUserUseCase extends UseCaseByID<AppUserEntity, int, DataSourceState<bool>> {
  DeleteAppUserUseCase({
    required this.authenticationRepository,
  });

  final AuthenticationRepository authenticationRepository;
  @override
  Future<DataSourceState<bool>> call({required int id, AppUserEntity? input}) async {
    return authenticationRepository.deleteAppUser(appUserEntity: input, userID: id);
  }
}
