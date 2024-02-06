part of 'package:homemakers_merchant/app/features/store/index.dart';

class DeleteAllDriverUseCase extends UseCase<DataSourceState<bool>> {
  DeleteAllDriverUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;
  @override
  Future<DataSourceState<bool>> call() async {
    return storeRepository.deleteAllDriver();
  }
}
