part of 'package:homemakers_merchant/app/features/menu/index.dart';

class DeleteAllMenuUseCase extends UseCaseIO<StoreEntity, bool> {
  DeleteAllMenuUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;

  @override
  Future<bool> call(StoreEntity input) async {
    throw UnimplementedError();
  }
}
