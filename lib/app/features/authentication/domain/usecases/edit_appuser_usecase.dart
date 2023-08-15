part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class EditAppUserUseCase extends UseCaseByIDAndEntity<AppUserEntity, int, DataSourceState<AppUserEntity>> {
  EditAppUserUseCase({
    required this.authenticationRepository,
  });

  final AuthenticationRepository authenticationRepository;

  @override
  Future<DataSourceState<AppUserEntity>> call({required AppUserEntity input, required int id}) async {
    return authenticationRepository.editAppUser(appUserEntity: input, userID: id);
  }
}
