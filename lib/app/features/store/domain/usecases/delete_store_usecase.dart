part of 'package:homemakers_merchant/app/features/store/index.dart';

class DeleteStoreUseCase extends UseCaseByID<StoreEntity, int, StoreEntity> {
  DeleteStoreUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;
  @override
  Future<StoreEntity> call({required int id, StoreEntity? input}) async {
    throw UnimplementedError();
  }
}
