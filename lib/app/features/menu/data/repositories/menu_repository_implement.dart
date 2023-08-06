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
  Future<DataSourceState<bool>> deleteAllMenu() {
    // TODO: implement deleteAllMenu
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<bool>> deleteMenu({required int menuID, MenuEntity? menuEntity}) {
    // TODO: implement deleteMenu
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<MenuEntity>> editMenu({
    required MenuEntity menuEntity,
    required int menuID,
  }) {
    // TODO: implement editMenu
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<List<MenuEntity>>> getAllMenu() {
    // TODO: implement getAllMenu
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<MenuEntity>> getMenu({required int menuID, MenuEntity? menuEntity}) {
    // TODO: implement getMenu
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<MenuEntity>> saveMenu({required MenuEntity menuEntity}) {
    // TODO: implement saveMenu
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<List<MenuEntity>>> bindAddonsWithMenu({required List<Addons> source, required List<MenuEntity> destination}) {
    // TODO: implement bindAddonsWithMenu
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<List<StoreEntity>>> bindMenuWithStores({required List<MenuEntity> source, required List<StoreEntity> destination}) {
    // TODO: implement bindMenuWithStores
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<bool>> deleteAddons({required int addonsID, Addons? addons}) {
    // TODO: implement deleteAddons
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<bool>> deleteAllAddons() {
    // TODO: implement deleteAllAddons
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<Addons>> editAddons({
    required Addons addons,
    required int addonsID,
  }) {
    // TODO: implement editAddons
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<Addons>> getAddons({required int addonsID, Addons? addons}) {
    // TODO: implement getAddons
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<List<Addons>>> getAllAddons() {
    // TODO: implement getAllAddons
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<Addons>> saveAddons({required Addons addons}) {
    // TODO: implement saveAddons
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<List<MenuEntity>>> unBindAddonsWithMenu({required List<Addons> source, required List<MenuEntity> destination}) {
    // TODO: implement unBindAddonsWithMenu
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<List<StoreEntity>>> unBindMenuWithStores({required List<MenuEntity> source, required List<StoreEntity> destination}) {
    // TODO: implement unBindMenuWithStores
    throw UnimplementedError();
  }
}
