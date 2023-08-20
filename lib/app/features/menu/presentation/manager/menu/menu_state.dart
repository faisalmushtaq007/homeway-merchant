part of 'menu_bloc.dart';

abstract class MenuState with AppEquatable {}

class MenuInitial extends MenuState {
  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [];
}

class SaveMenuState extends MenuState {
  SaveMenuState({
    required this.menuEntity,
    required this.hasNewMenu,
    this.menuStateStatus = MenuStateStatus.none,
    this.currentIndex = -1,
  });

  final MenuEntity menuEntity;
  final bool hasNewMenu;
  final MenuStateStatus menuStateStatus;
  final int currentIndex;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        menuEntity,
        hasNewMenu,
        menuStateStatus,
        currentIndex,
      ];
}

class MenuLoadingState extends MenuState {
  MenuLoadingState({
    required this.isLoading,
    required this.message,
    this.menuStateStatus = MenuStateStatus.loading,
  });

  final bool isLoading;
  final String message;
  final MenuStateStatus menuStateStatus;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        isLoading,
        message,
        menuStateStatus,
      ];
}

class MenuProcessingState extends MenuState {
  MenuProcessingState({
    required this.isProcessing,
    required this.message,
    this.menuStateStatus = MenuStateStatus.processing,
  });

  final bool isProcessing;
  final String message;
  final MenuStateStatus menuStateStatus;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        isProcessing,
        message,
        menuStateStatus,
      ];
}

class MenuFailedState extends MenuState {
  MenuFailedState({
    required this.message,
    this.menuStateStatus = MenuStateStatus.failed,
  });

  final String message;
  final MenuStateStatus menuStateStatus;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        message,
        menuStateStatus,
      ];
}

class MenuExceptionState extends MenuState {
  MenuExceptionState({
    required this.message,
    this.stackTrace,
    this.exception,
    this.menuStateStatus = MenuStateStatus.exception,
  });

  final String message;
  final StackTrace? stackTrace;
  final Exception? exception;
  final MenuStateStatus menuStateStatus;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [message, stackTrace, exception, menuStateStatus];
}

class DeleteMenuState extends MenuState {
  DeleteMenuState({
    this.menuEntity,
    this.index = -1,
    this.menuID = '',
    this.menuEntities = const [],
    this.hasDelete = false,
    this.message = '',
  });

  final MenuEntity? menuEntity;
  final int index;
  final List<MenuEntity> menuEntities;
  final String menuID;
  final bool hasDelete;
  final String message;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        menuEntity,
        index,
        menuEntities,
        menuID,
        hasDelete,
        message,
      ];
}

class DeleteAllMenuState extends MenuState {
  DeleteAllMenuState({
    this.menuEntities = const [],
    this.menuStateStatus = MenuStateStatus.none,
    this.message = '',
    this.hasDeleteAll = false,
  });

  final List<MenuEntity> menuEntities;
  final MenuStateStatus menuStateStatus;
  final bool hasDeleteAll;
  final String message;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        menuEntities,
        hasDeleteAll,
        menuStateStatus,
        message,
      ];
}

class GetAllMenuState extends MenuState {
  GetAllMenuState({
    this.menuEntities = const [],
    this.menuStateStatus = MenuStateStatus.none,
    this.message = '',
    this.searchItem = '',
    this.pageSize = 10,
    this.pageKey = 1,
  });

  final MenuStateStatus menuStateStatus;
  final List<MenuEntity> menuEntities;
  final String message;

  final int pageKey;
  final int pageSize;
  final String searchItem;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [menuEntities, menuStateStatus, pageKey, pageSize, searchItem];
}

class GetEmptyMenuState extends MenuState {
  GetEmptyMenuState({
    this.menuEntities = const [],
    this.message = '',
    this.menuStateStatus = MenuStateStatus.empty,
  });

  final List<MenuEntity> menuEntities;
  final String message;
  final MenuStateStatus menuStateStatus;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        menuEntities,
        message,
        menuStateStatus,
      ];
}

class GetMenuState extends MenuState {
  GetMenuState({
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

// Addons
class SaveAddonsState extends MenuState {
  SaveAddonsState({
    required this.addonsEntity,
    required this.hasNewAddons,
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
        addonsEntity,
        hasNewAddons,
        currentIndex,
        haveOwnAddons,
      ];
}

class AddonsLoadingState extends MenuState {
  AddonsLoadingState({
    required this.isLoading,
    required this.message,
    this.addonsSelectionUseCase = AddonsSelectionUseCase.loading,
  });

  final bool isLoading;
  final String message;
  final AddonsSelectionUseCase addonsSelectionUseCase;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        isLoading,
        message,
        addonsSelectionUseCase,
      ];
}

class AddonsProcessingState extends MenuState {
  AddonsProcessingState({
    required this.isProcessing,
    required this.message,
    this.addonsSelectionUseCase = AddonsSelectionUseCase.processing,
  });

  final bool isProcessing;
  final String message;
  final AddonsSelectionUseCase addonsSelectionUseCase;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        isProcessing,
        message,
        addonsSelectionUseCase,
      ];
}

class AddonsFailedState extends MenuState {
  AddonsFailedState({
    required this.message,
    this.addonsSelectionUseCase = AddonsSelectionUseCase.failed,
  });

  final String message;
  final AddonsSelectionUseCase addonsSelectionUseCase;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        message,
        addonsSelectionUseCase,
      ];
}

class AddonsExceptionState extends MenuState {
  AddonsExceptionState({
    required this.message,
    this.stackTrace,
    this.exception,
    this.addonsSelectionUseCase = AddonsSelectionUseCase.none,
  });

  final String message;
  final StackTrace? stackTrace;
  final Exception? exception;
  final AddonsSelectionUseCase addonsSelectionUseCase;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        message,
        stackTrace,
        exception,
        addonsSelectionUseCase,
      ];
}

class DeleteAddonsState extends MenuState {
  DeleteAddonsState({
    this.addonsEntity,
    this.index = -1,
    this.addonsID = '',
    this.addonsEntities = const [],
    this.message = '',
    this.hasDelete = false,
  });

  final Addons? addonsEntity;
  final int index;
  final List<Addons> addonsEntities;
  final String addonsID;
  final bool hasDelete;
  final String message;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        addonsEntity,
        index,
        addonsEntities,
        addonsID,
        hasDelete,
        message,
      ];
}

class DeleteAllAddonsState extends MenuState {
  DeleteAllAddonsState({
    this.addonsEntities = const [],
    this.addonsSelectionUseCase = AddonsSelectionUseCase.none,
    this.message = '',
    this.hasDeleteAll = false,
  });

  final List<Addons> addonsEntities;
  final AddonsSelectionUseCase addonsSelectionUseCase;
  final bool hasDeleteAll;
  final String message;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        addonsEntities,
        addonsSelectionUseCase,
        hasDeleteAll,
        message,
      ];
}

class GetAllAddonsState extends MenuState {
  GetAllAddonsState({
    this.addonsEntities = const [],
    this.searchItem = '',
    this.pageSize = 10,
    this.pageKey = 1,
  });

  final List<Addons> addonsEntities;
  final int pageKey;
  final int pageSize;
  final String searchItem;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        addonsEntities,
        pageKey,
        pageSize,
        searchItem,
      ];
}

class GetEmptyAddonsState extends MenuState {
  GetEmptyAddonsState({
    this.addonsEntities = const [],
    this.message = '',
    this.addonsSelectionUseCase = AddonsSelectionUseCase.emptyForAddons,
  });

  final List<Addons> addonsEntities;
  final String message;
  final AddonsSelectionUseCase addonsSelectionUseCase;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        addonsEntities,
        message,
        addonsSelectionUseCase,
      ];
}

class GetAddonsState extends MenuState {
  GetAddonsState({
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

class SelectAddonsState extends MenuState {
  SelectAddonsState({
    this.addonsEntity,
    this.index = -1,
    this.addonsEntities = const [],
    this.addonsID = -1,
    this.selectedAddonsEntities = const [],
  });

  final Addons? addonsEntity;
  final int index;
  final List<Addons> addonsEntities;
  final int addonsID;
  final List<Addons> selectedAddonsEntities;

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

class SelectAddonsMaxPortionState extends MenuState {
  SelectAddonsMaxPortionState({
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

class NavigateToAddonsMenuState extends MenuState {
  NavigateToAddonsMenuState({
    required this.addonsEntity,
    required this.hasNewAddons,
  });

  final Addons addonsEntity;
  final bool hasNewAddons;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        addonsEntity,
        hasNewAddons,
      ];
}

class PopToMenuPageState extends MenuState {
  PopToMenuPageState({
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

class PushMenuEntityDataState extends MenuState {
  PushMenuEntityDataState({
    required this.menuEntity,
    this.menuEntities = const [],
    this.hasNewMenu = true,
    this.message = '',
    this.menuEntityStatus = MenuEntityStatus.none,
    this.menuFormStage = MenuFormStage.none,
    this.menuStateStatus = MenuStateStatus.none,
  });

  final List<MenuEntity> menuEntities;
  final bool hasNewMenu;
  final MenuEntity menuEntity;
  final String message;
  final MenuEntityStatus menuEntityStatus;
  final MenuFormStage menuFormStage;
  final MenuStateStatus menuStateStatus;

  @override
  bool get cacheHash => true;

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

class PullMenuEntityDataState extends MenuState {
  PullMenuEntityDataState({
    required this.menuEntity,
    this.menuEntities = const [],
    this.hasNewMenu = true,
    this.message = '',
    this.menuEntityStatus = MenuEntityStatus.none,
    this.menuFormStage = MenuFormStage.none,
    this.menuStateStatus = MenuStateStatus.none,
  });

  final List<MenuEntity> menuEntities;
  final bool hasNewMenu;
  final MenuEntity menuEntity;
  final String message;
  final MenuEntityStatus menuEntityStatus;
  final MenuFormStage menuFormStage;
  final MenuStateStatus menuStateStatus;

  @override
  bool get cacheHash => true;

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

class NavigateToStorePageState extends MenuState {
  NavigateToStorePageState({
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

class FetchAllStoresState extends MenuState {
  FetchAllStoresState({
    this.menuEntities = const [],
    this.listOfSelectedMenuEntities = const [],
    this.storeEntities = const [],
    this.menuStateStatus = MenuStateStatus.none,
    this.message = '',
  });

  final List<MenuEntity> menuEntities;
  final List<MenuEntity> listOfSelectedMenuEntities;
  final List<StoreEntity> storeEntities;
  final MenuStateStatus menuStateStatus;
  final String message;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        menuEntities,
        listOfSelectedMenuEntities,
        storeEntities,
        menuStateStatus,
        message,
      ];
}

class BindMenuWithStoresState extends MenuState {
  BindMenuWithStoresState({
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

class UnBindMenuWithStoresState extends MenuState {
  UnBindMenuWithStoresState({
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

class BindMenuWithUserState extends MenuState {
  BindMenuWithUserState({
    required this.appUserEntity,
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
  final AppUserEntity appUserEntity;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        menuEntities,
        listOfSelectedMenuEntities,
        menuStateStatus,
        message,
        bindMenuToUserStage,
        appUserEntity,
      ];
}

class BindAddonsWithMenuState extends MenuState {
  BindAddonsWithMenuState({
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
  bool get cacheHash => true;

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

class BindAddonsWithUserState extends MenuState {
  BindAddonsWithUserState({
    required this.appUserEntity,
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
  final AppUserEntity appUserEntity;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        menuEntities,
        listOfSelectedMenuEntities,
        menuStateStatus,
        message,
        bindAddonsToUserStage,
        appUserEntity,
      ];
}
