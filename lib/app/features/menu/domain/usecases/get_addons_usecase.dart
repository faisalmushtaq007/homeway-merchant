part of 'package:homemakers_merchant/app/features/menu/index.dart';

class GetAddonsUseCase extends UseCaseByID<Addons, int, DataSourceState<Addons>> {
  GetAddonsUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;
  @override
  Future<DataSourceState<Addons>> call({required int id, Addons? input}) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
