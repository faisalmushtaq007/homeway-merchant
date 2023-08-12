part of 'package:homemakers_merchant/app/features/profile/index.dart';

class DeleteAllBusinessProfileUseCase extends UseCase<DataSourceState<bool>> {
  DeleteAllBusinessProfileUseCase({
    required this.userBusinessProfileRepository,
  });
  final UserBusinessProfileRepository userBusinessProfileRepository;
  @override
  Future<DataSourceState<bool>> call() async {
    return userBusinessProfileRepository.deleteAllBusinessProfile();
  }
}
