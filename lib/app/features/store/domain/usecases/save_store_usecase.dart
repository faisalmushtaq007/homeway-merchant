part of 'package:homemakers_merchant/app/features/store/index.dart';

class SaveStoreUseCase extends UseCaseIO<StoreEntity, DataSourceState<StoreEntity>> {
  SaveStoreUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;
  @override
  Future<DataSourceState<StoreEntity>> call(StoreEntity input) async {
    throw UnimplementedError();
  }
}
