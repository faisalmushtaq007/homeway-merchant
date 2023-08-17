part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class GetCurrentAppUserUseCase extends UseCaseOptionalIO<AppUserEntity, DataSourceState<AppUserEntity?>> {
  GetCurrentAppUserUseCase({
    required this.authenticationRepository,
  });

  final AuthenticationRepository authenticationRepository;

  @override
  Future<DataSourceState<AppUserEntity?>> call({AppUserEntity? input}) {
    return authenticationRepository.getCurrentAppUser(entity: input);
  }
}
