part of 'package:homemakers_merchant/app/features/menu/index.dart';

class DeleteAllAddonsUseCase extends UseCase<DataSourceState<bool>> {
  DeleteAllAddonsUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;

  @override
  Future<DataSourceState<bool>> call() async {
    return menuRepository.deleteAllAddons();
  }
}
