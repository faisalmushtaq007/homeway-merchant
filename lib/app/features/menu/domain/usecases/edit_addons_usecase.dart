part of 'package:homemakers_merchant/app/features/menu/index.dart';

class EditAddonsUseCase extends UseCaseByID<MenuEntity, int, MenuEntity> {
  EditAddonsUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;
  @override
  Future<MenuEntity> call({required int id, MenuEntity? input}) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
