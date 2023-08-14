part of 'package:homemakers_merchant/app/features/store/index.dart';

class BindDriverWithUserUseCase extends BindingUseCase<List<StoreOwnDeliveryPartnersInfo>, AppUserEntity, DataSourceState<AppUserEntity>> {
  BindDriverWithUserUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;

  @override
  Future<DataSourceState<AppUserEntity>> call({required List<StoreOwnDeliveryPartnersInfo> source, required AppUserEntity destination}) async {
    return await storeRepository.bindDriverWithUser(source: source, destination: destination);
  }
}
