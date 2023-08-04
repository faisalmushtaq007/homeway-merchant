part of 'package:homemakers_merchant/app/features/store/index.dart';

class GetAllStoreUseCase extends UseCase<List<StoreEntity>> {
  GetAllStoreUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;
  @override
  Future<List<StoreEntity>> call() async {
    throw UnimplementedError();
  }
}
