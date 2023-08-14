part of 'package:homemakers_merchant/app/features/store/index.dart';

class BindStoreWithUserUseCase extends BindingUseCase<List<StoreOwnDeliveryPartnersInfo>, AppUserEntity, DataSourceState<AppUserEntity>> {
  BindStoreWithUserUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;

  @override
  Future<DataSourceState<AppUserEntity>> call({required List<StoreOwnDeliveryPartnersInfo> source, required AppUserEntity destination}) async {
    return await storeRepository.bindStoreWithUser(source: source, destination: destination);
  }
}
