part of 'package:homemakers_merchant/app/features/menu/index.dart';

class DeleteAllAddonsUseCase extends UseCaseIO<StoreEntity, bool> {
  DeleteAllAddonsUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;

  @override
  Future<bool> call(StoreEntity input) async {
    throw UnimplementedError();
  }
}
