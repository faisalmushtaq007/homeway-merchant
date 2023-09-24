part of 'package:homemakers_merchant/app/features/menu/index.dart';

class SaveAllMenuUseCase
    extends UseCaseIO<List<MenuEntity>, DataSourceState<List<MenuEntity>>> {
  SaveAllMenuUseCase({
    required this.menuRepository,
  });
  final MenuRepository menuRepository;
  @override
  Future<DataSourceState<List<MenuEntity>>> call(List<MenuEntity> input) async {
    return await menuRepository.saveAllMenu(
      menuEntities: input,
      hasUpdateAll: false,
    );
  }
}
