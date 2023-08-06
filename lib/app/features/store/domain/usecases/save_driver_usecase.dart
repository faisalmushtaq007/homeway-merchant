part of 'package:homemakers_merchant/app/features/store/index.dart';

class SaveDriverUseCase extends UseCaseIO<StoreOwnDeliveryPartnersInfo, DataSourceState<StoreOwnDeliveryPartnersInfo>> {
  SaveDriverUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;
  @override
  Future<DataSourceState<StoreOwnDeliveryPartnersInfo>> call(StoreOwnDeliveryPartnersInfo input) async {
    return storeRepository.saveDriver(storeOwnDeliveryPartnersInfo: input);
  }
}
