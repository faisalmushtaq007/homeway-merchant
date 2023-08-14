part of 'package:homemakers_merchant/app/features/store/index.dart';

class BindDriverWithStoreUseCase extends BindingUseCase<List<StoreOwnDeliveryPartnersInfo>, List<StoreEntity>, DataSourceState<List<StoreEntity>>> {
  BindDriverWithStoreUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;

  @override
  Future<DataSourceState<List<StoreEntity>>> call({required List<StoreOwnDeliveryPartnersInfo> source, required List<StoreEntity> destination}) async {
    return await storeRepository.bindDriverWithStores(source: source, destination: destination);
  }
}
