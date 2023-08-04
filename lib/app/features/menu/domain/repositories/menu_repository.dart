part of 'package:homemakers_merchant/app/features/menu/index.dart';

abstract interface class MenuRepository {
  Future<ResultState<MenuEntity>> saveMenu({
    required MenuEntity menuEntity,
  });

  Future<ResultState<MenuEntity>> editMenu({
    required MenuEntity menuEntity,
  });

  Future<ResultState<bool>> deleteMenu({
    MenuEntity? menuEntity,
    required int menuID,
  });

  Future<ResultState<bool>> deleteAllMenu();

  Future<ResultState<MenuEntity>> getMenu({
    MenuEntity? menuEntity,
    required int menuID,
  });

  Future<ResultState<MenuEntity>> getAllMenu();
}
