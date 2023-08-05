part of 'package:homemakers_merchant/app/features/store/index.dart';

class GetAllStoreUseCase extends UseCase<DataSourceState<List<StoreEntity>>> {
  GetAllStoreUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;
  @override
  Future<DataSourceState<List<StoreEntity>>> call() async {
    throw UnimplementedError();
  }
}
