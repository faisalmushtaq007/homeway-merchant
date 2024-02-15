part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class GetRefreshTokenUseCase
    extends UseCase<DataSourceState<String>> {
  GetRefreshTokenUseCase({
    required this.authenticationRepository,
  });

  final AuthenticationRepository authenticationRepository;

  @override
  Future<DataSourceState<String>> call() async {
    return authenticationRepository.getRefreshToken();
  }
}
