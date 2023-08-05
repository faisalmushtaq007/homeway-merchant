part of 'package:homemakers_merchant/app/features/store/index.dart';

class BindDriverWithStoreUseCase
    extends BindingUseCase<List<StoreOwnDeliveryPartnersInfo>, List<StoreEntity>, DataSourceState<List<StoreOwnDeliveryPartnersInfo>>> {
  BindDriverWithStoreUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;

  @override
  Future<DataSourceState<List<StoreOwnDeliveryPartnersInfo>>> call(
      {required List<StoreOwnDeliveryPartnersInfo> source, required List<StoreEntity> destination}) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
