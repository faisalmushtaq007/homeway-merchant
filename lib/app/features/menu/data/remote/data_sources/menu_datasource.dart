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

  Future<ApiResultState<List<MenuEntity>>> getAllMenu();
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

  Future<ApiResultState<List<Addons>>> getAllAddons();

  Future<ApiResultState<List<MenuEntity>>> bindAddonsWithMenu({required List<Addons> source, required List<MenuEntity> destination});

  Future<ApiResultState<List<MenuEntity>>> unBindAddonsWithMenu({required List<Addons> source, required List<MenuEntity> destination});

  Future<ApiResultState<List<StoreEntity>>> bindMenuWithStores({required List<MenuEntity> source, required List<StoreEntity> destination});

  Future<ApiResultState<List<StoreEntity>>> unBindMenuWithStores({required List<MenuEntity> source, required List<StoreEntity> destination});

  Future<ApiResultState<AppUserEntity>> bindAddonsWithUser({required List<Addons> source, required AppUserEntity destination});

  Future<ApiResultState<AppUserEntity>> unBindAddonsWithUser({required List<Addons> source, required AppUserEntity destination});

  Future<ApiResultState<AppUserEntity>> bindMenuWithUser({required List<MenuEntity> source, required AppUserEntity destination});

  Future<ApiResultState<AppUserEntity>> unBindMenuWithUser({required List<MenuEntity> source, required AppUserEntity destination});
}
