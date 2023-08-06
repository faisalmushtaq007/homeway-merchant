part of 'package:homemakers_merchant/app/features/menu/index.dart';

class EditAddonsUseCase extends UseCaseByIDAndEntity<Addons, int, DataSourceState<Addons>> {
  EditAddonsUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;

  @override
  Future<DataSourceState<Addons>> call({required Addons input, required int id}) async {
    return menuRepository.editAddons(addons: input, addonsID: id);
  }
}
