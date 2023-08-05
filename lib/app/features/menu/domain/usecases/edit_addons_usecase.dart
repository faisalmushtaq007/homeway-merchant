part of 'package:homemakers_merchant/app/features/menu/index.dart';

class EditAddonsUseCase extends UseCaseByID<Addons, int, DataSourceState<Addons>> {
  EditAddonsUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;
  @override
  Future<DataSourceState<Addons>> call({required int id, Addons? input}) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
