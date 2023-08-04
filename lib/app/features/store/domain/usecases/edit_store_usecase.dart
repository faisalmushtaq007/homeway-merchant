part of 'package:homemakers_merchant/app/features/store/index.dart';

class EditStoreUseCase extends UseCaseIO<StoreEntity, StoreEntity> {
  EditStoreUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;
  @override
  Future<StoreEntity> call(StoreEntity input) async {
    throw UnimplementedError();
  }
}
