part of 'package:homemakers_merchant/app/features/store/index.dart';

class EditDriverUseCase extends UseCaseIO<StoreEntity, StoreEntity> {
  EditDriverUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;
  @override
  Future<StoreEntity> call(StoreEntity input) async {
    throw UnimplementedError();
  }
}
