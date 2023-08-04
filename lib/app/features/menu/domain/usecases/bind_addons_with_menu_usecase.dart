part of 'package:homemakers_merchant/app/features/menu/index.dart';

class BindAddonsWithMenuUseCase extends UseCaseIO<MenuEntity, MenuEntity> {
  BindAddonsWithMenuUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;
  @override
  Future<MenuEntity> call(MenuEntity input) async {
    throw UnimplementedError();
  }
}
