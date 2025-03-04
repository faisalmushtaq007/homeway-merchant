part of 'package:homemakers_merchant/app/features/common/index.dart';

abstract interface class CommonRepository {
  Future<bool> deleteAllFromLocalDB();
  Future<AppUserEntity?> getCurrentUserProfileFromLocalDb();
  Future<String> getCurrentUserToken();
}
