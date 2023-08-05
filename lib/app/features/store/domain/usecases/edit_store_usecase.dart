part of 'package:homemakers_merchant/app/features/store/index.dart';

class EditStoreUseCase extends UseCaseByID<StoreEntity, int, DataSourceState<StoreEntity>> {
  EditStoreUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;

  @override
  Future<DataSourceState<StoreEntity>> call({required int id, StoreEntity? input}) async {
    return storeRepository.editStore(storeEntity: input!, storeID: id);
  }
}
