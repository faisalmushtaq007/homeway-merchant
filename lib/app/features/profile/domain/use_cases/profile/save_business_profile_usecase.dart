part of 'package:homemakers_merchant/app/features/profile/index.dart';

class SaveBusinessProfileUseCase extends UseCaseIO<BusinessProfileEntity,
    DataSourceState<BusinessProfileEntity>> {
  SaveBusinessProfileUseCase({
    required this.userBusinessProfileRepository,
  });
  final UserBusinessProfileRepository userBusinessProfileRepository;
  @override
  Future<DataSourceState<BusinessProfileEntity>> call(
      BusinessProfileEntity input) async {
    return userBusinessProfileRepository.saveBusinessProfile(
        businessProfileEntity: input);
  }
}
