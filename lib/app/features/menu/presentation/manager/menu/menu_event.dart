part of 'menu_bloc.dart';

abstract class MenuEvent with AppEquatable {}

// Menu
class SaveMenu extends MenuEvent {
  SaveMenu({required this.menuEntity, required this.hasNewMenu, this.currentIndex = -1});

  final MenuEntity menuEntity;
  final bool hasNewMenu;
  final int currentIndex;

  @override
  bool get cacheHash => true;

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
  bool get cacheHash => true;

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
  bool get cacheHash => true;

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
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        menuEntity,
        index,
        menuEntities,
        menuID,
      ];
}

class GetAllMenu extends MenuEvent {
  GetAllMenu();

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [];
}

class SelectAllMenu extends MenuEvent {
  SelectAllMenu({this.menuEntities = const []});
  final List<MenuEntity> menuEntities;
  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [menuEntities];
}

class AddAddonsOnMenu extends MenuEvent {
  @override
  bool get cacheHash => true;

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
  bool get cacheHash => true;

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
  bool get cacheHash => true;

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
  bool get cacheHash => true;

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
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        addonsEntity,
        index,
        addonsEntities,
        addonsID,
      ];
}

class GetAllAddons extends MenuEvent {
  GetAllAddons();

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [];
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
  bool get cacheHash => true;

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
  bool get cacheHash => true;

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
  bool get cacheHash => true;

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
    this.menuSelectionUseCase = MenuSelectionUseCase.none,
  });

  final List<MenuEntity> menuEntities;
  final bool hasNewMenu;
  final MenuEntity menuEntity;
  final MenuEntityStatus menuEntityStatus;
  final MenuFormStage menuFormStage;
  final MenuSelectionUseCase menuSelectionUseCase;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        menuEntities,
        hasNewMenu,
        menuEntity,
        menuFormStage,
        menuEntityStatus,
        menuSelectionUseCase,
      ];
}

class PullMenuEntityData extends MenuEvent {
  PullMenuEntityData({
    required this.menuEntity,
    this.menuEntities = const [],
    this.hasNewMenu = true,
    this.menuEntityStatus = MenuEntityStatus.none,
    this.menuFormStage = MenuFormStage.none,
    this.menuSelectionUseCase = MenuSelectionUseCase.none,
  });

  final List<MenuEntity> menuEntities;
  final bool hasNewMenu;
  final MenuEntity menuEntity;
  final MenuEntityStatus menuEntityStatus;
  final MenuFormStage menuFormStage;
  final MenuSelectionUseCase menuSelectionUseCase;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [menuEntities, hasNewMenu, menuEntity, menuFormStage, menuEntityStatus, menuSelectionUseCase];
}

class NavigateToStorePage extends MenuEvent {
  NavigateToStorePage({
    this.menuEntities = const [],
    this.listOfSelectedMenuEntities = const [],
  });
  final List<MenuEntity> menuEntities;
  final List<MenuEntity> listOfSelectedMenuEntities;
  @override
  bool get cacheHash => true;
  @override
  List<Object?> get hashParameters => [menuEntities, listOfSelectedMenuEntities];
}

class FetchAllStores extends MenuEvent {
  FetchAllStores({
    this.menuEntities = const [],
    this.listOfSelectedMenuEntities = const [],
  });
  final List<MenuEntity> menuEntities;
  final List<MenuEntity> listOfSelectedMenuEntities;
  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [menuEntities, listOfSelectedMenuEntities];
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
  bool get cacheHash => true;

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
