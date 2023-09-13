import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:homemakers_merchant/app/app.dart';
import 'package:homemakers_merchant/app/features/address/index.dart';
import 'package:homemakers_merchant/app/features/menu/index.dart';
import 'package:homemakers_merchant/app/features/profile/index.dart';
import 'package:homemakers_merchant/app/features/store/index.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/shared/states/data_source_state.dart';
import 'package:homemakers_merchant/utils/app_equatable/app_equatable.dart';
import 'package:homemakers_merchant/utils/app_log.dart';
import 'package:sembast/timestamp.dart';

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
    on<RemoveByIDAddons>(
      _removeByIDAddons,
      transformer: sequential(),
    );
    on<RemoveAllAddons>(
      _removeAllAddons,
      transformer: sequential(),
    );
    on<GetByIDAddons>(
      _getByIDAddons,
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
    on<UnBindMenuWithStores>(
      _unbindMenuWithStores,
      transformer: sequential(),
    );
    on<BindMenuWithUser>(
      _bindMenuWithUser,
      transformer: sequential(),
    );
    on<BindAddonsWithMenu>(
      _bindAddonsWithMenu,
      transformer: sequential(),
    );
    on<BindAddonsWithUser>(
      _bindAddonsWithUser,
      transformer: sequential(),
    );
    on<GetAllAddonsPagination>(
      _getAllAddonsPagination,
      transformer: sequential(),
    );
    on<GetAllMenuPagination>(
      _getAllMenuPagination,
      transformer: sequential(),
    );
  }

  Future<void> _getAllAddons(GetAllAddons event, Emitter<MenuState> emit) async {
    try {
      emit(
        AddonsLoadingState(
          message: 'Please wait while we are fetching your menu',
          isLoading: true,
        ),
      );
      //List<Addons> _menuAvailableAddons = List<Addons>.from(localMenuAddons.toList());
      final DataSourceState<List<Addons>> result = await serviceLocator<GetAllAddonsUseCase>()();
      result.when(
        remote: (data, meta) {
          appLog.d('Addons bloc get all remote');
          if (data == null || data.isEmpty) {
            emit(
              GetEmptyAddonsState(
                message: 'Your addons is empty',
                addonsEntities: [],
              ),
            );
          } else {
            emit(GetAllAddonsState(
              addonsEntities: data.toList(),
            ));
          }
        },
        localDb: (data, meta) {
          appLog.d('Addons bloc get all local');
          if (data == null || data.isEmpty) {
            emit(
              GetEmptyAddonsState(
                message: 'Your addons is empty',
                addonsEntities: [],
              ),
            );
          } else {
            emit(GetAllAddonsState(
              addonsEntities: data.toList(),
            ));
          }
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Addons bloc get all error $reason');
          emit(
            AddonsExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              addonsSelectionUseCase: AddonsSelectionUseCase.getAll,
            ),
          );
        },
      );
      return;
    } catch (e, s) {
      appLog.e('Addons bloc get all exception $e');
      emit(
        AddonsExceptionState(
          message: 'Something went wrong during saving your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          addonsSelectionUseCase: AddonsSelectionUseCase.getAll,
        ),
      );
      return;
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
    try {
      DataSourceState<Addons> result;
      if (!event.hasNewAddons && event.currentIndex != -1) {
        result = await serviceLocator<EditAddonsUseCase>()(id: event.addonsEntity.addonsID, input: event.addonsEntity);
      } else {
        result = await serviceLocator<SaveAddonsUseCase>()(event.addonsEntity);
      }
      await result.when(
        remote: (data, meta) async {
          appLog.d('Addons bloc save remote ${data?.toMap()}');
          emit(
            SaveAddonsState(
              addonsEntity: data ?? event.addonsEntity,
              hasNewAddons: event.hasNewAddons,
            ),
          );
          await Future.delayed(const Duration(milliseconds: 500), () {});
          emit(NavigateToAddonsMenuState(addonsEntity: data ?? event.addonsEntity, hasNewAddons: event.hasNewAddons));
          add(GetAllAddons());
        },
        localDb: (data, meta) async {
          appLog.d('Addons bloc save local ${data?.toMap()}');
          emit(
            SaveAddonsState(
              addonsEntity: data ?? event.addonsEntity,
              hasNewAddons: event.hasNewAddons,
            ),
          );
          await Future.delayed(const Duration(milliseconds: 500), () {});
          emit(NavigateToAddonsMenuState(addonsEntity: data ?? event.addonsEntity, hasNewAddons: event.hasNewAddons));
          add(GetAllAddons());
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Addons bloc save error $reason');
          emit(
            AddonsExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              addonsSelectionUseCase: AddonsSelectionUseCase.save,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Addons bloc save exception $e');
      emit(
        AddonsExceptionState(
          message: 'Something went wrong during saving your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          addonsSelectionUseCase: AddonsSelectionUseCase.save,
        ),
      );
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
      appLog.d('PushMenuEntityData ${DateTime.now().hour}:${DateTime.now().minute}--> ${event.menuEntity.toMap()}');
      emit(
        PushMenuEntityDataState(
          menuEntity: event.menuEntity ?? serviceLocator<MenuEntity>(),
          message: 'Success',
          hasNewMenu: event.hasNewMenu,
          menuEntityStatus: event.menuEntityStatus,
          menuFormStage: event.menuFormStage,
          menuEntities: event.menuEntities.toList(),
          menuStateStatus: event.menuStateStatus,
        ),
      );
    } catch (e) {
      emit(
        PushMenuEntityDataState(
          menuEntity: event.menuEntity ?? serviceLocator<MenuEntity>(),
          message: 'Something went wrong, $e',
          hasNewMenu: event.hasNewMenu,
          menuEntityStatus: event.menuEntityStatus,
          menuFormStage: event.menuFormStage,
          menuEntities: event.menuEntities.toList(),
          menuStateStatus: event.menuStateStatus,
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
          menuStateStatus: event.menuStateStatus,
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
          menuStateStatus: event.menuStateStatus,
        ),
      );
    }
  }

  FutureOr<void> _getAllMenus(GetAllMenu event, Emitter<MenuState> emit) async {
    /*try {*/
    emit(
      GetAllMenuState(
        menuEntities: [],
        message: 'Please wait while we are fetching your menu',
        menuStateStatus: MenuStateStatus.loading,
      ),
    );
    final DataSourceState<List<MenuEntity>> result = await serviceLocator<GetAllMenuUseCase>()();
    result.when(
      remote: (data, meta) {
        appLog.d('Menu bloc get all remote');
        if (data == null || data.isEmpty) {
          emit(
            GetEmptyMenuState(
              menuEntities: [],
              message: 'Your menu is empty',
              menuStateStatus: MenuStateStatus.empty,
            ),
          );
        } else {
          emit(
            GetAllMenuState(
              menuEntities: data.toList(),
              menuStateStatus: MenuStateStatus.success,
            ),
          );
        }
      },
      localDb: (data, meta) {
        appLog.d('Menu bloc get all local');
        if (data == null || data.isEmpty) {
          emit(
            GetEmptyMenuState(
              menuEntities: [],
              message: 'Your menu is empty',
              menuStateStatus: MenuStateStatus.empty,
            ),
          );
        } else {
          data.toList().forEach((element) {
            appLog.d('Menu ${element.toMap()}');
          });
          emit(
            GetAllMenuState(
              menuEntities: data.toList(),
              menuStateStatus: MenuStateStatus.success,
            ),
          );
        }
      },
      error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
        appLog.d('Store bloc get all error $reason');
        emit(
          MenuExceptionState(
            message: reason,
            //exception: e as Exception,
            stackTrace: stackTrace,
            menuStateStatus: MenuStateStatus.getAll,
          ),
        );
        emit(
          GetAllMenuState(
            menuEntities: [],
            message: 'Something went wrong, please try again',
            menuStateStatus: MenuStateStatus.exception,
          ),
        );
      },
    );
    /*} catch (e, s) {
      appLog.e('Menu bloc get all exception $e');
      emit(
        MenuExceptionState(
          message: 'Something went wrong during saving your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          menuStateStatus: MenuStateStatus.getAll,
        ),
      );
      emit(
        GetAllMenuState(
          menuEntities: [],
          message: 'Something went wrong, please try again',
          menuStateStatus: MenuStateStatus.exception,
        ),
      );
    }*/
  }

  FutureOr<void> _saveMenu(SaveMenu event, Emitter<MenuState> emit) async {
    try {
      DataSourceState<MenuEntity> result;
      if (!event.hasNewMenu && event.currentIndex != -1) {
        result = await serviceLocator<EditMenuUseCase>()(id: event.menuEntity.menuId, input: event.menuEntity);
      } else {
        result = await serviceLocator<SaveMenuUseCase>()(event.menuEntity);
      }
      await result.when(
        remote: (data, meta) async {
          appLog.d('Menu bloc save remote ${data?.toMap()}');
          emit(
            SaveMenuState(menuEntity: data ?? event.menuEntity, hasNewMenu: event.hasNewMenu, menuStateStatus: MenuStateStatus.success),
          );
        },
        localDb: (data, meta) async {
          appLog.d('Menu bloc save local ${data?.toMap()}');
          emit(
            SaveMenuState(menuEntity: data ?? event.menuEntity, hasNewMenu: event.hasNewMenu, menuStateStatus: MenuStateStatus.success),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Menu bloc save error $reason');
          emit(
            MenuExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              menuStateStatus: MenuStateStatus.createNewWithStore,
            ),
          );
          emit(
            SaveMenuState(menuEntity: event.menuEntity, hasNewMenu: event.hasNewMenu, menuStateStatus: MenuStateStatus.exception),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Menu bloc save exception $e');
      emit(
        MenuExceptionState(
          message: 'Something went wrong during saving your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          menuStateStatus: MenuStateStatus.createNewWithStore,
        ),
      );
      emit(
        SaveMenuState(menuEntity: event.menuEntity, hasNewMenu: event.hasNewMenu, menuStateStatus: MenuStateStatus.exception),
      );
    }
  }

  FutureOr<void> _removeByIDMenu(RemoveByIDMenu event, Emitter<MenuState> emit) async {
    try {
      final DataSourceState<bool> result = await serviceLocator<DeleteMenuUseCase>()(
        input: event.menuEntity,
        id: int.parse(event.menuID),
      );
      result.when(
        remote: (data, meta) {
          appLog.d('Menu bloc delete remote $data');
          emit(
            DeleteMenuState(
              menuEntities: event.menuEntities.toList(),
              index: event.index,
              menuEntity: event.menuEntity,
              menuID: event.menuID,
              hasDelete: data ?? false,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('Menu bloc delete local $data');
          emit(
            DeleteMenuState(
              menuEntities: event.menuEntities.toList(),
              index: event.index,
              menuEntity: event.menuEntity,
              menuID: event.menuID,
              hasDelete: data ?? false,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Menu bloc delete error $reason');
          emit(
            MenuExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              menuStateStatus: MenuStateStatus.delete,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Menu bloc delete exception $e');
      emit(
        MenuExceptionState(
          message: 'Something went wrong during getting your all drivers, please try again',
          //exception: e as Exception,
          stackTrace: s,
          menuStateStatus: MenuStateStatus.delete,
        ),
      );
    }
  }

  FutureOr<void> _removeAllMenu(RemoveAllMenu event, Emitter<MenuState> emit) async {
    try {
      final DataSourceState<bool> result = await serviceLocator<DeleteAllMenuUseCase>()();
      result.when(
        remote: (data, meta) {
          appLog.d('Menu bloc delete all remote $data');
          emit(
            DeleteAllMenuState(
              message: 'Deleted all your menu',
              menuEntities: [],
              hasDeleteAll: data ?? false,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('Menu bloc delete all local $data');
          emit(
            DeleteAllAddonsState(
              message: 'Deleted all your menus',
              addonsEntities: [],
              hasDeleteAll: data ?? false,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Menu bloc delete all error $reason');
          emit(
            MenuExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              menuStateStatus: MenuStateStatus.deleteAll,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Menu bloc delete all exception $e');
      emit(
        MenuExceptionState(
          message: 'Something went wrong during getting your all drivers, please try again',
          //exception: e as Exception,
          stackTrace: s,
          menuStateStatus: MenuStateStatus.deleteAll,
        ),
      );
    }
  }

  FutureOr<void> _getByIDMenu(GetByIDMenu event, Emitter<MenuState> emit) async {
    try {
      final DataSourceState<MenuEntity> result = await serviceLocator<GetMenuUseCase>()(
        input: event.menuEntity,
        id: int.parse(event.menuID),
      );
      result.when(
        remote: (data, meta) {
          appLog.d('Menu bloc edit remote ${data?.toMap()}');
          emit(
            GetMenuState(
              menuEntity: data ?? event.menuEntity,
              index: event.index,
              menuEntities: event.menuEntities.toList(),
              menuID: event.menuID,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('Menu bloc edit local ${data?.toMap()}');
          emit(
            GetMenuState(
              menuEntity: data ?? event.menuEntity,
              index: event.index,
              menuEntities: event.menuEntities.toList(),
              menuID: event.menuID,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Menu bloc edit error $reason');
          emit(
            MenuExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              menuStateStatus: MenuStateStatus.getByID,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Menu bloc get exception $e');
      emit(
        MenuExceptionState(
          message: 'Something went wrong during getting your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          menuStateStatus: MenuStateStatus.getByID,
        ),
      );
    }
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
    try {
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
      final DataSourceState<List<StoreEntity>> result = await serviceLocator<BindMenuWithStoreUseCase>()(
        destination: event.listOfSelectedStoreEntities,
        source: event.listOfSelectedMenuEntities,
      );
      result.when(
        remote: (data, meta) {
          appLog.d('Binding menu with Store remote ${data?.length}');
          emit(
            BindMenuWithStoresState(
              menuEntities: event.menuEntities.toList(),
              menuStateStatus: MenuStateStatus.success,
              listOfSelectedMenuEntities: event.listOfSelectedMenuEntities.toList(),
              storeEntities: data ?? event.storeEntities,
              message: event.message,
              bindMenuToStoreStage: BindMenuToStoreStage.attached,
              listOfSelectedStoreEntities: event.listOfSelectedStoreEntities,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('Binding menu with Store local ${data?.length}');
          emit(
            BindMenuWithStoresState(
              menuEntities: event.menuEntities.toList(),
              menuStateStatus: MenuStateStatus.success,
              listOfSelectedMenuEntities: event.listOfSelectedMenuEntities.toList(),
              storeEntities: data ?? event.storeEntities,
              message: event.message,
              bindMenuToStoreStage: BindMenuToStoreStage.attached,
              listOfSelectedStoreEntities: event.listOfSelectedStoreEntities,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Binding menu with Store error $reason');
          emit(
            BindMenuWithStoresState(
              menuEntities: event.menuEntities.toList(),
              menuStateStatus: MenuStateStatus.exception,
              listOfSelectedMenuEntities: event.listOfSelectedMenuEntities.toList(),
              storeEntities: event.storeEntities.toList(),
              message: reason,
              bindMenuToStoreStage: BindMenuToStoreStage.failed,
              listOfSelectedStoreEntities: event.listOfSelectedStoreEntities,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Binding menu with Store exception $e');
      emit(
        BindMenuWithStoresState(
          menuEntities: event.menuEntities.toList(),
          menuStateStatus: MenuStateStatus.exception,
          listOfSelectedMenuEntities: event.listOfSelectedMenuEntities.toList(),
          storeEntities: event.storeEntities.toList(),
          message: 'Something went wrong during binding menu with store, please try again',
          bindMenuToStoreStage: BindMenuToStoreStage.exception,
          listOfSelectedStoreEntities: event.listOfSelectedStoreEntities,
        ),
      );
    }
  }

  FutureOr<void> _unbindMenuWithStores(UnBindMenuWithStores event, Emitter<MenuState> emit) async {
    try {
      emit(
        UnBindMenuWithStoresState(
          menuEntities: event.menuEntities.toList(),
          menuStateStatus: MenuStateStatus.exception,
          listOfSelectedMenuEntities: event.listOfSelectedMenuEntities.toList(),
          storeEntities: event.storeEntities.toList(),
          message: 'Processing please wait...',
          bindMenuToStoreStage: BindMenuToStoreStage.attaching,
        ),
      );
      final DataSourceState<List<StoreEntity>> result = await serviceLocator<UnBindMenuWithStoreUseCase>()(
        destination: event.listOfSelectedStoreEntities,
        source: event.listOfSelectedMenuEntities,
      );
      result.when(
        remote: (data, meta) {
          appLog.d('UnBinding menu with Store remote ${data?.length}');
          emit(
            UnBindMenuWithStoresState(
              menuEntities: event.menuEntities.toList(),
              menuStateStatus: MenuStateStatus.success,
              listOfSelectedMenuEntities: event.listOfSelectedMenuEntities.toList(),
              storeEntities: data ?? event.storeEntities.toList(),
              message: event.message,
              bindMenuToStoreStage: BindMenuToStoreStage.remove,
              listOfSelectedStoreEntities: event.listOfSelectedStoreEntities.toList(),
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('UnBinding menu with Store local ${data?.length}');
          emit(
            UnBindMenuWithStoresState(
              menuEntities: event.menuEntities.toList(),
              menuStateStatus: MenuStateStatus.success,
              listOfSelectedMenuEntities: event.listOfSelectedMenuEntities.toList(),
              storeEntities: data ?? event.storeEntities.toList(),
              message: event.message,
              bindMenuToStoreStage: BindMenuToStoreStage.remove,
              listOfSelectedStoreEntities: event.listOfSelectedStoreEntities.toList(),
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('UnBinding menu with Store error $reason');
          emit(
            UnBindMenuWithStoresState(
              menuEntities: event.menuEntities.toList(),
              menuStateStatus: MenuStateStatus.exception,
              listOfSelectedMenuEntities: event.listOfSelectedMenuEntities.toList(),
              storeEntities: event.storeEntities.toList(),
              message: reason,
              bindMenuToStoreStage: BindMenuToStoreStage.failed,
              listOfSelectedStoreEntities: event.listOfSelectedStoreEntities,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.d('UnBinding menu with Store exception $e');
      emit(
        UnBindMenuWithStoresState(
          menuEntities: event.menuEntities.toList(),
          menuStateStatus: MenuStateStatus.exception,
          listOfSelectedMenuEntities: event.listOfSelectedMenuEntities.toList(),
          storeEntities: event.storeEntities.toList(),
          message: 'Something went wrong during unbinding your menu with store, please try again',
          bindMenuToStoreStage: BindMenuToStoreStage.exception,
          listOfSelectedStoreEntities: event.listOfSelectedStoreEntities,
        ),
      );
    }
  }

  FutureOr<void> _removeByIDAddons(RemoveByIDAddons event, Emitter<MenuState> emit) async {
    try {
      final DataSourceState<bool> result = await serviceLocator<DeleteAddonsUseCase>()(
        input: event.addonsEntity,
        id: int.parse(event.addonsID),
      );
      result.when(
        remote: (data, meta) {
          appLog.d('Addons bloc delete remote $data');
          emit(
            DeleteAddonsState(
              addonsEntity: event.addonsEntity,
              index: event.index,
              addonsEntities: event.addonsEntities.toList(),
              addonsID: event.addonsID,
              hasDelete: data ?? false,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('Addons bloc delete local $data');
          emit(
            DeleteAddonsState(
              addonsEntity: event.addonsEntity,
              index: event.index,
              addonsEntities: event.addonsEntities.toList(),
              addonsID: event.addonsID,
              hasDelete: data ?? false,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Addons bloc delete error $reason');
          emit(
            AddonsExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              addonsSelectionUseCase: AddonsSelectionUseCase.delete,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Addons bloc delete exception $e');
      emit(
        AddonsExceptionState(
          message: 'Something went wrong during getting your all drivers, please try again',
          //exception: e as Exception,
          stackTrace: s,
          addonsSelectionUseCase: AddonsSelectionUseCase.delete,
        ),
      );
    }
  }

  FutureOr<void> _removeAllAddons(RemoveAllAddons event, Emitter<MenuState> emit) async {
    try {
      final DataSourceState<bool> result = await serviceLocator<DeleteAllAddonsUseCase>()();
      result.when(
        remote: (data, meta) {
          appLog.d('Addons bloc delete all remote $data');
          emit(
            DeleteAllAddonsState(
              message: 'Delete all your addons',
              addonsEntities: [],
              hasDeleteAll: data ?? false,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('Driver bloc delete all local $data');
          emit(
            DeleteAllAddonsState(
              message: 'Delete all your addons',
              addonsEntities: [],
              hasDeleteAll: data ?? false,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Driver bloc delete all error $reason');
          emit(
            AddonsExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              addonsSelectionUseCase: AddonsSelectionUseCase.deleteAll,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Addons bloc delete all exception $e');
      emit(
        AddonsExceptionState(
          message: 'Something went wrong during getting your all drivers, please try again',
          //exception: e as Exception,
          stackTrace: s,
          addonsSelectionUseCase: AddonsSelectionUseCase.deleteAll,
        ),
      );
    }
  }

  FutureOr<void> _getByIDAddons(GetByIDAddons event, Emitter<MenuState> emit) async {
    try {
      final DataSourceState<Addons> result = await serviceLocator<GetAddonsUseCase>()(
        input: event.addonsEntity,
        id: int.parse(event.addonsID),
      );
      result.when(
        remote: (data, meta) {
          appLog.d('Addons bloc get remote ${data?.toMap()}');
          emit(
            GetAddonsState(
              addonsEntity: data ?? event.addonsEntity,
              index: event.index,
              addonsEntities: event.addonsEntities.toList(),
              addonsID: event.addonsID,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('Addons bloc get local ${data?.toMap()}');
          emit(
            GetAddonsState(
              addonsEntity: data ?? event.addonsEntity,
              index: event.index,
              addonsEntities: event.addonsEntities.toList(),
              addonsID: event.addonsID,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Addons bloc get error $reason');
          emit(
            AddonsExceptionState(
                message: reason,
                //exception: e as Exception,
                stackTrace: stackTrace,
                addonsSelectionUseCase: AddonsSelectionUseCase.getByID),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Addons bloc get exception $e');
      emit(
        AddonsExceptionState(
            message: 'Something went wrong during getting your store details, please try again',
            //exception: e as Exception,
            stackTrace: s,
            addonsSelectionUseCase: AddonsSelectionUseCase.getByID),
      );
    }
  }

  FutureOr<void> _bindMenuWithUser(BindMenuWithUser event, Emitter<MenuState> emit) async {}

  FutureOr<void> _bindAddonsWithMenu(BindAddonsWithMenu event, Emitter<MenuState> emit) async {}

  FutureOr<void> _bindAddonsWithUser(BindAddonsWithUser event, Emitter<MenuState> emit) async {}

  FutureOr<void> _getAllAddonsPagination(GetAllAddonsPagination event, Emitter<MenuState> emit) async {
    try {
      emit(GetAllLoadingAddonsPaginationState(isLoading: true, message: 'Please wait while we are fetching all addons...'));
      final DataSourceState<List<Addons>> result = await serviceLocator<GetAllAddonsPaginationUseCase>()(
        pageKey: event.pageKey,
        pageSize: event.pageSize,
        searchText: event.searchText,
        filtering: event.filter,
        sorting: event.sorting,
        startTime: event.startTimeStamp,
        endTime: event.endTimeStamp,
      );
      result.when(
        remote: (data, meta) {
          appLog.d('Get all addons bloc get all remote');
          if (data == null || data.isEmpty) {
            emit(
              GetAllEmptyAddonsPaginationState(
                message: 'All addons is empty',
                addonsEntities: [],
                endTimeStamp: event.endTimeStamp,
                startTimeStamp: event.startTimeStamp,
                pageKey: event.pageKey,
                pageSize: event.pageSize,
                searchText: event.searchText,
                sorting: event.sorting,
                filter: event.filter,
              ),
            );
          } else {
            emit(
              GetAllAddonsPaginationState(
                addonsEntities: data.toList(),
                endTimeStamp: event.endTimeStamp,
                startTimeStamp: event.startTimeStamp,
                pageKey: event.pageKey,
                pageSize: event.pageSize,
                searchText: event.searchText,
                sorting: event.sorting,
                filter: event.filter,
              ),
            );
          }
        },
        localDb: (data, meta) {
          appLog.d('Get all addons bloc get all local');
          if (data == null || data.isEmpty) {
            emit(
              GetAllEmptyAddonsPaginationState(
                message: 'All addons is empty',
                addonsEntities: [],
                endTimeStamp: event.endTimeStamp,
                startTimeStamp: event.startTimeStamp,
                pageKey: event.pageKey,
                pageSize: event.pageSize,
                searchText: event.searchText,
                sorting: event.sorting,
                filter: event.filter,
              ),
            );
          } else {
            emit(
              GetAllAddonsPaginationState(
                addonsEntities: data.toList(),
                endTimeStamp: event.endTimeStamp,
                startTimeStamp: event.startTimeStamp,
                pageKey: event.pageKey,
                pageSize: event.pageSize,
                searchText: event.searchText,
                sorting: event.sorting,
                filter: event.filter,
              ),
            );
          }
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Get all addons bloc get all error $reason');
          emit(
            GetAllExceptionAddonsPaginationState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Get all addons bloc get all $e');
      emit(
        GetAllExceptionAddonsPaginationState(
          message: 'Something went wrong during getting all addons, please try again',
          //exception: e as Exception,
          stackTrace: s,
        ),
      );
    }
  }

  FutureOr<void> _getAllMenuPagination(GetAllMenuPagination event, Emitter<MenuState> emit) async {
    try {
      emit(GetAllLoadingMenuPaginationState(isLoading: true, message: 'Please wait while we are fetching all address...'));
      final DataSourceState<List<MenuEntity>> result = await serviceLocator<GetAllMenuPaginationUseCase>()(
        pageKey: event.pageKey,
        pageSize: event.pageSize,
        searchText: event.searchText,
        filtering: event.filter,
        sorting: event.sorting,
        startTime: event.startTimeStamp,
        endTime: event.endTimeStamp,
      );
      result.when(
        remote: (data, meta) {
          appLog.d('Get all menu bloc get all remote');
          if (data == null || data.isEmpty) {
            emit(
              GetAllEmptyMenuPaginationState(
                message: 'All menu is empty',
                menuEntities: [],
                endTimeStamp: event.endTimeStamp,
                startTimeStamp: event.startTimeStamp,
                pageKey: event.pageKey,
                pageSize: event.pageSize,
                searchText: event.searchText,
                sorting: event.sorting,
                filter: event.filter,
              ),
            );
          } else {
            emit(
              GetAllMenuPaginationState(
                menuEntities: data.toList(),
                endTimeStamp: event.endTimeStamp,
                startTimeStamp: event.startTimeStamp,
                pageKey: event.pageKey,
                pageSize: event.pageSize,
                searchText: event.searchText,
                sorting: event.sorting,
                filter: event.filter,
              ),
            );
          }
        },
        localDb: (data, meta) {
          appLog.d('Get all menu bloc get all local');
          if (data == null || data.isEmpty) {
            emit(
              GetAllEmptyMenuPaginationState(
                message: 'All menu is empty',
                menuEntities: [],
                endTimeStamp: event.endTimeStamp,
                startTimeStamp: event.startTimeStamp,
                pageKey: event.pageKey,
                pageSize: event.pageSize,
                searchText: event.searchText,
                sorting: event.sorting,
                filter: event.filter,
              ),
            );
          } else {
            emit(
              GetAllMenuPaginationState(
                menuEntities: data.toList(),
                endTimeStamp: event.endTimeStamp,
                startTimeStamp: event.startTimeStamp,
                pageKey: event.pageKey,
                pageSize: event.pageSize,
                searchText: event.searchText,
                sorting: event.sorting,
                filter: event.filter,
              ),
            );
          }
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Get all menu bloc get all error $reason');
          emit(
            GetAllExceptionMenuPaginationState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Get all menu bloc get all $e');
      emit(
        GetAllExceptionMenuPaginationState(
          message: 'Something went wrong during getting all menu, please try again',
          //exception: e as Exception,
          stackTrace: s,
        ),
      );
    }
  }
}
