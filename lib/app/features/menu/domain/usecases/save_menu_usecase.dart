part of 'package:homemakers_merchant/app/features/menu/index.dart';

class SaveMenuUseCase extends UseCaseIO<MenuEntity, DataSourceState<MenuEntity>> {
  SaveMenuUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;
  @override
  Future<DataSourceState<MenuEntity>> call(MenuEntity input) async {
    return menuRepository.saveMenu(menuEntity: input);
  }
}
