part of 'package:homemakers_merchant/app/features/common/index.dart';

class CommonRepositoryImplement implements CommonRepository {
  const CommonRepositoryImplement({
    required this.userBusinessProfileRepository,
    required this.storeRepository,
    required this.menuRepository,
    required this.orderRepository,
    required this.rateAndReviewRepository,
    required this.userPaymentBankRepositor,
    required this.userBusinessDocumentRepository,
    required this.notificationRepository,
    required this.userAddressRepository,
  });
  final UserBusinessProfileRepository userBusinessProfileRepository;
  final StoreRepository storeRepository;
  final MenuRepository menuRepository;
  final OrderRepository orderRepository;
  final RateAndReviewRepository rateAndReviewRepository;
  final UserPaymentBankRepository userPaymentBankRepositor;
  final UserBusinessDocumentRepository userBusinessDocumentRepository;
  final NotificationRepository notificationRepository;
  final UserAddressRepository userAddressRepository;

  @override
  Future<bool> deleteAllFromLocalDB() {
    // TODO: implement deleteAllFromLocalDB
    throw UnimplementedError();
  }

  @override
  Future<AppUserEntity?> getCurrentUserProfile() {
    // TODO: implement getCurrentUserProfile
    throw UnimplementedError();
  }

  @override
  Future<String> getCurrentUserToken() {
    // TODO: implement getCurrentUserToken
    throw UnimplementedError();
  }
}
