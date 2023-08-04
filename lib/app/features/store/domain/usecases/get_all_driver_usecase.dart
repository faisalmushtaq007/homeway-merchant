part of 'package:homemakers_merchant/app/features/store/index.dart';

class GetAllDriverUseCase extends UseCase<List<StoreEntity>> {
  GetAllDriverUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;
  @override
  Future<List<StoreEntity>> call() async {
    throw UnimplementedError();
  }
}
