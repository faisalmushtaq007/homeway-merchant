part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class GetAllAppUserUseCase
    extends UseCase<DataSourceState<List<AppUserEntity>>> {
  GetAllAppUserUseCase({
    required this.authenticationRepository,
  });

  final AuthenticationRepository authenticationRepository;
  @override
  Future<DataSourceState<List<AppUserEntity>>> call() async {
    return authenticationRepository.getAllAppUser();
  }
}
