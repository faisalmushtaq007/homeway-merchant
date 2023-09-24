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

  Future<DataSourceState<List<MenuEntity>>> getAllMenu({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  });
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

  Future<DataSourceState<List<Addons>>> getAllAddons({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  });

  Future<DataSourceState<List<MenuEntity>>> bindAddonsWithMenu(
      {required List<Addons> source, required List<MenuEntity> destination});

  Future<DataSourceState<List<MenuEntity>>> unBindAddonsWithMenu(
      {required List<Addons> source, required List<MenuEntity> destination});

  Future<DataSourceState<List<StoreEntity>>> bindMenuWithStores(
      {required List<MenuEntity> source,
      required List<StoreEntity> destination});

  Future<DataSourceState<List<StoreEntity>>> unBindMenuWithStores(
      {required List<MenuEntity> source,
      required List<StoreEntity> destination});

  // With User
  Future<DataSourceState<AppUserEntity>> bindAddonsWithUser(
      {required List<Addons> source, required AppUserEntity destination});

  Future<DataSourceState<AppUserEntity>> unBindAddonsWithUser({
    required List<Addons> source,
    required AppUserEntity destination,
  });

  Future<DataSourceState<AppUserEntity>> bindMenuWithUser(
      {required List<MenuEntity> source, required AppUserEntity destination});

  Future<DataSourceState<AppUserEntity>> unBindMenuWithUser({
    required List<MenuEntity> source,
    required AppUserEntity destination,
  });

  Future<DataSourceState<List<Category>>> getAllCategory({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    Category? category,
    Category? subCategory,
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  });
  Future<DataSourceState<List<Addons>>> getAllAddonsPagination({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    Addons? addonsEntity,
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  });
  Future<DataSourceState<List<MenuEntity>>> getAllMenuPagination({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    MenuEntity? menuEntity,
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  });

  Future<DataSourceState<List<Category>>> saveAllCategory({
    required List<Category> categories,
    bool hasUpdateAll = false,
  });
  Future<DataSourceState<List<MenuEntity>>> saveAllMenu({
    required List<MenuEntity> menuEntities,
    bool hasUpdateAll = false,
  });
  Future<DataSourceState<List<Addons>>> saveAllAddons({
    required List<Addons> addonsEntities,
    bool hasUpdateAll = false,
  });
}
