part of 'package:homemakers_merchant/app/features/store/index.dart';

class DeleteAllStoreUseCase extends UseCase<bool> {
  DeleteAllStoreUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;
  @override
  Future<bool> call() async {
    throw UnimplementedError();
  }
}
