import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/cupertino.dart';
import 'package:homemakers_merchant/app/features/profile/domain/entities/user_entity.dart';
import 'package:homemakers_merchant/app/features/store/common/store_enum.dart';
import 'package:homemakers_merchant/app/features/store/domain/entities/store_entity.dart';
import 'package:homemakers_merchant/app/features/store/index.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/core/extensions/global_extensions/dart_extensions.dart';
import 'package:homemakers_merchant/core/local/database/base/identifiable.dart';
import 'package:homemakers_merchant/core/local/database/base/repository_failure.dart';
import 'package:homemakers_merchant/shared/states/data_source_state.dart';
import 'package:homemakers_merchant/utils/app_equatable/app_equatable.dart';
import 'package:homemakers_merchant/utils/app_log.dart';
import 'package:homemakers_merchant/utils/functional/functional.dart';
import 'package:meta/meta.dart';

part 'store_event.dart';

part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(StoreInitial()) {
    on<SaveStore>(
      _saveStore,
      transformer: sequential(),
    );
    on<GetStore>(
      _getStore,
      transformer: sequential(),
    );
    on<DeleteStore>(
      _deleteStore,
      transformer: sequential(),
    );
    on<DeleteAllStore>(
      _deleteAllStore,
      transformer: sequential(),
    );
    on<GetAllStore>(
      _getAllStore,
      transformer: sequential(),
    );
    //SaveDriver
    on<SaveDriver>(
      _saveDriver,
      transformer: sequential(),
    );
    //DeleteDriver
    on<DeleteDriver>(
      _deleteDriver,
      transformer: sequential(),
    );
    //DeleteAllDriver
    on<DeleteAllDriver>(
      _deleteAllDriver,
      transformer: sequential(),
    );
    //GetAllDriver
    on<GetAllDriver>(
      _getAllDriver,
      transformer: sequential(),
    );
    //GetDriver
    on<GetDriver>(
      _getDriver,
      transformer: sequential(),
    );
    on<BindDriverWithStores>(
      _bindDriverWithStores,
      transformer: sequential(),
    );
  }

  FutureOr<void> _saveStore(SaveStore event, Emitter<StoreState> emit) async {
    try {
      DataSourceState<StoreEntity> result;
      StoreEntity storeEntity = StoreEntity();
      if (!event.hasNewStore && event.currentIndex != -1) {
        result = await serviceLocator<EditStoreUseCase>()(id: event.storeEntity.storeID, input: event.storeEntity);
      } else {
        result = await serviceLocator<SaveStoreUseCase>()(event.storeEntity);
      }
      result.when(
        remote: (data, meta) {
          appLog.d('Remote');
        },
        localDb: (data, meta) {
          appLog.d('Local');
          emit(
            SaveStoreState(
              storeEntity: data ?? event.storeEntity,
              hasNewStore: event.hasNewStore,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Error ${reason}');
          emit(
            StoreExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              storeStateStage: StoreStateStage.createNewWithStore,
            ),
          );
        },
      );
      /*result.fold((left) {
        appLog.d('Save Store error ${left.toString()}');
      }, (right) {
        storeEntity = right;
        appLog.d('Save StoreID : ${right.storeID}, ${right.storeName}');
      });
      emit(
        SaveStoreState(
          storeEntity: storeEntity.storeID.toString().isEmptyOrNull ? event.storeEntity : storeEntity,
          hasNewStore: event.hasNewStore,
        ),
      );*/
    } catch (e, s) {
      appLog.e('Save store ${e.toString()}');
      emit(
        StoreExceptionState(
          message: 'Something went wrong during saving your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          storeStateStage: StoreStateStage.createNewWithStore,
        ),
      );
    }
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
          //exception: e as Exception,
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
      List<StoreEntity> listOfStores = List<StoreEntity>.from(serviceLocator<List<StoreEntity>>().toList());
      if (listOfStores.isEmpty) {
        listOfStores = serviceLocator<AppUserEntity>().stores.toList();
      }
      final result = await serviceLocator<StoreLocalDbRepository>().getAll();
      result.fold((left) {
        debugPrint('Store get all error ${left.toString()}');
        listOfStores = [];
      }, (right) {
        debugPrint('Store get all ${right.length}');
        listOfStores = List<StoreEntity>.from(right.toList());
      });
      //await Future.delayed(const Duration(milliseconds: 300), () {});
      //emit(StoreLoadingState(isLoading: false, message: ''));
      //await Future.delayed(const Duration(milliseconds: 300), () {});
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
      appLog.e('Get All store ${e.toString()}');
      emit(
        StoreExceptionState(
          message: 'Something went wrong during getting your all stores, please try again',
          //exception: e as Exception,
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
      // Save menu
      serviceLocator<AppUserEntity>().drivers = List<StoreOwnDeliveryPartnersInfo>.from(serviceLocator<List<StoreOwnDeliveryPartnersInfo>>().toList());
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
      appLog.e('Save Driver store ${e.toString()}');
      emit(
        DriverExceptionState(
          message: 'Something went wrong during getting your all drivers, please try again',
          //exception: e as Exception,
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
          //exception: e as Exception,
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
          //exception: e as Exception,
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
      List<StoreOwnDeliveryPartnersInfo> listOfDrivers = List<StoreOwnDeliveryPartnersInfo>.from(serviceLocator<List<StoreOwnDeliveryPartnersInfo>>().toList());
      if (listOfDrivers.isEmpty) {
        listOfDrivers = serviceLocator<AppUserEntity>().drivers;
      }
      /*await Future.delayed(const Duration(milliseconds: 300), () {});
      emit(DriverLoadingState(
        isLoading: false,
        message: '',
        driverStateStage: DriverStateStage.getAllDriver,
      ));*/
      listOfDrivers = [
        StoreOwnDeliveryPartnersInfo(
          driverID: 0,
          driverName: 'Sonu',
          driverMobileNumber: '',
          drivingLicenseNumber: '1234',
          vehicleInfo: VehicleInfo(vehicleID: '0', vehicleType: '2 Wheeler', vehicleNumber: '12345'),
        ),
        StoreOwnDeliveryPartnersInfo(
          driverID: 1,
          driverName: 'Monu',
          driverMobileNumber: '',
          drivingLicenseNumber: '123456',
          vehicleInfo: VehicleInfo(vehicleID: '1', vehicleType: '3 Wheeler', vehicleNumber: '12345789'),
        ),
      ];
      //await Future.delayed(const Duration(milliseconds: 300), () {});
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
          //exception: e as Exception,
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
          //exception: e as Exception,
          stackTrace: s,
          driverStateStage: DriverStateStage.getDriver,
        ),
      );
    }
  }

  FutureOr<void> _bindDriverWithStores(BindDriverWithStores event, Emitter<StoreState> emit) async {
    try {
      emit(
        BindDriverWithStoresLoadingState(
          message: 'Processing please wait...',
          bindDriverToStoreStage: BindDriverToStoreStage.attaching,
          isLoading: true,
        ),
      );
      List<StoreEntity> storeEntities = event.storeEntities;
      List<StoreEntity> selectedStoreEntities = event.listOfSelectedStoreEntities;
      List<StoreOwnDeliveryPartnersInfo> storeOwnDeliveryPartnersEntities = event.listOfStoreOwnDeliveryPartners;
      List<StoreOwnDeliveryPartnersInfo> selectedStoreOwnDeliveryPartners = event.listOfSelectedStoreOwnDeliveryPartners;
      // Update the object
      selectedStoreEntities.asMap().forEach((key, value) {
        value.storeOwnDeliveryPartnersInfo = selectedStoreOwnDeliveryPartners.toList();
      });
      storeEntities.asMap().forEach((parentIndex, parentStore) {
        selectedStoreEntities.asMap().forEach((childIndex, childStore) {
          if (childStore == parentStore) {
            serviceLocator<AppUserEntity>().stores[parentIndex].storeOwnDeliveryPartnersInfo = selectedStoreOwnDeliveryPartners.toList();
          }
        });
      });
      // Search store and update it with selected stores date
      //serviceLocator<AppUserEntity>().stores;
      Future.delayed(const Duration(milliseconds: 500), () {});
      emit(
        BindDriverWithStoresState(
          listOfStoreOwnDeliveryPartners: event.listOfStoreOwnDeliveryPartners.toList(),
          listOfSelectedStoreOwnDeliveryPartners: event.listOfSelectedStoreOwnDeliveryPartners.toList(),
          storeEntities: serviceLocator<AppUserEntity>().stores.toList(),
          message: '',
          bindDriverToStoreStage: BindDriverToStoreStage.attached,
          listOfSelectedStoreEntities: selectedStoreEntities,
        ),
      );
    } catch (e) {
      appLog.d('Listener: BindMenuWithStoresState ${e.toString()}');
      emit(
        BindDriverWithStoresState(
          listOfStoreOwnDeliveryPartners: event.listOfStoreOwnDeliveryPartners.toList(),
          listOfSelectedStoreOwnDeliveryPartners: event.listOfSelectedStoreOwnDeliveryPartners.toList(),
          storeEntities: event.storeEntities.toList(),
          message: 'Something went wrong, please try again',
          bindDriverToStoreStage: BindDriverToStoreStage.exception,
          listOfSelectedStoreEntities: event.listOfSelectedStoreEntities,
        ),
      );
    }
  }
}
