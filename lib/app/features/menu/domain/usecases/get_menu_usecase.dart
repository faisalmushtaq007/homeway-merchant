part of 'package:homemakers_merchant/app/features/menu/index.dart';

class GetMenuUseCase extends UseCaseByID<MenuEntity, int, DataSourceState<MenuEntity>> {
  GetMenuUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;
  @override
  Future<DataSourceState<MenuEntity>> call({required int id, MenuEntity? input}) async {
    return menuRepository.getMenu(menuEntity: input, menuID: id);
  }
}
