part of 'package:homemakers_merchant/app/features/menu/index.dart';

class BindAddonsWithMenuUseCase extends BindingUseCase<List<Addons>, List<MenuEntity>, DataSourceState<List<MenuEntity>>> {
  BindAddonsWithMenuUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;

  @override
  Future<DataSourceState<List<MenuEntity>>> call({required List<Addons> source, required List<MenuEntity> destination}) async {
    return menuRepository.bindAddonsWithMenu(source: source, destination: destination);
  }
}
