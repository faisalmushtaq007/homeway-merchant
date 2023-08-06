part of 'package:homemakers_merchant/app/features/menu/index.dart';

class GetAllMenuUseCase extends UseCase<DataSourceState<List<MenuEntity>>> {
  GetAllMenuUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;
  @override
  Future<DataSourceState<List<MenuEntity>>> call() async {
    return menuRepository.getAllMenu();
  }
}
