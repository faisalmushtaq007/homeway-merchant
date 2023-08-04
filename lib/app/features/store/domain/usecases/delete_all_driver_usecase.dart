part of 'package:homemakers_merchant/app/features/store/index.dart';

class DeleteAllDriverUseCase extends UseCase<bool> {
  DeleteAllDriverUseCase({
    required this.storeRepository,
  });
  final StoreRepository storeRepository;
  @override
  Future<bool> call() async {
    throw UnimplementedError();
  }
}
