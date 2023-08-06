part of 'package:homemakers_merchant/app/features/menu/index.dart';

class EditMenuUseCase extends UseCaseByIDAndEntity<MenuEntity, int, DataSourceState<MenuEntity>> {
  EditMenuUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;

  @override
  Future<DataSourceState<MenuEntity>> call({required MenuEntity input, required int id}) async {
    return menuRepository.editMenu(menuEntity: input, menuID: id);
  }
}
