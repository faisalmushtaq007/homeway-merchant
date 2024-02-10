part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuRemoteDataSource implements MenuDataSource {
  final client = serviceLocator<INetworkManager<BaseApiResponseErrorModel>>();

  @override
  Future<ApiResultState<bool>> deleteAllMenu() {
    // TODO(prasant): implement deleteAllMenu
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteMenu(
      {MenuEntity? menuEntity, required int menuID}) {
    // TODO(prasant): implement deleteMenu
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<MenuEntity>> editMenu({
    required MenuEntity menuEntity,
    required int menuID,
  }) {
    // TODO(prasant): implement editMenu
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<MenuEntity>>> getAllMenu({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  }) {
    // TODO(prasant): implement getAllMenu
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<MenuEntity>> getMenu(
      {MenuEntity? menuEntity, required int menuID}) {
    // TODO(prasant): implement getMenu
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<MenuEntity>> saveMenu(
      {required MenuEntity menuEntity}) {
    // TODO(prasant): implement saveMenu
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<MenuEntity>>> bindAddonsWithMenu(
      {required List<Addons> source, required List<MenuEntity> destination}) {
    // TODO(prasant): implement bindAddonsWithMenu
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<StoreEntity>>> bindMenuWithStores(
      {required List<MenuEntity> source,
      required List<StoreEntity> destination}) {
    // TODO(prasant): implement bindMenuWithStores
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteAddons(
      {required int addonsID, Addons? addons}) {
    // TODO(prasant): implement deleteAddons
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteAllAddons() {
    // TODO(prasant): implement deleteAllAddons
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<Addons>> editAddons(
      {required Addons addons, required int addonsID}) {
    // TODO(prasant): implement editAddons
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<Addons>> getAddons(
      {required int addonsID, Addons? addons}) {
    // TODO(prasant): implement getAddons
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<Addons>>> getAllAddons({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  }) {
    // TODO(prasant): implement getAllAddons
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<Addons>> saveAddons({required Addons addons}) {
    // TODO(prasant): implement saveAddons
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<MenuEntity>>> unBindAddonsWithMenu(
      {required List<Addons> source, required List<MenuEntity> destination}) {
    // TODO(prasant): implement unBindAddonsWithMenu
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<StoreEntity>>> unBindMenuWithStores(
      {required List<MenuEntity> source,
      required List<StoreEntity> destination}) {
    // TODO(prasant): implement unBindMenuWithStores
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<AppUserEntity>> bindAddonsWithUser(
      {required List<Addons> source, required AppUserEntity destination}) {
    // TODO: implement bindAddonsWithUser
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<AppUserEntity>> bindMenuWithUser(
      {required List<MenuEntity> source, required AppUserEntity destination}) {
    // TODO: implement bindMenuWithUser
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<AppUserEntity>> unBindAddonsWithUser(
      {required List<Addons> source, required AppUserEntity destination}) {
    // TODO: implement unBindAddonsWithUser
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<AppUserEntity>> unBindMenuWithUser(
      {required List<MenuEntity> source, required AppUserEntity destination}) {
    // TODO: implement unBindMenuWithUser
    throw UnimplementedError();
  }

  @override
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
  }) {
    // TODO: implement getAllCategory
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<Addons>>> saveAllAddons(
      {required List<Addons> addonsEntities, bool hasUpdateAll = false}) {
    // TODO: implement saveAllAddons
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<Category>>> saveAllCategory(
      {required List<Category> categories, bool hasUpdateAll = false}) {
    // TODO: implement saveAllCategory
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<MenuEntity>>> saveAllMenu(
      {required List<MenuEntity> menuEntities, bool hasUpdateAll = false}) {
    // TODO: implement saveAllMenu
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<Addons>>> getAllAddonsPagination(
      {int pageKey = 0,
      int pageSize = 10,
      String? searchText,
      Addons? addonsEntity,
      String? filtering,
      String? sorting,
      Timestamp? startTime,
      Timestamp? endTime}) {
    // TODO: implement getAllAddonsPagination
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<MenuEntity>>> getAllMenuPagination(
      {int pageKey = 0,
      int pageSize = 10,
      String? searchText,
      MenuEntity? menuEntity,
      String? filtering,
      String? sorting,
      Timestamp? startTime,
      Timestamp? endTime}) {
    // TODO: implement getAllMenuPagination
    throw UnimplementedError();
  }
}
