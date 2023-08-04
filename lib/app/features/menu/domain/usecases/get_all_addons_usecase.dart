part of 'package:homemakers_merchant/app/features/menu/index.dart';

class GetAllAddonsUseCase extends UseCase<List<MenuEntity>> {
  GetAllAddonsUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;
  @override
  Future<List<MenuEntity>> call() async {
    throw UnimplementedError();
  }
}
