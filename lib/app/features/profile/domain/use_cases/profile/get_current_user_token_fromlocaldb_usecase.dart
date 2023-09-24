part of 'package:homemakers_merchant/app/features/profile/index.dart';

class GetCurrentUserTokenFromLocalDBUseCase
    extends UseCase<DataSourceState<AppUserEntity>> {
  GetCurrentUserTokenFromLocalDBUseCase({
    required this.userBusinessProfileRepository,
  });
  final UserBusinessProfileRepository userBusinessProfileRepository;
  @override
  Future<DataSourceState<AppUserEntity>> call() {
    // TODO(prasant): implement call
    throw UnimplementedError();
  }
}
