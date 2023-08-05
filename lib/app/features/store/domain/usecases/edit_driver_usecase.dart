part of 'package:homemakers_merchant/app/features/store/index.dart';

class EditDriverUseCase extends UseCaseIO<StoreOwnDeliveryPartnersInfo, DataSourceState<StoreOwnDeliveryPartnersInfo>> {
  EditDriverUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;
  @override
  Future<DataSourceState<StoreOwnDeliveryPartnersInfo>> call(StoreOwnDeliveryPartnersInfo input) async {
    throw UnimplementedError();
  }
}
