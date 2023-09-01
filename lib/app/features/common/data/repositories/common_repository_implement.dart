part of 'package:homemakers_merchant/app/features/common/index.dart';

class CommonRepositoryImplement implements CommonRepository {
  const CommonRepositoryImplement({
    required this.userBusinessProfileRepository,
    required this.storeRepository,
    required this.menuRepository,
    required this.orderRepository,
    required this.rateAndReviewRepository,
    required this.userPaymentBankRepository,
    required this.userBusinessDocumentRepository,
    required this.notificationRepository,
    required this.userAddressRepository,
    required this.userLocalDbRepository,
  });
  final UserBusinessProfileRepository userBusinessProfileRepository;
  final StoreRepository storeRepository;
  final MenuRepository menuRepository;
  final OrderRepository orderRepository;
  final RateAndReviewRepository rateAndReviewRepository;
  final UserPaymentBankRepository userPaymentBankRepository;
  final UserBusinessDocumentRepository userBusinessDocumentRepository;
  final NotificationRepository notificationRepository;
  final UserAddressRepository userAddressRepository;
  final UserLocalDbRepository<AppUserEntity> userLocalDbRepository;

  @override
  Future<bool> deleteAllFromLocalDB() {
    // TODO: implement deleteAllFromLocalDB
    throw UnimplementedError();
  }

  @override
  Future<AppUserEntity?> getCurrentUserProfileFromLocalDb() async {
    // Local DB
    final Either<RepositoryBaseFailure, AppUserEntity?> result = await userLocalDbRepository.getCurrentUser();
    // Return result
    return result.fold((l) {
      final RepositoryFailure failure = l as RepositoryFailure;
      appLog.d('Get getCurrentUserProfileFromLocalDb local error ${failure.message}');
      return null;
    }, (r) {
      appLog.d('Get getCurrentUserProfileFromLocalDb to local :');
      return r;
    });
  }

  @override
  Future<String> getCurrentUserToken() async {
    // Local DB
    final Either<RepositoryBaseFailure, AppUserEntity?> result = await userLocalDbRepository.getCurrentUser();
    // Return result
    return result.fold((l) {
      final RepositoryFailure failure = l as RepositoryFailure;
      appLog.d('Get getCurrentUserToken local error ${failure.message}');
      return '';
    }, (r) {
      appLog.d('Get getCurrentUserToken to local :');
      return r?.access_token ?? '';
    });
  }
}
