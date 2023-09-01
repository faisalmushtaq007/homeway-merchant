part of 'package:homemakers_merchant/app/features/common/index.dart';

class GetCurrentUserTokenProfile extends UseCase<String> {
  GetCurrentUserTokenProfile({
    required this.commonRepository,
  });
  final CommonRepository commonRepository;

  @override
  Future<String> call() async {
    return await commonRepository.getCurrentUserToken();
  }
}
