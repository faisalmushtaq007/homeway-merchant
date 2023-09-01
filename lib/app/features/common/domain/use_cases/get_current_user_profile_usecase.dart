part of 'package:homemakers_merchant/app/features/common/index.dart';

class GetCurrentUserProfile extends UseCase<AppUserEntity?> {
  GetCurrentUserProfile({
    required this.commonRepository,
  });
  final CommonRepository commonRepository;

  @override
  Future<AppUserEntity?> call() async {
    return await commonRepository.getCurrentUserProfileFromLocalDb();
  }
}
