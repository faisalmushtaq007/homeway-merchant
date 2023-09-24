part of 'package:homemakers_merchant/app/features/profile/index.dart';

class SaveAllBusinessProfileUseCase extends UseCaseIO<
    List<BusinessProfileEntity>, DataSourceState<List<BusinessProfileEntity>>> {
  SaveAllBusinessProfileUseCase({
    required this.userBusinessProfileRepository,
  });
  final UserBusinessProfileRepository userBusinessProfileRepository;
  @override
  Future<DataSourceState<List<BusinessProfileEntity>>> call(
      List<BusinessProfileEntity> input) async {
    return await userBusinessProfileRepository.saveAllBusinessProfiles(
      businessProfiles: input,
      hasUpdateAll: false,
    );
  }
}
