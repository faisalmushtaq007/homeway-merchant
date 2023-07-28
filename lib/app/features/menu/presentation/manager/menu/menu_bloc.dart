import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:homemakers_merchant/app/app.dart';
import 'package:homemakers_merchant/app/features/address/domain/entities/address_model.dart';
import 'package:homemakers_merchant/app/features/menu/index.dart';
import 'package:homemakers_merchant/app/features/profile/domain/entities/user_entity.dart';
import 'package:homemakers_merchant/app/features/store/domain/entities/store_entity.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/utils/app_equatable/app_equatable.dart';
import 'package:homemakers_merchant/utils/app_log.dart';

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
    on<NavigateToStorePage>(
      _navigateToStorePage,
      transformer: sequential(),
    );
    on<FetchAllStores>(
      _fetchAllStores,
      transformer: sequential(),
    );
    on<BindMenuWithStores>(
      _bindMenuWithStores,
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
    final Addons currentSaveAddons = event.addonsEntity;
    if (!event.hasNewAddons && event.currentIndex != -1) {
      final currentCacheSaveAddons = currentSaveAddons.copyWith();
      // Save into local menu addons list
      localMenuAddons.removeAt(event.currentIndex);
      localMenuAddons.insert(event.currentIndex, currentCacheSaveAddons);
      serviceLocator<List<Addons>>().removeAt(event.currentIndex);
      serviceLocator<List<Addons>>().insert(0, currentSaveAddons);
      serviceLocator<AppUserEntity>().addons = serviceLocator<List<Addons>>();
      //
      emit(
        SaveAddonsState(addonsEntity: currentCacheSaveAddons, hasNewAddons: event.hasNewAddons),
      );
      await Future.delayed(const Duration(milliseconds: 500), () {});
      emit(NavigateToAddonsMenuState(addonsEntity: currentCacheSaveAddons, hasNewAddons: event.hasNewAddons));
      add(GetAllAddons());
    } else {
      final currentCacheSaveAddons = currentSaveAddons.copyWith(
        addonsID: newIndex.toString(),
      );
      localMenuAddons.insert(0, currentCacheSaveAddons);
      serviceLocator<List<Addons>>().insert(0, currentCacheSaveAddons);
      serviceLocator<AppUserEntity>().addons = serviceLocator<List<Addons>>();
      emit(
        SaveAddonsState(addonsEntity: currentCacheSaveAddons, hasNewAddons: event.hasNewAddons),
      );
      await Future.delayed(const Duration(milliseconds: 500), () {});
      emit(NavigateToAddonsMenuState(addonsEntity: currentCacheSaveAddons, hasNewAddons: event.hasNewAddons));
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
      //final List<MenuEntity> listOfMenus = serviceLocator<List<MenuEntity>>();
      final List<MenuEntity> listOfMenus = [
        MenuEntity(
          menuName: 'Soya Chilli',
          menuCategories: [
            Category(
              title: 'Arabic',
            )
          ],
          menuImages: [
            MenuImage(
                imageId: '0',
                assetPath:
                    'https://img.freepik.com/premium-photo/dum-handi-chicken-biryani-is-prepared-earthen-clay-pot-called-haandi-popular-indian-non-vegetarian-food_466689-52225.jpg',
                assetExtension: '.jpg')
          ],
        ),
        MenuEntity(
          menuName: 'Briyani',
          menuCategories: [
            Category(
              title: 'Arabic',
            )
          ],
          menuImages: [
            MenuImage(
                imageId: '1',
                assetPath:
                    'https://img.freepik.com/premium-photo/chicken-dhum-biriyani-using-jeera-rice-spices-arranged-earthen-ware_527904-513.jpg?size=626&ext=jpg',
                assetExtension: '.jpg')
          ],
        ),
        MenuEntity(
          menuName: 'Paneer Chilli',
          menuCategories: [
            Category(
              title: 'Arabic',
            )
          ],
          menuImages: [
            MenuImage(
                imageId: '2',
                assetPath:
                    'https://img.freepik.com/premium-photo/dum-handi-chicken-biryani-is-prepared-earthen-clay-pot-called-haandi-popular-indian-non-vegetarian-food_466689-52414.jpg',
                assetExtension: '.jpg')
          ],
        ),
      ];
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
      if (!event.hasNewMenu && event.currentIndex != -1) {
        serviceLocator<List<MenuEntity>>().removeAt(event.currentIndex);
        serviceLocator<List<MenuEntity>>().insert(event.currentIndex, menuEntity);
      } else {
        serviceLocator<List<MenuEntity>>().insert(0, menuEntity);
      }
      serviceLocator<AppUserEntity>().menus = serviceLocator<List<MenuEntity>>();
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

  FutureOr<void> _navigateToStorePage(NavigateToStorePage event, Emitter<MenuState> emit) async {
    emit(NavigateToStorePageState(
      menuEntities: event.menuEntities.toList(),
      listOfSelectedMenuEntities: event.listOfSelectedMenuEntities.toList(),
    ));
  }

  FutureOr<void> _fetchAllStores(FetchAllStores event, Emitter<MenuState> emit) async {
    try {
      emit(
        FetchAllStoresState(
          menuEntities: event.menuEntities.toList(),
          message: 'Your store is loading...',
          menuStateStatus: MenuStateStatus.loading,
          listOfSelectedMenuEntities: event.listOfSelectedMenuEntities.toList(),
          storeEntities: [],
        ),
      );
      //final List<StoreEntity> listOfStores = serviceLocator<List<StoreEntity>>();
      final List<StoreEntity> listOfStores = [
        StoreEntity(
          storeID: 0,
          storeName: 'Nura 24x7',
          storeAddress: AddressModel(
            address: AddressBean(
              area: 'Reyadh',
            ),
          ),
          storeImagePath: 'https://img.freepik.com/free-vector/flat-restaurant-with-lampposts_23-2147539585.jpg',
        ),
        StoreEntity(
          storeID: 1,
          storeName: 'Asansol Delight',
          storeAddress: AddressModel(
            address: AddressBean(
              area: 'Asansol',
            ),
          ),
          storeImagePath:
              'https://img.freepik.com/free-vector/scene-beverage-shop-showroom-chair-with-coffee-table-umbrella-near-green-lawn-nature-park_1150-48862.jpg',
        ),
        StoreEntity(
          storeID: 2,
          storeName: 'The Grand',
          storeAddress: AddressModel(
            address: AddressBean(
              area: 'Macca',
            ),
          ),
          storeImagePath: 'https://img.freepik.com/premium-photo/closeup-interior-chinese-restaurant_1417-16144.jpg',
        ),
      ];
      Future.delayed(const Duration(seconds: 1), () {});
      if (listOfStores.isEmpty) {
        emit(
          FetchAllStoresState(
            menuEntities: event.menuEntities.toList(),
            menuStateStatus: MenuStateStatus.empty,
            listOfSelectedMenuEntities: event.listOfSelectedMenuEntities.toList(),
            storeEntities: [],
            message: 'Your store is empty',
          ),
        );
      } else {
        emit(
          FetchAllStoresState(
            menuEntities: event.menuEntities.toList(),
            message: '',
            menuStateStatus: MenuStateStatus.success,
            listOfSelectedMenuEntities: event.listOfSelectedMenuEntities.toList(),
            storeEntities: listOfStores.toList(),
          ),
        );
      }
    } catch (e) {
      emit(
        FetchAllStoresState(
          menuEntities: event.menuEntities.toList(),
          menuStateStatus: MenuStateStatus.exception,
          listOfSelectedMenuEntities: event.listOfSelectedMenuEntities.toList(),
          storeEntities: [],
          message: 'Something went wrong, please try again',
        ),
      );
    }
  }

  FutureOr<void> _bindMenuWithStores(BindMenuWithStores event, Emitter<MenuState> emit) async {
    //try {
    emit(
      BindMenuWithStoresState(
        menuEntities: event.menuEntities.toList(),
        menuStateStatus: MenuStateStatus.exception,
        listOfSelectedMenuEntities: event.listOfSelectedMenuEntities.toList(),
        storeEntities: event.storeEntities.toList(),
        message: 'Processing please wait...',
        bindMenuToStoreStage: BindMenuToStoreStage.attaching,
      ),
    );
    List<StoreEntity> storeEntities = event.storeEntities;
    List<StoreEntity> selectedStoreEntities = event.listOfSelectedStoreEntities;
    List<MenuEntity> menuEntities = event.menuEntities;
    List<MenuEntity> selectedMenuEntities = event.listOfSelectedMenuEntities;
    // Update the object
    selectedStoreEntities.asMap().forEach((key, value) {
      value.menuEntities = selectedMenuEntities.toList();
    });
    storeEntities.asMap().forEach((parentIndex, parentStore) {
      selectedStoreEntities.asMap().forEach((childIndex, childStore) {
        if (childStore == parentStore) {
          serviceLocator<AppUserEntity>().stores[parentIndex].menuEntities = selectedMenuEntities.toList();
        }
      });
    });
    // Search store and update it with selected stores date
    //serviceLocator<AppUserEntity>().stores;
    Future.delayed(const Duration(milliseconds: 500), () {});
    emit(
      BindMenuWithStoresState(
        menuEntities: event.menuEntities.toList(),
        menuStateStatus: MenuStateStatus.success,
        listOfSelectedMenuEntities: event.listOfSelectedMenuEntities.toList(),
        storeEntities: serviceLocator<AppUserEntity>().stores.toList(),
        message: '',
        bindMenuToStoreStage: BindMenuToStoreStage.attached,
        listOfSelectedStoreEntities: selectedStoreEntities,
      ),
    );
    /*} catch (e) {
      appLog.d('Listener: BindMenuWithStoresState ${e.toString()}');
      emit(
        BindMenuWithStoresState(
          menuEntities: event.menuEntities.toList(),
          menuStateStatus: MenuStateStatus.exception,
          listOfSelectedMenuEntities: event.listOfSelectedMenuEntities.toList(),
          storeEntities: event.storeEntities.toList(),
          message: 'Something went wrong, please try again',
          bindMenuToStoreStage: BindMenuToStoreStage.exception,
          listOfSelectedStoreEntities: event.listOfSelectedStoreEntities,
        ),
      );
    }*/
  }
}
