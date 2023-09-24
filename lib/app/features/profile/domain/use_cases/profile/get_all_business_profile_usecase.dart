part of 'package:homemakers_merchant/app/features/profile/index.dart';

class GetAllBusinessProfileUseCase
    extends UseCase<DataSourceState<List<BusinessProfileEntity>>> {
  GetAllBusinessProfileUseCase({
    required this.userBusinessProfileRepository,
  });
  final UserBusinessProfileRepository userBusinessProfileRepository;
  @override
  Future<DataSourceState<List<BusinessProfileEntity>>> call() async {
    return userBusinessProfileRepository.getAllBusinessProfile();
  }
}
