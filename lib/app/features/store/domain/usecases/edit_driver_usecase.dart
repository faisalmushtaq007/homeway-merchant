part of 'package:homemakers_merchant/app/features/store/index.dart';

class EditDriverUseCase extends UseCaseByID<StoreOwnDeliveryPartnersInfo, int, DataSourceState<StoreOwnDeliveryPartnersInfo>> {
  EditDriverUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;

  @override
  Future<DataSourceState<StoreOwnDeliveryPartnersInfo>> call({required int id, StoreOwnDeliveryPartnersInfo? input}) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
