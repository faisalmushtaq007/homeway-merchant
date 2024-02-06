part of 'menu_bloc.dart';

abstract class MenuEvent with AppEquatable {}

// Menu
class SaveMenu extends MenuEvent {
  SaveMenu(
      {required this.menuEntity,
      required this.hasNewMenu,
      this.currentIndex = -1});

  final MenuEntity menuEntity;
  final bool hasNewMenu;
  final int currentIndex;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        menuEntity,
        hasNewMenu,
        currentIndex,
      ];
}

class RemoveByIDMenu extends MenuEvent {
  RemoveByIDMenu({
    this.menuEntity,
    this.index = -1,
    this.menuID = '',
    this.menuEntities = const [],
  });

  final MenuEntity? menuEntity;
  final int index;
  final List<MenuEntity> menuEntities;
  final String menuID;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        menuEntity,
        index,
        menuEntities,
        menuID,
      ];
}

class RemoveAllMenu extends MenuEvent {
  RemoveAllMenu({this.menuEntities = const []});

  final List<MenuEntity> menuEntities;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [menuEntities];
}

class GetByIDMenu extends MenuEvent {
  GetByIDMenu({
    this.menuEntity,
    this.index = -1,
    this.menuEntities = const [],
    this.menuID = '',
  });

  final MenuEntity? menuEntity;
  final int index;
  final List<MenuEntity> menuEntities;
  final String menuID;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        menuEntity,
        index,
        menuEntities,
        menuID,
      ];
}

class GetAllMenu extends MenuEvent {
  GetAllMenu({this.pageKey = 1, this.pageSize = 20, this.searchItem = ''});

  final int pageKey;
  final int pageSize;
  final String searchItem;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [pageKey, pageSize, searchItem];
}

class SelectAllMenu extends MenuEvent {
  SelectAllMenu({this.menuEntities = const []});
  final List<MenuEntity> menuEntities;
  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [menuEntities];
}

class AddAddonsOnMenu extends MenuEvent {
  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [];
}

// Addons
class SaveAddons extends MenuEvent {
  SaveAddons({
    required this.addonsEntity,
    this.hasNewAddons = true,
    this.currentIndex = -1,
    this.haveOwnAddons = true,
  });

  final Addons addonsEntity;
  final bool hasNewAddons;
  final int currentIndex;
  final bool haveOwnAddons;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        hasNewAddons,
        addonsEntity,
        currentIndex,
        haveOwnAddons,
      ];
}

class RemoveByIDAddons extends MenuEvent {
  RemoveByIDAddons({
    this.addonsEntity,
    this.index = -1,
    this.addonsID = '',
    this.addonsEntities = const [],
  });

  final Addons? addonsEntity;
  final int index;
  final List<Addons> addonsEntities;
  final String addonsID;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        addonsEntity,
        index,
        addonsEntities,
        addonsID,
      ];
}

class RemoveAllAddons extends MenuEvent {
  RemoveAllAddons({this.addonsEntities = const []});

  final List<Addons> addonsEntities;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [addonsEntities];
}

class GetByIDAddons extends MenuEvent {
  GetByIDAddons({
    this.addonsEntity,
    this.index = -1,
    this.addonsEntities = const [],
    this.addonsID = '',
  });

  final Addons? addonsEntity;
  final int index;
  final List<Addons> addonsEntities;
  final String addonsID;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        addonsEntity,
        index,
        addonsEntities,
        addonsID,
      ];
}

class GetAllAddons extends MenuEvent {
  GetAllAddons({
    this.pageKey = 0,
    this.pageSize = 10,
    this.searchItem,
    this.endTimeStamp,
    this.filter,
    this.sorting,
    this.startTimeStamp,
  });
  final int pageKey;
  final int pageSize;
  final String? searchItem;
  final String? filter;
  final String? sorting;
  final Timestamp? startTimeStamp;
  final Timestamp? endTimeStamp;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        pageKey,
        pageSize,
        searchItem,
        endTimeStamp,
        filter,
        sorting,
        startTimeStamp,
      ];
}

class SelectAddons extends MenuEvent {
  SelectAddons({
    this.addonsEntity,
    this.index = -1,
    this.addonsEntities = const [],
    this.addonsID = -1,
    this.selectedAddonsEntities = const [],
  });

  final Addons? addonsEntity;
  final int index;
  final List<Addons> addonsEntities;
  final List<Addons> selectedAddonsEntities;
  final int addonsID;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        addonsEntity,
        index,
        addonsEntities,
        addonsID,
        selectedAddonsEntities,
      ];
}

class SelectAddonsMaxPortion extends MenuEvent {
  SelectAddonsMaxPortion({
    this.addonsEntities = const [],
    this.selectedAddonsEntities = const [],
    this.selectedMenuPortions = const [],
  });

  final List<Addons> addonsEntities;
  final List<Addons> selectedAddonsEntities;
  final List<MenuPortion> selectedMenuPortions;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        addonsEntities,
        selectedAddonsEntities,
        selectedMenuPortions,
      ];
}

class PopToMenuPage extends MenuEvent {
  PopToMenuPage({
    this.addonsEntity = const [],
    this.hasNewAddons = true,
  });

  final List<Addons> addonsEntity;
  final bool hasNewAddons;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        addonsEntity,
        hasNewAddons,
      ];
}

class PushMenuEntityData extends MenuEvent {
  PushMenuEntityData({
    required this.menuEntity,
    this.menuEntities = const [],
    this.hasNewMenu = true,
    this.menuEntityStatus = MenuEntityStatus.none,
    this.menuFormStage = MenuFormStage.none,
    this.menuStateStatus = MenuStateStatus.none,
  });

  final List<MenuEntity> menuEntities;
  final bool hasNewMenu;
  final MenuEntity menuEntity;
  final MenuEntityStatus menuEntityStatus;
  final MenuFormStage menuFormStage;
  final MenuStateStatus menuStateStatus;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        menuEntities,
        hasNewMenu,
        menuEntity,
        menuFormStage,
        menuEntityStatus,
        menuStateStatus,
      ];
}

class PullMenuEntityData extends MenuEvent {
  PullMenuEntityData({
    required this.menuEntity,
    this.menuEntities = const [],
    this.hasNewMenu = true,
    this.menuEntityStatus = MenuEntityStatus.none,
    this.menuFormStage = MenuFormStage.none,
    this.menuStateStatus = MenuStateStatus.none,
  });

  final List<MenuEntity> menuEntities;
  final bool hasNewMenu;
  final MenuEntity menuEntity;
  final MenuEntityStatus menuEntityStatus;
  final MenuFormStage menuFormStage;
  final MenuStateStatus menuStateStatus;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        menuEntities,
        hasNewMenu,
        menuEntity,
        menuFormStage,
        menuEntityStatus,
        menuStateStatus
      ];
}

class NavigateToStorePage extends MenuEvent {
  NavigateToStorePage({
    this.menuEntities = const [],
    this.listOfSelectedMenuEntities = const [],
  });
  final List<MenuEntity> menuEntities;
  final List<MenuEntity> listOfSelectedMenuEntities;
  @override
  bool get cacheHash => false;
  @override
  List<Object?> get hashParameters =>
      [menuEntities, listOfSelectedMenuEntities];
}

class FetchAllStores extends MenuEvent {
  FetchAllStores({
    this.menuEntities = const [],
    this.listOfSelectedMenuEntities = const [],
  });
  final List<MenuEntity> menuEntities;
  final List<MenuEntity> listOfSelectedMenuEntities;
  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters =>
      [menuEntities, listOfSelectedMenuEntities];
}

class BindMenuWithStores extends MenuEvent {
  BindMenuWithStores({
    this.menuEntities = const [],
    this.listOfSelectedMenuEntities = const [],
    this.storeEntities = const [],
    this.menuStateStatus = MenuStateStatus.none,
    this.message = '',
    this.bindMenuToStoreStage = BindMenuToStoreStage.none,
    this.listOfSelectedStoreEntities = const [],
  });

  final List<MenuEntity> menuEntities;
  final List<MenuEntity> listOfSelectedMenuEntities;
  final List<StoreEntity> storeEntities;
  final List<StoreEntity> listOfSelectedStoreEntities;
  final MenuStateStatus menuStateStatus;
  final String message;
  final BindMenuToStoreStage bindMenuToStoreStage;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        menuEntities,
        listOfSelectedMenuEntities,
        storeEntities,
        menuStateStatus,
        message,
        bindMenuToStoreStage,
        listOfSelectedStoreEntities,
      ];
}

class UnBindMenuWithStores extends MenuEvent {
  UnBindMenuWithStores({
    this.menuEntities = const [],
    this.listOfSelectedMenuEntities = const [],
    this.storeEntities = const [],
    this.menuStateStatus = MenuStateStatus.none,
    this.message = '',
    this.bindMenuToStoreStage = BindMenuToStoreStage.none,
    this.listOfSelectedStoreEntities = const [],
  });

  final List<MenuEntity> menuEntities;
  final List<MenuEntity> listOfSelectedMenuEntities;
  final List<StoreEntity> storeEntities;
  final List<StoreEntity> listOfSelectedStoreEntities;
  final MenuStateStatus menuStateStatus;
  final String message;
  final BindMenuToStoreStage bindMenuToStoreStage;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        menuEntities,
        listOfSelectedMenuEntities,
        storeEntities,
        menuStateStatus,
        message,
        bindMenuToStoreStage,
        listOfSelectedStoreEntities,
      ];
}

class BindMenuWithUser extends MenuEvent {
  BindMenuWithUser({
    this.menuEntities = const [],
    this.listOfSelectedMenuEntities = const [],
    this.menuStateStatus = MenuStateStatus.none,
    this.message = '',
    this.bindMenuToUserStage = BindMenuToUserStage.none,
  });

  final List<MenuEntity> menuEntities;
  final List<MenuEntity> listOfSelectedMenuEntities;
  final MenuStateStatus menuStateStatus;
  final String message;
  final BindMenuToUserStage bindMenuToUserStage;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        menuEntities,
        listOfSelectedMenuEntities,
        menuStateStatus,
        message,
        bindMenuToUserStage,
      ];
}

class BindAddonsWithMenu extends MenuEvent {
  BindAddonsWithMenu({
    this.menuEntities = const [],
    this.listOfSelectedMenuEntities = const [],
    this.addonsEntities = const [],
    this.menuStateStatus = MenuStateStatus.none,
    this.message = '',
    this.bindAddonsToMenuStage = BindAddonsToMenuStage.none,
    this.listOfSelectedAddonsEntities = const [],
  });

  final List<MenuEntity> menuEntities;
  final List<MenuEntity> listOfSelectedMenuEntities;
  final List<Addons> addonsEntities;
  final List<Addons> listOfSelectedAddonsEntities;
  final MenuStateStatus menuStateStatus;
  final String message;
  final BindAddonsToMenuStage bindAddonsToMenuStage;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        menuEntities,
        listOfSelectedMenuEntities,
        addonsEntities,
        menuStateStatus,
        message,
        bindAddonsToMenuStage,
        listOfSelectedAddonsEntities,
      ];
}

class BindAddonsWithUser extends MenuEvent {
  BindAddonsWithUser({
    this.menuEntities = const [],
    this.listOfSelectedMenuEntities = const [],
    this.menuStateStatus = MenuStateStatus.none,
    this.message = '',
    this.bindAddonsToUserStage = BindAddonsToUserStage.none,
  });

  final List<MenuEntity> menuEntities;
  final List<MenuEntity> listOfSelectedMenuEntities;
  final MenuStateStatus menuStateStatus;
  final String message;
  final BindAddonsToUserStage bindAddonsToUserStage;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        menuEntities,
        listOfSelectedMenuEntities,
        menuStateStatus,
        message,
        bindAddonsToUserStage,
      ];
}

class GetAllAddonsPagination extends MenuEvent {
  GetAllAddonsPagination({
    this.pageKey = 1,
    this.searchText,
    this.pageSize = 10,
    this.endTimeStamp,
    this.filter,
    this.sorting,
    this.startTimeStamp,
  });

  final int pageKey;
  final int pageSize;
  final String? searchText;
  final String? filter;
  final String? sorting;
  final Timestamp? startTimeStamp;
  final Timestamp? endTimeStamp;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        pageKey,
        searchText,
        pageSize,
        endTimeStamp,
        filter,
        sorting,
        startTimeStamp,
      ];
}

class GetAllMenuPagination extends MenuEvent {
  GetAllMenuPagination({
    this.pageKey = 1,
    this.searchText,
    this.pageSize = 10,
    this.endTimeStamp,
    this.filter,
    this.sorting,
    this.startTimeStamp,
  });

  final int pageKey;
  final int pageSize;
  final String? searchText;
  final String? filter;
  final String? sorting;
  final Timestamp? startTimeStamp;
  final Timestamp? endTimeStamp;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        pageKey,
        searchText,
        pageSize,
        endTimeStamp,
        filter,
        sorting,
        startTimeStamp,
      ];
}
