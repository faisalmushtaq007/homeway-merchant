part of 'package:homemakers_merchant/app/features/store/index.dart';

class GetAllDriverUseCase
    extends UseCase<DataSourceState<List<StoreOwnDeliveryPartnersInfo>>> {
  GetAllDriverUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;
  @override
  Future<DataSourceState<List<StoreOwnDeliveryPartnersInfo>>> call() async {
    return storeRepository.getAllDriver();
  }
}
