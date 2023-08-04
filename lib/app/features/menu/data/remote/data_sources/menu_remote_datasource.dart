part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuRemoteDataSource implements MenuDataSource {
  final client = serviceLocator<INetworkManager<BaseResponseErrorModel>>();

  @override
  Future<ApiResultState<bool>> deleteAllMenu() {
    // TODO: implement deleteAllMenu
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteMenu({MenuEntity? menuEntity, required int menuID}) {
    // TODO: implement deleteMenu
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<MenuEntity>> editMenu({required MenuEntity menuEntity}) {
    // TODO: implement editMenu
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<MenuEntity>> getAllMenu() {
    // TODO: implement getAllMenu
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<MenuEntity>> getMenu({MenuEntity? menuEntity, required int menuID}) {
    // TODO: implement getMenu
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<MenuEntity>> saveMenu({required MenuEntity menuEntity}) {
    // TODO: implement saveMenu
    throw UnimplementedError();
  }
}
