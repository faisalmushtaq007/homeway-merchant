part of 'package:homemakers_merchant/app/features/store/index.dart';

class GetStoreUseCase extends UseCaseByID<StoreEntity, int, StoreEntity> {
  GetStoreUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;
  @override
  Future<StoreEntity> call({required int id, StoreEntity? input}) async {
    throw UnimplementedError();
  }
}
