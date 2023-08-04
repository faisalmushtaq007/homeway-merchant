part of 'package:homemakers_merchant/app/features/store/index.dart';

class SaveStoreUseCase extends UseCaseIO<StoreEntity, StoreEntity> {
  SaveStoreUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;
  @override
  Future<StoreEntity> call(StoreEntity input) async {
    throw UnimplementedError();
  }
}
