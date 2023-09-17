part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class SaveAllAppUserUseCase extends UseCaseIO<List<AppUserEntity>, DataSourceState<List<AppUserEntity>>> {
  SaveAllAppUserUseCase({
    required this.authenticationRepository,
  });
  final AuthenticationRepository authenticationRepository;
  @override
  Future<DataSourceState<List<AppUserEntity>>> call(List<AppUserEntity> input) async {
    return await authenticationRepository.saveAllUsers(
      appUsers: input,
      hasUpdateAll: false,
    );
  }
}
