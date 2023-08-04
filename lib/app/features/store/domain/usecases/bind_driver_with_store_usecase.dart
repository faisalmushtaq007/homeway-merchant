part of 'package:homemakers_merchant/app/features/store/index.dart';

class BindDriverWithStoreUseCase extends UseCaseByID<StoreEntity, int, StoreEntity> {
  BindDriverWithStoreUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;
  @override
  Future<StoreEntity> call({required int id, StoreEntity? input}) async {
    throw UnimplementedError();
  }
}
