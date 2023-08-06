part of 'package:homemakers_merchant/app/features/menu/index.dart';

class DeleteMenuUseCase extends UseCaseByID<MenuEntity, int, DataSourceState<bool>> {
  DeleteMenuUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;
  @override
  Future<DataSourceState<bool>> call({required int id, MenuEntity? input}) async {
    return menuRepository.deleteMenu(menuEntity: input, menuID: id);
  }
}
