part of 'package:homemakers_merchant/app/features/menu/index.dart';

class SaveAddonsUseCase extends UseCaseIO<Addons, DataSourceState<Addons>> {
  SaveAddonsUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;
  @override
  Future<DataSourceState<Addons>> call(Addons input) async {
    throw UnimplementedError();
  }
}
