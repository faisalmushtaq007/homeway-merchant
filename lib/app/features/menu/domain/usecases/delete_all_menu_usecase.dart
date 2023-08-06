part of 'package:homemakers_merchant/app/features/menu/index.dart';

class DeleteAllMenuUseCase extends UseCase<DataSourceState<bool>> {
  DeleteAllMenuUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;

  @override
  Future<DataSourceState<bool>> call() async {
    return menuRepository.deleteAllMenu();
  }
}
