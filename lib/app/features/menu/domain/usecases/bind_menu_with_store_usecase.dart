part of 'package:homemakers_merchant/app/features/menu/index.dart';

class BindMenuWithStoreUseCase extends UseCaseIO<MenuEntity, MenuEntity> {
  BindMenuWithStoreUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;
  @override
  Future<MenuEntity> call(MenuEntity input) async {
    throw UnimplementedError();
  }
}
