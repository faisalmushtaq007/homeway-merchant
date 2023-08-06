part of 'package:homemakers_merchant/app/features/menu/index.dart';

abstract interface class MenuRepository {
  Future<DataSourceState<MenuEntity>> saveMenu({
    required MenuEntity menuEntity,
  });

  Future<DataSourceState<MenuEntity>> editMenu({
    required MenuEntity menuEntity,
    required int menuID,
  });

  Future<DataSourceState<bool>> deleteMenu({
    required int menuID,
    MenuEntity? menuEntity,
  });

  Future<DataSourceState<bool>> deleteAllMenu();

  Future<DataSourceState<MenuEntity>> getMenu({
    required int menuID,
    MenuEntity? menuEntity,
  });

  Future<DataSourceState<List<MenuEntity>>> getAllMenu();
  // Addons
  Future<DataSourceState<Addons>> saveAddons({
    required Addons addons,
  });

  Future<DataSourceState<Addons>> editAddons({
    required Addons addons,
    required int addonsID,
  });

  Future<DataSourceState<bool>> deleteAddons({
    required int addonsID,
    Addons? addons,
  });

  Future<DataSourceState<bool>> deleteAllAddons();

  Future<DataSourceState<Addons>> getAddons({
    required int addonsID,
    Addons? addons,
  });

  Future<DataSourceState<List<Addons>>> getAllAddons();

  Future<DataSourceState<List<MenuEntity>>> bindAddonsWithMenu({required List<Addons> source, required List<MenuEntity> destination});

  Future<DataSourceState<List<MenuEntity>>> unBindAddonsWithMenu({required List<Addons> source, required List<MenuEntity> destination});

  Future<DataSourceState<List<StoreEntity>>> bindMenuWithStores({required List<MenuEntity> source, required List<StoreEntity> destination});

  Future<DataSourceState<List<StoreEntity>>> unBindMenuWithStores({required List<MenuEntity> source, required List<StoreEntity> destination});
}
