part of 'package:homemakers_merchant/app/features/menu/index.dart';

class DeleteAddonsUseCase extends UseCaseByID<Addons, int, DataSourceState<bool>> {
  DeleteAddonsUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;
  @override
  Future<DataSourceState<bool>> call({required int id, Addons? input}) async {
    return menuRepository.deleteAddons(addons: input, addonsID: id);
  }
}
