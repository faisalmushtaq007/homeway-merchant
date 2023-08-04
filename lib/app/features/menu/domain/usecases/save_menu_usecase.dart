part of 'package:homemakers_merchant/app/features/menu/index.dart';

class SaveMenuUseCase extends UseCaseIO<MenuEntity, MenuEntity> {
  SaveMenuUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;
  @override
  Future<MenuEntity> call(MenuEntity input) async {
    throw UnimplementedError();
  }
}
