part of 'package:homemakers_merchant/app/features/menu/index.dart';

class EditMenuUseCase extends UseCaseByID<MenuEntity, int, MenuEntity> {
  EditMenuUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;
  @override
  Future<MenuEntity> call({required int id, MenuEntity? input}) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
