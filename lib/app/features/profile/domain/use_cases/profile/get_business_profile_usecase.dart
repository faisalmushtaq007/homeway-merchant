part of 'package:homemakers_merchant/app/features/profile/index.dart';

class GetBusinessProfileUseCase extends UseCaseByID<BusinessProfileEntity, int,
    DataSourceState<BusinessProfileEntity>> {
  GetBusinessProfileUseCase({
    required this.userBusinessProfileRepository,
  });
  final UserBusinessProfileRepository userBusinessProfileRepository;
  @override
  Future<DataSourceState<BusinessProfileEntity>> call(
      {required int id, BusinessProfileEntity? input}) async {
    return userBusinessProfileRepository.getBusinessProfile(
        businessProfileEntity: input, businessProfileID: id);
  }
}
