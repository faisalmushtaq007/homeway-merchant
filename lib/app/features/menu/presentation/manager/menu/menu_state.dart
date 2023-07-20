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
  });

  final MenuEntity menuEntity;
  final bool hasNewMenu;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        menuEntity,
        hasNewMenu,
      ];
}

class MenuLoadingState extends MenuState {
  MenuLoadingState({
    required this.isLoading,
    required this.message,
  });

  final bool isLoading;
  final String message;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        isLoading,
        message,
      ];
}

class MenuProcessingState extends MenuState {
  MenuProcessingState({
    required this.isProcessing,
    required this.message,
  });

  final bool isProcessing;
  final String message;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        isProcessing,
        message,
      ];
}

class MenuFailedState extends MenuState {
  MenuFailedState({
    required this.message,
  });

  final String message;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        message,
      ];
}

class MenuExceptionState extends MenuState {
  MenuExceptionState({
    required this.message,
    this.stackTrace,
    this.exception,
  });

  final String message;
  final StackTrace? stackTrace;
  final Exception? exception;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        message,
        stackTrace,
        exception,
      ];
}

class DeleteMenuState extends MenuState {
  DeleteMenuState({
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

class DeleteAllMenuState extends MenuState {
  DeleteAllMenuState({this.menuEntities = const []});

  final List<MenuEntity> menuEntities;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [menuEntities];
}

class GetAllMenuState extends MenuState {
  GetAllMenuState({this.menuEntities = const []});

  final List<MenuEntity> menuEntities;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        menuEntities,
      ];
}

class GetEmptyMenuState extends MenuState {
  GetEmptyMenuState({this.menuEntities = const [], this.message = ''});

  final List<MenuEntity> menuEntities;
  final String message;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        menuEntities,
        message,
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

class AddonsLoadingState extends MenuState {
  AddonsLoadingState({
    required this.isLoading,
    required this.message,
  });

  final bool isLoading;
  final String message;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        isLoading,
        message,
      ];
}

class AddonsProcessingState extends MenuState {
  AddonsProcessingState({
    required this.isProcessing,
    required this.message,
  });

  final bool isProcessing;
  final String message;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        isProcessing,
        message,
      ];
}

class AddonsFailedState extends MenuState {
  AddonsFailedState({
    required this.message,
  });

  final String message;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        message,
      ];
}

class AddonsExceptionState extends MenuState {
  AddonsExceptionState({
    required this.message,
    this.stackTrace,
    this.exception,
  });

  final String message;
  final StackTrace? stackTrace;
  final Exception? exception;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        message,
        stackTrace,
        exception,
      ];
}

class DeleteAddonsState extends MenuState {
  DeleteAddonsState({
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

class DeleteAllAddonsState extends MenuState {
  DeleteAllAddonsState({this.addonsEntities = const []});

  final List<Addons> addonsEntities;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [addonsEntities];
}

class GetAllAddonsState extends MenuState {
  GetAllAddonsState({this.addonsEntities = const []});

  final List<Addons> addonsEntities;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        addonsEntities,
      ];
}

class GetEmptyAddonsState extends MenuState {
  GetEmptyAddonsState({this.addonsEntities = const [], this.message = ''});

  final List<Addons> addonsEntities;
  final String message;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        addonsEntities,
        message,
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
    this.addonsID = '',
    this.selectedAddonsEntities = const [],
  });

  final Addons? addonsEntity;
  final int index;
  final List<Addons> addonsEntities;
  final String addonsID;
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
    this.menuSelectionUseCase = MenuSelectionUseCase.none,
  });

  final List<MenuEntity> menuEntities;
  final bool hasNewMenu;
  final MenuEntity menuEntity;
  final String message;
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

class PullMenuEntityDataState extends MenuState {
  PullMenuEntityDataState({
    required this.menuEntity,
    this.menuEntities = const [],
    this.hasNewMenu = true,
    this.message = '',
    this.menuEntityStatus = MenuEntityStatus.none,
    this.menuFormStage = MenuFormStage.none,
    this.menuSelectionUseCase = MenuSelectionUseCase.none,
  });

  final List<MenuEntity> menuEntities;
  final bool hasNewMenu;
  final MenuEntity menuEntity;
  final String message;
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
