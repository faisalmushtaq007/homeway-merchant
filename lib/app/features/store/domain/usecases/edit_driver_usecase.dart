part of 'package:homemakers_merchant/app/features/store/index.dart';

class EditDriverUseCase extends UseCaseByIDAndEntity<StoreOwnDeliveryPartnersInfo, int, DataSourceState<StoreOwnDeliveryPartnersInfo>> {
  EditDriverUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;

  @override
  Future<DataSourceState<StoreOwnDeliveryPartnersInfo>> call({required StoreOwnDeliveryPartnersInfo input, required int id}) async {
    return storeRepository.editDriver(storeOwnDeliveryPartnersInfo: input, driverID: id);
  }
}
