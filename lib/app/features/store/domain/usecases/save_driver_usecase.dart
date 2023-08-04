part of 'package:homemakers_merchant/app/features/store/index.dart';

class SaveDriverUseCase extends UseCaseIO<StoreOwnDeliveryPartnersInfo, StoreOwnDeliveryPartnersInfo> {
  SaveDriverUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;
  @override
  Future<StoreOwnDeliveryPartnersInfo> call(StoreOwnDeliveryPartnersInfo input) async {
    throw UnimplementedError();
  }
}
