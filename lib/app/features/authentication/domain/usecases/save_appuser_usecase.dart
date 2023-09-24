part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class SaveAppUserUseCase
    extends UseCaseIO<AppUserEntity, DataSourceState<AppUserEntity>> {
  SaveAppUserUseCase({
    required this.authenticationRepository,
  });

  final AuthenticationRepository authenticationRepository;

  @override
  Future<DataSourceState<AppUserEntity>> call(AppUserEntity input) async {
    return authenticationRepository.saveAppUser(appUserEntity: input);
  }
}
