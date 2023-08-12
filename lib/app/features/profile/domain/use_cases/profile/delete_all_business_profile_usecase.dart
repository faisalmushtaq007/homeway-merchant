part of 'package:homemakers_merchant/app/features/profile/index.dart';

class DeleteAllBusinessProfileUseCase extends UseCaseByID<BusinessProfileEntity, int, DataSourceState<bool>> {
  DeleteAllBusinessProfileUseCase({
    required this.userBusinessProfileRepository,
  });
  final UserBusinessProfileRepository userBusinessProfileRepository;
  @override
  Future<DataSourceState<bool>> call({required int id, BusinessProfileEntity? input}) async {
    return userBusinessProfileRepository.deleteAllBusinessProfile();
  }
}
