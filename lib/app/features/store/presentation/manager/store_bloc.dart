import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:homemakers_merchant/app/features/profile/domain/entities/user_entity.dart';
import 'package:homemakers_merchant/app/features/store/common/store_enum.dart';
import 'package:homemakers_merchant/app/features/store/domain/entities/store_entity.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/utils/app_equatable/app_equatable.dart';
import 'package:meta/meta.dart';

part 'store_event.dart';

part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(StoreInitial()) {
    on<SaveStore>(_saveStore);
    on<GetStore>(_getStore);
    on<DeleteStore>(_deleteStore);
    on<DeleteAllStore>(_deleteAllStore);
    on<GetAllStore>(_getAllStore);
    //SaveDriver
    on<SaveDriver>(_saveDriver);
    //DeleteDriver
    on<DeleteDriver>(_deleteDriver);
    //DeleteAllDriver
    on<DeleteAllDriver>(_deleteAllDriver);
    //GetAllDriver
    on<GetAllDriver>(_getAllDriver);
    //GetDriver
    on<GetDriver>(_getDriver);
  }

  FutureOr<void> _saveStore(SaveStore event, Emitter<StoreState> emit) async {
    if (!event.hasNewStore) {
      if (event.currentIndex != -1) {
        serviceLocator<List<StoreEntity>>().removeAt(event.currentIndex);
        serviceLocator<List<StoreEntity>>().insert(event.currentIndex, event.storeEntity);
      }
    } else {
      serviceLocator<List<StoreEntity>>().insert(0, event.storeEntity);
    }
    serviceLocator<AppUserEntity>().stores = serviceLocator<List<StoreEntity>>();
    emit(
      SaveStoreState(
        storeEntity: event.storeEntity,
        hasNewStore: event.hasNewStore,
      ),
    );
  }

  FutureOr<void> _getStore(GetStore event, Emitter<StoreState> emit) async {
    try {
      emit(
        GetStoreState(
          storeEntity: event.storeEntity,
          index: event.index,
          storeEntities: event.storeEntities.toList(),
          storeID: event.storeID,
        ),
      );
    } catch (e, s) {
      emit(
        StoreExceptionState(
          message: 'Something went wrong during getting your store details, please try again',
          exception: e as Exception,
          stackTrace: s,
          storeStateStage: StoreStateStage.getStore,
        ),
      );
    }
  }

  FutureOr<void> _deleteStore(DeleteStore event, Emitter<StoreState> emit) async {
    emit(
      DeleteStoreState(
        storeEntity: event.storeEntity,
        index: event.index,
        storeEntities: event.storeEntities.toList(),
        storeID: event.storeID,
      ),
    );
  }

  FutureOr<void> _deleteAllStore(DeleteAllStore event, Emitter<StoreState> emit) async {
    emit(
      DeleteAllStoreState(
        storeEntities: [],
      ),
    );
  }

  FutureOr<void> _getAllStore(GetAllStore event, Emitter<StoreState> emit) async {
    try {
      emit(StoreLoadingState(isLoading: true, message: 'Please wait while we are fetching your store...'));
      List<StoreEntity> listOfStores = serviceLocator<List<StoreEntity>>();
      if (listOfStores.isEmpty) {
        listOfStores = serviceLocator<AppUserEntity>().stores.toList();
      }
      await Future.delayed(const Duration(milliseconds: 300), () {});
      emit(StoreLoadingState(isLoading: false, message: ''));
      await Future.delayed(const Duration(milliseconds: 300), () {});
      if (listOfStores.isEmpty) {
        emit(
          GetEmptyStoreState(message: 'Store is empty', storeEntities: []),
        );
      } else {
        emit(
          GetAllStoreState(
            storeEntities: listOfStores.toList(),
          ),
        );
      }

      return;
    } catch (e, s) {
      emit(
        StoreExceptionState(
          message: 'Something went wrong during getting your all stores, please try again',
          exception: e as Exception,
          stackTrace: s,
          storeStateStage: StoreStateStage.getAllStore,
        ),
      );
    }
  }

  FutureOr<void> _saveDriver(SaveDriver event, Emitter<StoreState> emit) async {
    try {
      final StoreOwnDeliveryPartnersInfo driverEntity = event.storeOwnDeliveryPartnerEntity;
      if (!event.haveNewDriver && event.currentIndex != -1) {
        serviceLocator<List<StoreOwnDeliveryPartnersInfo>>().removeAt(event.currentIndex);
        serviceLocator<List<StoreOwnDeliveryPartnersInfo>>().insert(event.currentIndex, driverEntity);
      } else {
        serviceLocator<List<StoreOwnDeliveryPartnersInfo>>().insert(0, driverEntity);
      }
      serviceLocator<StoreOwnDeliveryPartnersInfo>();
      // Save menu
      serviceLocator<AppUserEntity>().drivers = serviceLocator<List<StoreOwnDeliveryPartnersInfo>>();
      emit(
        SaveDriverState(storeOwnDeliveryPartnerEntity: driverEntity, hasNewDriver: event.haveNewDriver, driverStateStage: DriverStateStage.success),
      );
      await Future.delayed(const Duration(milliseconds: 500), () {
        serviceLocator.resetLazySingleton<StoreOwnDeliveryPartnersInfo>();
      });
      emit(
        NavigateToNewDriverGreetingPageState(
            storeOwnDeliveryPartnerEntity: driverEntity, hasNewDriver: event.haveNewDriver, driverStateStage: DriverStateStage.success),
      );
    } catch (e, s) {
      emit(
        DriverExceptionState(
          message: 'Something went wrong during getting your all drivers, please try again',
          exception: e as Exception,
          stackTrace: s,
          driverStateStage: DriverStateStage.saveDriver,
        ),
      );
    }
  }

  FutureOr<void> _deleteDriver(DeleteDriver event, Emitter<StoreState> emit) async {
    try {} catch (e, s) {
      emit(
        DriverExceptionState(
          message: 'Something went wrong during getting your all drivers, please try again',
          exception: e as Exception,
          stackTrace: s,
          driverStateStage: DriverStateStage.deleteDriver,
        ),
      );
    }
  }

  FutureOr<void> _deleteAllDriver(DeleteAllDriver event, Emitter<StoreState> emit) async {
    try {} catch (e, s) {
      emit(
        DriverExceptionState(
          message: 'Something went wrong during getting your all drivers, please try again',
          exception: e as Exception,
          stackTrace: s,
          driverStateStage: DriverStateStage.deleteAllDriver,
        ),
      );
    }
  }

  FutureOr<void> _getAllDriver(GetAllDriver event, Emitter<StoreState> emit) async {
    try {
      emit(
        DriverLoadingState(
          isLoading: true,
          message: 'Please wait while we are fetching your drivers...',
          driverStateStage: DriverStateStage.getAllDriver,
        ),
      );
      List<StoreOwnDeliveryPartnersInfo> listOfDrivers = serviceLocator<List<StoreOwnDeliveryPartnersInfo>>();
      if (listOfDrivers.isEmpty) {
        listOfDrivers = serviceLocator<AppUserEntity>().drivers;
      }
      await Future.delayed(const Duration(milliseconds: 300), () {});
      emit(DriverLoadingState(
        isLoading: false,
        message: '',
        driverStateStage: DriverStateStage.getAllDriver,
      ));
      await Future.delayed(const Duration(milliseconds: 300), () {});
      if (listOfDrivers.isEmpty) {
        emit(
          DriverEmptyState(
            message: 'Driver is empty',
            storeOwnDeliveryPartnerEntities: [],
            isEmpty: true,
            driverStateStage: DriverStateStage.getAllDriver,
          ),
        );
      } else {
        emit(
          GetAllDriverState(
            storeOwnDeliveryPartnerEntities: listOfDrivers.toList(),
            driverStateStage: DriverStateStage.getAllDriver,
          ),
        );
      }

      return;
    } catch (e, s) {
      emit(
        DriverExceptionState(
          message: 'Something went wrong during getting your all drivers, please try again',
          exception: e as Exception,
          stackTrace: s,
          driverStateStage: DriverStateStage.getAllDriver,
        ),
      );
    }
  }

  FutureOr<void> _getDriver(GetDriver event, Emitter<StoreState> emit) async {
    try {} catch (e, s) {
      emit(
        DriverExceptionState(
          message: 'Something went wrong during getting your all drivers, please try again',
          exception: e as Exception,
          stackTrace: s,
          driverStateStage: DriverStateStage.getDriver,
        ),
      );
    }
  }
}
