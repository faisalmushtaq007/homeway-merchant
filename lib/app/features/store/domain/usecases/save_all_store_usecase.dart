part of 'package:homemakers_merchant/app/features/store/index.dart';

class SaveAllStoreUseCase
    extends UseCaseIO<List<StoreEntity>, DataSourceState<List<StoreEntity>>> {
  SaveAllStoreUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;
  @override
  Future<DataSourceState<List<StoreEntity>>> call(
      List<StoreEntity> input) async {
    return await storeRepository.saveAllStore(
      stores: input,
      hasUpdateAll: false,
    );
  }
}
