part of 'package:homemakers_merchant/app/features/menu/index.dart';

class GetAllAddonsUseCase extends UseCase<DataSourceState<List<Addons>>> {
  GetAllAddonsUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;
  @override
  Future<DataSourceState<List<Addons>>> call() async {
    throw UnimplementedError();
  }
}
