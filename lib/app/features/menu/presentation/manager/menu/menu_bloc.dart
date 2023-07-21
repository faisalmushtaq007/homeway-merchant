import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:homemakers_merchant/app/features/menu/index.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/utils/app_equatable/app_equatable.dart';

part 'menu_event.dart';

part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(MenuInitial()) {
    on<GetAllAddons>(
      _getAllAddons,
      transformer: sequential(),
    );
    on<SelectAddons>(
      _selectAddons,
      transformer: sequential(),
    );
    on<SaveAddons>(
      _saveAddons,
      transformer: sequential(),
    );
    on<SelectAddonsMaxPortion>(
      _selectAddonsMaxPortion,
      transformer: sequential(),
    );
    on<PopToMenuPage>(
      _popToMenuPage,
      transformer: sequential(),
    );
    on<PushMenuEntityData>(
      _pushMenuEntityData,
      transformer: sequential(),
    );
    on<PullMenuEntityData>(
      _pullMenuEntityData,
      transformer: sequential(),
    );
    on<SaveMenu>(
      _saveMenu,
      transformer: sequential(),
    );
    on<RemoveByIDMenu>(
      _removeByIDMenu,
      transformer: sequential(),
    );
    on<RemoveAllMenu>(
      _removeAllMenu,
      transformer: sequential(),
    );
    on<GetByIDMenu>(
      _getByIDMenu,
      transformer: sequential(),
    );
    on<SelectAllMenu>(
      _selectAllMenu,
      transformer: sequential(),
    );
    on<GetAllMenu>(
      _getAllMenus,
      transformer: sequential(),
    );
  }

  Future<void> _getAllAddons(GetAllAddons event, Emitter<MenuState> emit) async {
    try {
      emit(
        AddonsLoadingState(
          message: '',
          isLoading: true,
        ),
      );
      List<Addons> _menuAvailableAddons = List<Addons>.from(localMenuAddons.toList());
      await Future.delayed(
          const Duration(
            milliseconds: 500,
          ),
          () {});
      if (_menuAvailableAddons.isEmpty) {
        emit(
          GetEmptyAddonsState(
            message: 'Addons is empty',
            addonsEntities: [],
          ),
        );
      } else {
        emit(GetAllAddonsState(
          addonsEntities: _menuAvailableAddons.toList(),
        ));
      }
    } catch (e, s) {
      debugPrint(e.toString());
      emit(AddonsExceptionState(
        message: 'Something went wrong',
        exception: e as Exception,
        stackTrace: s,
      ));
    }
  }

  void _selectAddons(SelectAddons event, Emitter<MenuState> emit) {
    List<Addons> _menuAvailableAddons = List<Addons>.from(event.addonsEntities.toList());
    var selectedAllAddonsEntities = event.selectedAddonsEntities;
    var selectedAddonsEntity = event.addonsEntity;
    if (selectedAddonsEntity != null) {
      if (selectedAllAddonsEntities.contains(selectedAddonsEntity)) {
        selectedAllAddonsEntities.remove(selectedAddonsEntity);
      } else {
        selectedAllAddonsEntities.add(selectedAddonsEntity);
      }
    }

    emit(
      SelectAddonsState(
        addonsEntities: _menuAvailableAddons.toList(),
        addonsEntity: selectedAddonsEntity,
        selectedAddonsEntities: selectedAllAddonsEntities.toList(),
        addonsID: event.addonsID,
        index: event.index,
      ),
    );
  }

  FutureOr<void> _saveAddons(SaveAddons event, Emitter<MenuState> emit) async {
    final newIndex = localMenuAddons.toList().length - 1;
    Addons currentSaveAddons = event.addonsEntity;
    if (event.hasNewAddons) {
      var currentCacheSaveAddons = currentSaveAddons.copyWith(
        addonsID: newIndex.toString(),
      );
      emit(
        SaveAddonsState(addonsEntity: currentCacheSaveAddons, hasNewAddons: event.hasNewAddons),
      );
      await Future.delayed(const Duration(milliseconds: 500), () {});
      emit(NavigateToAddonsMenuState(addonsEntity: currentCacheSaveAddons, hasNewAddons: event.hasNewAddons));
    } else {
      emit(
        SaveAddonsState(addonsEntity: currentSaveAddons, hasNewAddons: event.hasNewAddons),
      );
      await Future.delayed(const Duration(milliseconds: 500), () {});
      emit(NavigateToAddonsMenuState(addonsEntity: currentSaveAddons, hasNewAddons: event.hasNewAddons));
    }
  }

  FutureOr<void> _selectAddonsMaxPortion(SelectAddonsMaxPortion event, Emitter<MenuState> emit) async {
    emit(
      SelectAddonsMaxPortionState(
        addonsEntities: event.addonsEntities.toList(),
        selectedAddonsEntities: event.selectedAddonsEntities.toList(),
        selectedMenuPortions: event.selectedMenuPortions.toList(),
      ),
    );
  }

  FutureOr<void> _popToMenuPage(PopToMenuPage event, Emitter<MenuState> emit) {
    emit(
      PopToMenuPageState(
        hasNewAddons: event.hasNewAddons,
        addonsEntity: event.addonsEntity.toList(),
      ),
    );
  }

  FutureOr<void> _pushMenuEntityData(PushMenuEntityData event, Emitter<MenuState> emit) async {
    try {
      /*final MenuEntity cacheMenuEntity = serviceLocator<MenuEntity>();
      final MenuEntity updatedCacheMenuEntity = serviceLocator<MenuEntity>().copyWith(
        id: event.menuEntity.id,
        menuId: event.menuEntity.menuId,
        menuImages: event.menuEntity.menuImages,
        menuName: event.menuEntity.menuName,
        menuDescription: event.menuEntity.menuDescription,
        menuCategories: event.menuEntity.menuCategories,
        ingredients: event.menuEntity.ingredients,
        storeAvailableFoodTypes: event.menuEntity.storeAvailableFoodTypes,
        storeAvailableFoodPreparationType: event.menuEntity.storeAvailableFoodPreparationType,
        menuPortions: event.menuEntity.menuPortions,
        hasCustomPortion: event.menuEntity.hasCustomPortion,
        customPortions: event.menuEntity.customPortions,
        addons: event.menuEntity.addons,
        menuAvailableFromTime: event.menuEntity.menuAvailableFromTime,
        menuAvailableToTime: event.menuEntity.menuAvailableToTime,
        menuAvailableInDays: event.menuEntity.menuAvailableInDays,
        minStockAvailable: event.menuEntity.minStockAvailable,
        maxStockAvailable: event.menuEntity.maxStockAvailable,
        timeOfPeriodWise: event.menuEntity.timeOfPeriodWise,
        metaInfoOfMenu: event.menuEntity.metaInfoOfMenu,
        nutrients: event.menuEntity.nutrients,
        menuTiming: event.menuEntity.menuTiming,
        tasteType: event.menuEntity.tasteType,
        stock: event.menuEntity.stock,
        customPortion: event.menuEntity.customPortion,
        menuMaxPreparationTime: event.menuEntity.menuMaxPreparationTime,
        menuMinPreparationTime: event.menuEntity.menuMinPreparationTime,
      );
      //await Future.delayed(const Duration(milliseconds: 500), () {});
      debugPrint('MenuBloc ${DateTime.now().hour}:${DateTime.now().minute}--> ${cacheMenuEntity.toMap()}');
      debugPrint('=======>');*/
      debugPrint('MenuBloc ${DateTime.now().hour}:${DateTime.now().minute}--> ${event.menuEntity.toMap()}');
      emit(
        PushMenuEntityDataState(
          menuEntity: serviceLocator<MenuEntity>(),
          message: 'Success',
          hasNewMenu: event.hasNewMenu,
          menuEntityStatus: event.menuEntityStatus,
          menuFormStage: event.menuFormStage,
          menuEntities: event.menuEntities.toList(),
          menuSelectionUseCase: event.menuSelectionUseCase,
        ),
      );
    } catch (e) {
      emit(
        PushMenuEntityDataState(
          menuEntity: serviceLocator<MenuEntity>(),
          message: 'Something went wrong, ${e.toString()}',
          hasNewMenu: event.hasNewMenu,
          menuEntityStatus: event.menuEntityStatus,
          menuFormStage: event.menuFormStage,
          menuEntities: event.menuEntities.toList(),
          menuSelectionUseCase: event.menuSelectionUseCase,
        ),
      );
    }
  }

  FutureOr<void> _pullMenuEntityData(PullMenuEntityData event, Emitter<MenuState> emit) async {
    try {
      final MenuEntity cacheMenuEntity = serviceLocator<MenuEntity>();
      //await Future.delayed(const Duration(milliseconds: 500), () {});
      emit(
        PullMenuEntityDataState(
          menuEntity: cacheMenuEntity,
          message: 'Success',
          hasNewMenu: event.hasNewMenu,
          menuEntityStatus: event.menuEntityStatus,
          menuFormStage: event.menuFormStage,
          menuEntities: event.menuEntities.toList(),
          menuSelectionUseCase: event.menuSelectionUseCase,
        ),
      );
    } catch (e) {
      emit(
        PullMenuEntityDataState(
          menuEntity: serviceLocator<MenuEntity>(),
          message: 'Something went wrong, ${e.toString()}',
          hasNewMenu: event.hasNewMenu,
          menuEntityStatus: event.menuEntityStatus,
          menuFormStage: event.menuFormStage,
          menuEntities: event.menuEntities.toList(),
          menuSelectionUseCase: event.menuSelectionUseCase,
        ),
      );
    }
  }

  FutureOr<void> _getAllMenus(GetAllMenu event, Emitter<MenuState> emit) async {
    try {
      emit(
        GetAllMenuState(
          menuEntities: [],
          message: 'Your menu is loading...',
          menuStateStatus: MenuStateStatus.loading,
        ),
      );
      final List<MenuEntity> listOfMenus = serviceLocator<List<MenuEntity>>();
      Future.delayed(const Duration(seconds: 1), () {});
      if (listOfMenus.isEmpty) {
        emit(
          GetAllMenuState(
            menuEntities: [],
            message: 'Your menu is empty',
            menuStateStatus: MenuStateStatus.empty,
          ),
        );
      } else {
        emit(
          GetAllMenuState(
            menuEntities: listOfMenus.toList(),
            message: '',
            menuStateStatus: MenuStateStatus.success,
          ),
        );
      }
    } catch (e) {
      emit(
        GetAllMenuState(
          menuEntities: [],
          message: 'Something went wrong, please try again',
          menuStateStatus: MenuStateStatus.exception,
        ),
      );
    }
  }

  FutureOr<void> _saveMenu(SaveMenu event, Emitter<MenuState> emit) async {
    try {
      // Save menu
      final MenuEntity menuEntity = event.menuEntity;
      serviceLocator<List<MenuEntity>>().add(menuEntity);
      emit(
        SaveMenuState(menuEntity: menuEntity, hasNewMenu: event.hasNewMenu, menuStateStatus: MenuStateStatus.success),
      );
      await Future.delayed(const Duration(milliseconds: 500), () {
        serviceLocator.resetLazySingleton<MenuEntity>();
      });
    } catch (e) {
      emit(
        SaveMenuState(menuEntity: event.menuEntity, hasNewMenu: event.hasNewMenu, menuStateStatus: MenuStateStatus.exception),
      );
    }
  }

  FutureOr<void> _removeByIDMenu(RemoveByIDMenu event, Emitter<MenuState> emit) async {
    try {} catch (e) {}
  }

  FutureOr<void> _removeAllMenu(RemoveAllMenu event, Emitter<MenuState> emit) async {
    try {} catch (e) {}
  }

  FutureOr<void> _getByIDMenu(GetByIDMenu event, Emitter<MenuState> emit) async {
    try {} catch (e) {}
  }

  FutureOr<void> _selectAllMenu(SelectAllMenu event, Emitter<MenuState> emit) async {
    try {} catch (e) {}
  }
}
