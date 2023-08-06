part of 'package:homemakers_merchant/app/features/store/index.dart';

class EditStoreUseCase extends UseCaseByIDAndEntity<StoreEntity, int, DataSourceState<StoreEntity>> {
  EditStoreUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;

  @override
  Future<DataSourceState<StoreEntity>> call({required StoreEntity input, required int id}) async {
    return storeRepository.editStore(storeEntity: input, storeID: id);
  }
}
