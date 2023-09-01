part of 'package:homemakers_merchant/app/features/profile/index.dart';

class GetCurrentUserProfileFromLocalDBUseCase extends UseCase<DataSourceState<AppUserEntity>> {
  GetCurrentUserProfileFromLocalDBUseCase({
    required this.userBusinessProfileRepository,
  });
  final UserBusinessProfileRepository userBusinessProfileRepository;
  @override
  Future<DataSourceState<AppUserEntity>> call() {
    // TODO(prasant): implement call
    throw UnimplementedError();
  }
}
