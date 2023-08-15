part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class DeleteAllAppUserUseCase extends UseCase<DataSourceState<bool>> {
  DeleteAllAppUserUseCase({
    required this.authenticationRepository,
  });

  final AuthenticationRepository authenticationRepository;

  @override
  Future<DataSourceState<bool>> call() async {
    return authenticationRepository.deleteAllAppUser();
  }
}
