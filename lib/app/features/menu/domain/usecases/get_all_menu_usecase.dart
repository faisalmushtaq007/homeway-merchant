part of 'package:homemakers_merchant/app/features/menu/index.dart';

class GetAllMenuUseCase extends UseCase<List<MenuEntity>> {
  GetAllMenuUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;
  @override
  Future<List<MenuEntity>> call() async {
    throw UnimplementedError();
  }
}
