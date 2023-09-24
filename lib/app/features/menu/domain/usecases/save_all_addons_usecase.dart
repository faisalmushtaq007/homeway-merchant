part of 'package:homemakers_merchant/app/features/menu/index.dart';

class SaveAllAddonsUseCase
    extends UseCaseIO<List<Addons>, DataSourceState<List<Addons>>> {
  SaveAllAddonsUseCase({
    required this.menuRepository,
  });
  final MenuRepository menuRepository;
  @override
  Future<DataSourceState<List<Addons>>> call(List<Addons> input) async {
    return await menuRepository.saveAllAddons(
      addonsEntities: input,
      hasUpdateAll: false,
    );
  }
}
