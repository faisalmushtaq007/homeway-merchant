part of 'package:homemakers_merchant/app/features/menu/index.dart';

class DeleteMenuUseCase extends UseCaseByID<MenuEntity, int, MenuEntity> {
  DeleteMenuUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;
  @override
  Future<MenuEntity> call({required int id, MenuEntity? input}) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
