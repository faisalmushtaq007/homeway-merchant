part of 'package:homemakers_merchant/app/features/menu/index.dart';

class SaveAddonsUseCase extends UseCaseIO<MenuEntity, MenuEntity> {
  SaveAddonsUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;
  @override
  Future<MenuEntity> call(MenuEntity input) async {
    throw UnimplementedError();
  }
}
