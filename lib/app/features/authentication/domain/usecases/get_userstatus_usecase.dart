part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class GetUserStatusUseCase
    extends UseCase<DataSourceState<AuthenticationStatusModel>> {
  GetUserStatusUseCase({
    required this.authenticationRepository,
  });

  final AuthenticationRepository authenticationRepository;

  @override
  Future<DataSourceState<AuthenticationStatusModel>> call() async {
    return authenticationRepository.getCurrentUserStatus();
  }
}
