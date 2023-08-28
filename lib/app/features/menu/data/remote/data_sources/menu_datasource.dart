part of 'package:homemakers_merchant/app/features/menu/index.dart';

abstract interface class MenuDataSource {
  Future<ApiResultState<MenuEntity>> saveMenu({
    required MenuEntity menuEntity,
  });

  Future<ApiResultState<MenuEntity>> editMenu({
    required MenuEntity menuEntity,
    required int menuID,
  });

  Future<ApiResultState<bool>> deleteMenu({
    required int menuID,
    MenuEntity? menuEntity,
  });

  Future<ApiResultState<bool>> deleteAllMenu();

  Future<ApiResultState<MenuEntity>> getMenu({
    required int menuID,
    MenuEntity? menuEntity,
  });

  Future<ApiResultState<List<MenuEntity>>> getAllMenu({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  });
  // Addons

  Future<ApiResultState<Addons>> saveAddons({
    required Addons addons,
  });

  Future<ApiResultState<Addons>> editAddons({
    required Addons addons,
    required int addonsID,
  });

  Future<ApiResultState<bool>> deleteAddons({
    required int addonsID,
    Addons? addons,
  });

  Future<ApiResultState<bool>> deleteAllAddons();

  Future<ApiResultState<Addons>> getAddons({
    required int addonsID,
    Addons? addons,
  });

  Future<ApiResultState<List<Addons>>> getAllAddons({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  });

  Future<ApiResultState<List<MenuEntity>>> bindAddonsWithMenu({required List<Addons> source, required List<MenuEntity> destination});

  Future<ApiResultState<List<MenuEntity>>> unBindAddonsWithMenu({required List<Addons> source, required List<MenuEntity> destination});

  Future<ApiResultState<List<StoreEntity>>> bindMenuWithStores({required List<MenuEntity> source, required List<StoreEntity> destination});

  Future<ApiResultState<List<StoreEntity>>> unBindMenuWithStores({required List<MenuEntity> source, required List<StoreEntity> destination});

  Future<ApiResultState<AppUserEntity>> bindAddonsWithUser({required List<Addons> source, required AppUserEntity destination});

  Future<ApiResultState<AppUserEntity>> unBindAddonsWithUser({required List<Addons> source, required AppUserEntity destination});

  Future<ApiResultState<AppUserEntity>> bindMenuWithUser({required List<MenuEntity> source, required AppUserEntity destination});

  Future<ApiResultState<AppUserEntity>> unBindMenuWithUser({required List<MenuEntity> source, required AppUserEntity destination});

  Future<ApiResultState<List<Category>>> getAllCategory({
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
  Future<ApiResultState<List<Category>>> saveAllCategory({
    required List<Category> categories,
    bool hasUpdateAll = false,
  });
  Future<ApiResultState<List<MenuEntity>>> saveAllMenu({
    required List<MenuEntity> menuEntities,
    bool hasUpdateAll = false,
  });
  Future<ApiResultState<List<Addons>>> saveAllAddons({
    required List<Addons> addonsEntities,
    bool hasUpdateAll = false,
  });
}
