part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuRepositoryImplement implements MenuRepository {
  const MenuRepositoryImplement({
    required this.remoteDataSource,
    required this.menuLocalDataSource,
    required this.addonsLocalDataSource,
  });
  final MenuDataSource remoteDataSource;
  final MenuLocalDbRepository<MenuEntity> menuLocalDataSource;
  final AddonsLocalDbRepository<Addons> addonsLocalDataSource;

  @override
  Future<ResultState<bool>> deleteAllMenu() {
    // TODO: implement deleteAllMenu
    throw UnimplementedError();
  }

  @override
  Future<ResultState<bool>> deleteMenu({MenuEntity? menuEntity, required int menuID}) {
    // TODO: implement deleteMenu
    throw UnimplementedError();
  }

  @override
  Future<ResultState<MenuEntity>> editMenu({required MenuEntity menuEntity}) {
    // TODO: implement editMenu
    throw UnimplementedError();
  }

  @override
  Future<ResultState<MenuEntity>> getAllMenu() {
    // TODO: implement getAllMenu
    throw UnimplementedError();
  }

  @override
  Future<ResultState<MenuEntity>> getMenu({MenuEntity? menuEntity, required int menuID}) {
    // TODO: implement getMenu
    throw UnimplementedError();
  }

  @override
  Future<ResultState<MenuEntity>> saveMenu({required MenuEntity menuEntity}) {
    // TODO: implement saveMenu
    throw UnimplementedError();
  }
}
