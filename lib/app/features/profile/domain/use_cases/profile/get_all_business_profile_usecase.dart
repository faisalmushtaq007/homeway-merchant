part of 'package:homemakers_merchant/app/features/profile/index.dart';

class GetAllBusinessProfileUseCase extends UseCaseByID<BusinessProfileEntity, int, DataSourceState<List<BusinessProfileEntity>>> {
  GetAllBusinessProfileUseCase({
    required this.userBusinessProfileRepository,
  });
  final UserBusinessProfileRepository userBusinessProfileRepository;
  @override
  Future<DataSourceState<List<BusinessProfileEntity>>> call({required int id, BusinessProfileEntity? input}) async {
    return userBusinessProfileRepository.getAllBusinessProfile();
  }
}
