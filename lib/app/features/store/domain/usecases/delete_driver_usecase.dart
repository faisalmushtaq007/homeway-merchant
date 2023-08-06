part of 'package:homemakers_merchant/app/features/store/index.dart';

class DeleteDriverUseCase extends UseCaseByID<StoreOwnDeliveryPartnersInfo, int, DataSourceState<bool>> {
  DeleteDriverUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;
  @override
  Future<DataSourceState<bool>> call({required int id, StoreOwnDeliveryPartnersInfo? input}) async {
    return storeRepository.deleteDriver(storeOwnDeliveryPartnersInfo: input, driverID: id);
  }
}
