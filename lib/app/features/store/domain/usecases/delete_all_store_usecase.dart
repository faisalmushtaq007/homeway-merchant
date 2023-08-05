part of 'package:homemakers_merchant/app/features/store/index.dart';

class DeleteAllStoreUseCase extends UseCase<DataSourceState<bool>> {
  DeleteAllStoreUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;
  @override
  Future<DataSourceState<bool>> call() async {
    throw UnimplementedError();
  }
}
