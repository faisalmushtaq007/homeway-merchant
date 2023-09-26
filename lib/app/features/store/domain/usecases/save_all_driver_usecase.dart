part of 'package:homemakers_merchant/app/features/store/index.dart';

class SaveAllDriverUseCase
    extends UseCaseIO<List<StoreOwnDeliveryPartnersInfo>, DataSourceState<List<StoreOwnDeliveryPartnersInfo>>> {
  SaveAllDriverUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;
  @override
  Future<DataSourceState<List<StoreOwnDeliveryPartnersInfo>>> call(List<StoreOwnDeliveryPartnersInfo> input) async {
    return await storeRepository.saveAllDriver(
      drivers: input,
      hasUpdateAll: false,
    );
  }
}
