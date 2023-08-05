part of 'package:homemakers_merchant/app/features/menu/index.dart';

abstract interface class MenuDataSource {
  Future<ApiResultState<MenuEntity>> saveMenu({
    required MenuEntity menuEntity,
  });

  Future<ApiResultState<MenuEntity>> editMenu({
    required MenuEntity menuEntity,
  });

  Future<ApiResultState<bool>> deleteMenu({
    MenuEntity? menuEntity,
    required int menuID,
  });

  Future<ApiResultState<bool>> deleteAllMenu();

  Future<ApiResultState<MenuEntity>> getMenu({
    MenuEntity? menuEntity,
    required int menuID,
  });

  Future<ApiResultState<MenuEntity>> getAllMenu();
}
