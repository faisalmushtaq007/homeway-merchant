part of 'package:homemakers_merchant/app/features/profile/index.dart';

class DeleteBusinessProfileUseCase extends UseCaseByID<BusinessProfileEntity, int, DataSourceState<bool>> {
  DeleteBusinessProfileUseCase({
    required this.userBusinessProfileRepository,
  });
  final UserBusinessProfileRepository userBusinessProfileRepository;
  @override
  Future<DataSourceState<bool>> call({required int id, BusinessProfileEntity? input}) async {
    return userBusinessProfileRepository.deleteBusinessProfile(businessProfileEntity: input, businessProfileID: id);
  }
}
