part of 'package:homemakers_merchant/app/features/store/index.dart';

class BindDriverWithStoreUseCase
    extends BindingUseCase<List<StoreOwnDeliveryPartnersInfo>, List<StoreEntity>, DataSourceState<List<StoreOwnDeliveryPartnersInfo>>> {
  BindDriverWithStoreUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;

  @override
  Future<DataSourceState<List<StoreOwnDeliveryPartnersInfo>>> call(
      {required List<StoreOwnDeliveryPartnersInfo> source, required List<StoreEntity> destination}) async {
    // TODO(prasant): implement call
    throw UnimplementedError();
  }
}
