part of 'package:homemakers_merchant/app/features/profile/index.dart';

class EditBusinessProfileUseCase extends UseCaseByIDAndEntity<BusinessProfileEntity, int, DataSourceState<BusinessProfileEntity>> {
  EditBusinessProfileUseCase({
    required this.userBusinessProfileRepository,
  });
  final UserBusinessProfileRepository userBusinessProfileRepository;

  @override
  Future<DataSourceState<BusinessProfileEntity>> call({required BusinessProfileEntity input, required int id}) async {
    return userBusinessProfileRepository.editBusinessProfile(businessProfileEntity: input, businessProfileID: id);
  }
}
