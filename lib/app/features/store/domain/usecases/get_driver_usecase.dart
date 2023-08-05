part of 'package:homemakers_merchant/app/features/store/index.dart';

class GetDriverUseCase extends UseCaseByID<StoreOwnDeliveryPartnersInfo, int, DataSourceState<StoreOwnDeliveryPartnersInfo>> {
  GetDriverUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;
  @override
  Future<DataSourceState<StoreOwnDeliveryPartnersInfo>> call({required int id, StoreOwnDeliveryPartnersInfo? input}) async {
    throw UnimplementedError();
  }
}
