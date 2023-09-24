import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:homemakers_merchant/app/features/authentication/index.dart';
import 'package:homemakers_merchant/app/features/profile/index.dart';
import 'package:homemakers_merchant/app/features/store/common/store_enum.dart';
import 'package:homemakers_merchant/app/features/store/index.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/core/common/enum/generic_enum.dart';
import 'package:homemakers_merchant/core/extensions/global_extensions/dart_extensions.dart';
import 'package:homemakers_merchant/shared/states/data_source_state.dart';
import 'package:homemakers_merchant/utils/app_equatable/app_equatable.dart';
import 'package:homemakers_merchant/utils/app_log.dart';
import 'package:new_image_crop/extensions/template_extension.dart';

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
    on<UnBindDriverWithStores>(
      _unBindDriverWithStores,
      transformer: sequential(),
    );
    on<BindDriverWithUser>(
      _bindDriverWithUser,
      transformer: sequential(),
    );
    on<BindStoreWithUser>(
      _bindStoreWithUser,
      transformer: sequential(),
    );
    on<ReturnToStorePage>(
      _returnToStorePage,
      transformer: sequential(),
    );
    on<SelectDriversForStores>(
      _selectDriversForStores,
      transformer: sequential(),
    );
  }

  FutureOr<void> _saveStore(SaveStore event, Emitter<StoreState> emit) async {
    try {
      DataSourceState<StoreEntity> result;
      if (!event.hasNewStore && event.currentIndex != -1) {
        result = await serviceLocator<EditStoreUseCase>()(
            id: event.storeEntity.storeID, input: event.storeEntity);
      } else {
        result = await serviceLocator<SaveStoreUseCase>()(event.storeEntity);
      }
      result.when(
        remote: (data, meta) {
          appLog.d('Store bloc save remote ${data?.toMap()}');
          emit(
            SaveStoreState(
              storeEntity: data ?? event.storeEntity,
              hasNewStore: event.hasNewStore,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('Store bloc save local ${data?.toMap()}');
          emit(
            SaveStoreState(
              storeEntity: data ?? event.storeEntity,
              hasNewStore: event.hasNewStore,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace,
            exception, extra) {
          appLog.d('Store bloc save error $reason');
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
    } catch (e, s) {
      appLog.e('Store bloc save exception $e');
      emit(
        StoreExceptionState(
          message:
              'Something went wrong during saving your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          storeStateStage: StoreStateStage.createNewWithStore,
        ),
      );
    }
  }

  FutureOr<void> _getStore(GetStore event, Emitter<StoreState> emit) async {
    try {
      final DataSourceState<StoreEntity> result =
          await serviceLocator<GetStoreUseCase>()(
        input: event.storeEntity,
        id: event.storeID.isNotEmpty
            ? int.parse(event.storeID)
            : event.storeEntity?.storeID ?? -1,
      );
      result.when(
        remote: (data, meta) {
          appLog.d('Store bloc edit remote ${data?.toMap()}');
          emit(
            GetStoreState(
              storeEntity: data ?? event.storeEntity,
              index: event.index,
              storeEntities: event.storeEntities.toList(),
              storeID: event.storeID,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('Store bloc edit local ${data?.toMap()}');
          emit(
            GetStoreState(
              storeEntity: data ?? event.storeEntity,
              index: event.index,
              storeEntities: event.storeEntities.toList(),
              storeID: event.storeID,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace,
            exception, extra) {
          appLog.d('Store bloc edit error $reason');
          emit(
            StoreExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              storeStateStage: StoreStateStage.getStore,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Store bloc get exception $e');
      emit(
        StoreExceptionState(
          message:
              'Something went wrong during getting your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          storeStateStage: StoreStateStage.getStore,
        ),
      );
    }
  }

  FutureOr<void> _deleteStore(
      DeleteStore event, Emitter<StoreState> emit) async {
    try {
      final DataSourceState<bool> result =
          await serviceLocator<DeleteStoreUseCase>()(
        input: event.storeEntity,
        id: event.storeID.isNotEmpty
            ? int.parse(event.storeID)
            : event.storeEntity?.storeID ?? -1,
      );
      result.when(
        remote: (data, meta) {
          appLog.d('Store bloc delete remote $data');
          emit(
            DeleteStoreState(
              storeEntity: event.storeEntity,
              index: event.index,
              storeEntities: event.storeEntities.toList(),
              storeID: event.storeID,
              hasDelete: data ?? false,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('Store bloc delete local $data');
          emit(
            DeleteStoreState(
              storeEntity: event.storeEntity,
              index: event.index,
              storeEntities: event.storeEntities.toList(),
              storeID: event.storeID,
              hasDelete: data ?? false,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace,
            exception, extra) {
          appLog.d('Store bloc delete error $reason');
          emit(
            StoreExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              storeStateStage: StoreStateStage.delete,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Store bloc delete exception $e');
      emit(
        StoreExceptionState(
          message:
              'Something went wrong during getting your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          storeStateStage: StoreStateStage.delete,
        ),
      );
    }
  }

  FutureOr<void> _deleteAllStore(
      DeleteAllStore event, Emitter<StoreState> emit) async {
    try {
      final DataSourceState<bool> result =
          await serviceLocator<DeleteAllStoreUseCase>()();
      result.when(
        remote: (data, meta) {
          appLog.d('Store bloc delete all remote $data');
          emit(
            DeleteAllStoreState(
              storeEntities: [],
              hasDeleteAll: data ?? false,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('Store bloc delete all local $data');
          emit(
            DeleteAllStoreState(
              storeEntities: [],
              hasDeleteAll: data ?? false,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace,
            exception, extra) {
          appLog.d('Store bloc delete all error $reason');
          emit(
            StoreExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              storeStateStage: StoreStateStage.deleteAll,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Store bloc delete all exception $e');
      emit(
        StoreExceptionState(
          message:
              'Something went wrong during getting your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          storeStateStage: StoreStateStage.deleteAll,
        ),
      );
    }
  }

  FutureOr<void> _getAllStore(
      GetAllStore event, Emitter<StoreState> emit) async {
    try {
      emit(StoreLoadingState(
          isLoading: true,
          message: 'Please wait while we are fetching your store...'));
      final DataSourceState<List<StoreEntity>> result =
          await serviceLocator<GetAllStoreUseCase>()();
      result.when(
        remote: (data, meta) {
          appLog.d('Store bloc get all remote');
          if (data == null || data.isEmpty) {
            emit(
              GetEmptyStoreState(message: 'Store is empty', storeEntities: []),
            );
          } else {
            emit(
              GetAllStoreState(
                storeEntities: data.toList(),
              ),
            );
          }
        },
        localDb: (data, meta) {
          appLog.d('Store bloc get all local');
          if (data == null || data.isEmpty) {
            emit(
              GetEmptyStoreState(message: 'Store is empty', storeEntities: []),
            );
          } else {
            emit(
              GetAllStoreState(
                storeEntities: data.toList(),
              ),
            );
          }
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace,
            exception, extra) {
          appLog.d('Store bloc get all error $reason');
          emit(
            StoreExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              storeStateStage: StoreStateStage.getAllStore,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Store bloc get all $e');
      emit(
        StoreExceptionState(
          message:
              'Something went wrong during getting your all stores, please try again',
          //exception: e as Exception,
          stackTrace: s,
          storeStateStage: StoreStateStage.getAllStore,
        ),
      );
    }
  }

  FutureOr<void> _saveDriver(SaveDriver event, Emitter<StoreState> emit) async {
    try {
      DataSourceState<StoreOwnDeliveryPartnersInfo> result;
      if (!event.haveNewDriver && event.currentIndex != -1) {
        result = await serviceLocator<EditDriverUseCase>()(
          id: event.storeOwnDeliveryPartnerEntity.driverID,
          input: event.storeOwnDeliveryPartnerEntity,
        );
      } else {
        result = await serviceLocator<SaveDriverUseCase>()(
            event.storeOwnDeliveryPartnerEntity);
      }
      await result.when(
        remote: (data, meta) async {
          appLog.d('Driver bloc save remote ${data?.toMap()}');
          emit(
            SaveDriverState(
                storeOwnDeliveryPartnerEntity: data!,
                hasNewDriver: event.haveNewDriver,
                driverStateStage: DriverStateStage.success),
          );
          await Future.delayed(const Duration(milliseconds: 500), () {
            serviceLocator.resetLazySingleton<StoreOwnDeliveryPartnersInfo>();
          });
          emit(
            NavigateToNewDriverGreetingPageState(
                storeOwnDeliveryPartnerEntity: data,
                hasNewDriver: event.haveNewDriver,
                driverStateStage: DriverStateStage.success),
          );
        },
        localDb: (data, meta) async {
          appLog.d('Driver bloc save local ${data?.toMap()}');
          emit(
            SaveDriverState(
                storeOwnDeliveryPartnerEntity: data!,
                hasNewDriver: event.haveNewDriver,
                driverStateStage: DriverStateStage.success),
          );
          await Future.delayed(const Duration(milliseconds: 500), () {
            serviceLocator.resetLazySingleton<StoreOwnDeliveryPartnersInfo>();
          });
          emit(
            NavigateToNewDriverGreetingPageState(
                storeOwnDeliveryPartnerEntity: data,
                hasNewDriver: event.haveNewDriver,
                driverStateStage: DriverStateStage.success),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace,
            exception, extra) {
          appLog.d('Driver bloc save error $reason');
          emit(
            DriverExceptionState(
                message: reason,
                //exception: e as Exception,
                stackTrace: stackTrace,
                driverStateStage: DriverStateStage.saveDriver),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Driver bloc save exception $e');
      emit(
        DriverExceptionState(
            message:
                'Something went wrong during saving your store details, please try again',
            //exception: e as Exception,
            stackTrace: s,
            driverStateStage: DriverStateStage.saveDriver),
      );
    }
  }

  FutureOr<void> _deleteDriver(
      DeleteDriver event, Emitter<StoreState> emit) async {
    try {
      final DataSourceState<bool> result =
          await serviceLocator<DeleteDriverUseCase>()(
        input: event.storeOwnDeliveryPartnerEntity,
        id: event.driverID.isNotEmpty
            ? int.parse(event.driverID)
            : event.storeOwnDeliveryPartnerEntity?.driverID ?? -1,
      );
      result.when(
        remote: (data, meta) {
          appLog.d('Driver bloc delete remote $data');
          emit(
            DeleteDriverState(
              storeOwnDeliveryPartnerEntity:
                  event.storeOwnDeliveryPartnerEntity,
              index: event.index,
              storeOwnDeliveryPartnerEntities:
                  event.storeOwnDeliveryPartnerEntities.toList(),
              driverID: event.driverID,
              hasDelete: data ?? false,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('Driver bloc delete local $data');
          emit(
            DeleteDriverState(
              storeOwnDeliveryPartnerEntity:
                  event.storeOwnDeliveryPartnerEntity,
              index: event.index,
              storeOwnDeliveryPartnerEntities:
                  event.storeOwnDeliveryPartnerEntities.toList(),
              driverID: event.driverID,
              hasDelete: data ?? false,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace,
            exception, extra) {
          appLog.d('Driver bloc delete error $reason');
          emit(
            DriverExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              driverStateStage: DriverStateStage.deleteDriver,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Driver bloc delete exception $e');
      emit(
        DriverExceptionState(
          message:
              'Something went wrong during getting your all drivers, please try again',
          //exception: e as Exception,
          stackTrace: s,
          driverStateStage: DriverStateStage.deleteDriver,
        ),
      );
    }
  }

  FutureOr<void> _deleteAllDriver(
      DeleteAllDriver event, Emitter<StoreState> emit) async {
    try {
      final DataSourceState<bool> result =
          await serviceLocator<DeleteAllDriverUseCase>()();
      result.when(
        remote: (data, meta) {
          appLog.d('Driver bloc delete all remote $data');
          emit(
            DeleteAllDriverState(
              message: 'Driver is empty',
              storeOwnDeliveryPartnerEntities: [],
              hasDeleteAll: data ?? false,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('Driver bloc delete all local $data');
          emit(
            DeleteAllDriverState(
              message: 'Driver is empty',
              storeOwnDeliveryPartnerEntities: [],
              hasDeleteAll: data ?? false,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace,
            exception, extra) {
          appLog.d('Driver bloc delete all error $reason');
          emit(
            DriverExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              driverStateStage: DriverStateStage.deleteAllDriver,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Driver bloc delete all exception $e');
      emit(
        DriverExceptionState(
          message:
              'Something went wrong during getting your all drivers, please try again',
          //exception: e as Exception,
          stackTrace: s,
          driverStateStage: DriverStateStage.deleteAllDriver,
        ),
      );
    }
  }

  FutureOr<void> _getAllDriver(
      GetAllDriver event, Emitter<StoreState> emit) async {
    try {
      emit(
        DriverLoadingState(
          isLoading: true,
          message: 'Please wait while we are fetching your drivers...',
          driverStateStage: DriverStateStage.getAllDriver,
        ),
      );
      final DataSourceState<List<StoreOwnDeliveryPartnersInfo>> result =
          await serviceLocator<GetAllDriverUseCase>()();
      result.when(
        remote: (data, meta) {
          appLog.d('Driver bloc get all remote');
          if (data == null || data.isEmpty) {
            emit(
              DriverEmptyState(
                message: 'Driver is empty',
                storeOwnDeliveryPartnerEntities: [],
                isEmpty: true,
              ),
            );
          } else {
            emit(
              GetAllDriverState(
                storeOwnDeliveryPartnerEntities: data.toList(),
              ),
            );
          }
        },
        localDb: (data, meta) {
          appLog.d('Driver bloc get all local');
          if (data == null || data.isEmpty) {
            emit(
              DriverEmptyState(
                message: 'Driver is empty',
                storeOwnDeliveryPartnerEntities: [],
                isEmpty: true,
              ),
            );
          } else {
            emit(
              GetAllDriverState(
                storeOwnDeliveryPartnerEntities: data.toList(),
              ),
            );
          }
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace,
            exception, extra) {
          appLog.d('Driver bloc get all error $reason');
          emit(
            DriverExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              driverStateStage: DriverStateStage.getAllDriver,
            ),
          );
        },
      );
    } catch (e, s) {
      emit(
        DriverExceptionState(
          message:
              'Something went wrong during getting your all drivers, please try again',
          //exception: e as Exception,
          stackTrace: s,
          driverStateStage: DriverStateStage.getAllDriver,
        ),
      );
    }
  }

  FutureOr<void> _getDriver(GetDriver event, Emitter<StoreState> emit) async {
    try {
      final DataSourceState<StoreOwnDeliveryPartnersInfo> result =
          await serviceLocator<GetDriverUseCase>()(
        input: event.storeOwnDeliveryPartnerEntity,
        id: event.driverID.isNotEmpty
            ? int.parse(event.driverID)
            : event.storeOwnDeliveryPartnerEntity?.driverID ?? -1,
      );
      result.when(
        remote: (data, meta) {
          appLog.d('Driver bloc edit remote ${data?.toMap()}');
          emit(
            GetDriverState(
              storeOwnDeliveryPartnerEntity:
                  data ?? event.storeOwnDeliveryPartnerEntity,
              index: event.index,
              storeOwnDeliveryPartnerEntities:
                  event.storeOwnDeliveryPartnerEntities.toList(),
              driverID: event.driverID,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('Driver bloc edit local ${data?.toMap()}');
          emit(
            GetDriverState(
              storeOwnDeliveryPartnerEntity:
                  data ?? event.storeOwnDeliveryPartnerEntity,
              index: event.index,
              storeOwnDeliveryPartnerEntities:
                  event.storeOwnDeliveryPartnerEntities.toList(),
              driverID: event.driverID,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace,
            exception, extra) {
          appLog.d('Driver bloc edit error $reason');
          emit(
            DriverExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              driverStateStage: DriverStateStage.getDriver,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Driver bloc edit exception $e');
      emit(
        DriverExceptionState(
          message:
              'Something went wrong during getting your all drivers, please try again',
          //exception: e as Exception,
          stackTrace: s,
          driverStateStage: DriverStateStage.getDriver,
        ),
      );
    }
  }

  FutureOr<void> _bindDriverWithStores(
      BindDriverWithStores event, Emitter<StoreState> emit) async {
    try {
      final DataSourceState<List<StoreEntity>> result =
          await serviceLocator<BindDriverWithStoreUseCase>()(
        destination: event.listOfSelectedStoreEntities,
        source: event.listOfSelectedStoreOwnDeliveryPartners,
      );
      result.when(
        remote: (data, meta) {
          appLog.d('Binding Driver with Store remote ${data?.length}');
          emit(
            BindDriverWithStoresState(
              bindDriverToStoreStage: event.bindDriverToStoreStage,
              listOfSelectedStoreEntities: event.listOfSelectedStoreEntities,
              listOfSelectedStoreOwnDeliveryPartners:
                  event.listOfSelectedStoreOwnDeliveryPartners,
              listOfStoreOwnDeliveryPartners:
                  event.listOfStoreOwnDeliveryPartners,
              message: event.message,
              storeEntities: data ?? event.storeEntities,
              storeStateStatus: StoreStateStage.bindDriverWithStores,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('Binding Driver with Store local ${data?.length}');
          emit(
            BindDriverWithStoresState(
              bindDriverToStoreStage: event.bindDriverToStoreStage,
              listOfSelectedStoreEntities: event.listOfSelectedStoreEntities,
              listOfSelectedStoreOwnDeliveryPartners:
                  event.listOfSelectedStoreOwnDeliveryPartners,
              listOfStoreOwnDeliveryPartners:
                  event.listOfStoreOwnDeliveryPartners,
              message: event.message,
              storeEntities: data ?? event.storeEntities,
              storeStateStatus: StoreStateStage.bindDriverWithStores,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace,
            exception, extra) {
          appLog.d('Binding Driver with Store error $reason');
          emit(
            BindExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              bindDriverToStoreStage: BindingStage.bindingDriverWithStore,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Binding Driver with Store exception $e');
      emit(
        BindExceptionState(
          message:
              'Something went wrong during getting your all drivers, please try again',
          //exception: e as Exception,
          stackTrace: s,
          bindDriverToStoreStage: BindingStage.bindingDriverWithStore,
        ),
      );
    }
  }

  FutureOr<void> _bindDriverWithUser(
      BindDriverWithUser event, Emitter<StoreState> emit) async {
    try {
      // Todo(prasant): Check and get current user, skipt it now
      final DataSourceState<List<AppUserEntity>> getAllUserCase =
          await serviceLocator<GetAllAppUserUseCase>()();
      AppUserEntity appUserEntity = AppUserEntity();
      getAllUserCase.when(
        remote: (data, meta) {
          if (data.isNotNullOrEmpty) {
            appUserEntity = data![0];
          }
        },
        localDb: (data, meta) {
          if (data.isNotNullOrEmpty) {
            appUserEntity = data![0];
          }
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace,
            exception, extra) {
          emit(
            BindFailedState(
              message:
                  'Something went wrong during getting your all user or current user, please try again',
              //exception: e as Exception,
              bindDriverToStoreStage: BindingStage.bindingDriverWithUser,
            ),
          );
        },
      );
      if (appUserEntity.userID != -1) {
        emit(
          BindFailedState(
            message:
                'Something went wrong during getting your all user or current user, please try again',
            //exception: e as Exception,
            bindDriverToStoreStage: BindingStage.bindingDriverWithUser,
          ),
        );
      } else {
        final DataSourceState<AppUserEntity> result =
            await serviceLocator<BindDriverWithUserUseCase>()(
          destination: appUserEntity,
          source: event.listOfSelectedStoreOwnDeliveryPartners,
        );
        result.when(
          remote: (data, meta) {
            appLog.d('Binding Driver with user remote ${data?.userID}');
            emit(
              BindDriverWithUserState(
                listOfSelectedStoreOwnDeliveryPartners:
                    event.listOfSelectedStoreOwnDeliveryPartners,
                message: event.message,
                listOfStoreOwnDeliveryPartners:
                    event.listOfStoreOwnDeliveryPartners,
                storeStateStatus: StoreStateStage.bindingWithUser,
                appUserEntity: data ?? appUserEntity,
                bindingStage: BindingStage.bindingDriverWithUser,
              ),
            );
          },
          localDb: (data, meta) {
            appLog.d('Binding Driver with user local ${data?.userID}');
            emit(
              BindDriverWithUserState(
                listOfSelectedStoreOwnDeliveryPartners:
                    event.listOfSelectedStoreOwnDeliveryPartners,
                message: event.message,
                listOfStoreOwnDeliveryPartners:
                    event.listOfStoreOwnDeliveryPartners,
                storeStateStatus: StoreStateStage.bindingWithUser,
                appUserEntity: data ?? appUserEntity,
                bindingStage: BindingStage.bindingDriverWithUser,
              ),
            );
          },
          error: (dataSourceFailure, reason, error, networkException,
              stackTrace, exception, extra) {
            appLog.d('Binding Driver with user error $reason');
            emit(
              BindExceptionState(
                message: reason,
                //exception: e as Exception,
                stackTrace: stackTrace,
                bindDriverToStoreStage: BindingStage.bindingDriverWithUser,
              ),
            );
          },
        );
      }
    } catch (e, s) {
      appLog.e('Binding Driver with store exception $e');
      emit(
        BindExceptionState(
          message:
              'Something went wrong during binding driver with store, please try again',
          //exception: e as Exception,
          stackTrace: s,
          bindDriverToStoreStage: BindingStage.bindingDriverWithUser,
        ),
      );
    }
  }

  FutureOr<void> _bindStoreWithUser(
      BindStoreWithUser event, Emitter<StoreState> emit) async {
    try {
      // Todo(prasant): Check and get current user, skipt it now
      final DataSourceState<List<AppUserEntity>> getAllUserCase =
          await serviceLocator<GetAllAppUserUseCase>()();
      AppUserEntity appUserEntity = AppUserEntity();
      getAllUserCase.when(
        remote: (data, meta) {
          if (data.isNotNullOrEmpty) {
            appUserEntity = data![0];
          }
        },
        localDb: (data, meta) {
          if (data.isNotNullOrEmpty) {
            appUserEntity = data![0];
          }
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace,
            exception, extra) {
          emit(
            BindFailedState(
              message:
                  'Something went wrong during getting your all user or current user, please try again',
              //exception: e as Exception,
              bindDriverToStoreStage: BindingStage.bindingWithUser,
            ),
          );
        },
      );
      if (appUserEntity.userID != -1) {
        emit(
          BindFailedState(
            message:
                'Something went wrong during getting your all user or current user, please try again',
            //exception: e as Exception,
            bindDriverToStoreStage: BindingStage.bindingWithUser,
          ),
        );
      } else {
        final DataSourceState<AppUserEntity> result =
            await serviceLocator<BindStoreWithUserUseCase>()(
          destination: appUserEntity,
          source: event.listOfSelectedStoreEntities,
        );
        result.when(
          remote: (data, meta) {
            appLog.d('Binding store with user remote ${data?.userID}');
            emit(
              BindStoreWithUserState(
                listOfSelectedStoreEntities: event.listOfSelectedStoreEntities,
                message: event.message,
                storeEntities: event.storeEntities,
                storeStateStatus: StoreStateStage.bindingWithUser,
                appUserEntity: data ?? appUserEntity,
                bindingStage: BindingStage.bindingWithUser,
              ),
            );
          },
          localDb: (data, meta) {
            appLog.d('Binding store with user local ${data?.userID}');
            emit(
              BindStoreWithUserState(
                listOfSelectedStoreEntities: event.listOfSelectedStoreEntities,
                message: event.message,
                storeEntities: event.storeEntities,
                storeStateStatus: StoreStateStage.bindingWithUser,
                appUserEntity: data ?? appUserEntity,
                bindingStage: BindingStage.bindingWithUser,
              ),
            );
          },
          error: (dataSourceFailure, reason, error, networkException,
              stackTrace, exception, extra) {
            appLog.d('Binding store with user error $reason');
            emit(
              BindExceptionState(
                message: reason,
                //exception: e as Exception,
                stackTrace: stackTrace,
                bindDriverToStoreStage: BindingStage.bindingDriverWithStore,
              ),
            );
          },
        );
      }
    } catch (e, s) {
      appLog.e('Binding store with user exception $e');
      emit(
        BindExceptionState(
          message:
              'Something went wrong during binding store with user, please try again',
          //exception: e as Exception,
          stackTrace: s,
          bindDriverToStoreStage: BindingStage.bindingWithUser,
        ),
      );
    }
  }

  FutureOr<void> _returnToStorePage(
      ReturnToStorePage event, Emitter<StoreState> emit) async {
    emit(
      ReturnToStorePageState(
        message:
            'Driver ${event.listOfStoreOwnDeliveryPartners.length} is selected by you',
        listOfStoreOwnDeliveryPartners:
            event.listOfStoreOwnDeliveryPartners.toList(),
      ),
    );
  }

  FutureOr<void> _selectDriversForStores(
      SelectDriversForStores event, Emitter<StoreState> emit) async {
    emit(
      SelectDriversForStoresState(
        message:
            'Driver ${event.listOfStoreOwnDeliveryPartners.length} is selected for store',
        listOfStoreOwnDeliveryPartners:
            event.listOfStoreOwnDeliveryPartners.toList(),
        listOfSelectedStoreOwnDeliveryPartners:
            event.listOfSelectedStoreOwnDeliveryPartners.toList(),
        selectItemUseCase: event.selectItemUseCase,
      ),
    );
  }

  FutureOr<void> _unBindDriverWithStores(
      UnBindDriverWithStores event, Emitter<StoreState> emit) async {
    try {
      final DataSourceState<List<StoreEntity>> result =
          await serviceLocator<UnBindDriverWithStoreUseCase>()(
        destination: event.listOfSelectedStoreEntities,
        source: event.listOfSelectedStoreOwnDeliveryPartners,
      );
      result.when(
        remote: (data, meta) {
          appLog.d('UnBinding Driver with Store remote ${data?.length}');
          emit(
            UnBindDriverWithStoresState(
              bindDriverToStoreStage: event.bindDriverToStoreStage,
              listOfSelectedStoreEntities: event.listOfSelectedStoreEntities,
              listOfSelectedStoreOwnDeliveryPartners:
                  event.listOfSelectedStoreOwnDeliveryPartners,
              listOfStoreOwnDeliveryPartners:
                  event.listOfStoreOwnDeliveryPartners,
              message: event.message,
              storeEntities: data ?? event.storeEntities,
              storeStateStatus: StoreStateStage.bindDriverWithStores,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('UnBinding Driver with Store local ${data?.length}');
          emit(
            UnBindDriverWithStoresState(
              bindDriverToStoreStage: event.bindDriverToStoreStage,
              listOfSelectedStoreEntities: event.listOfSelectedStoreEntities,
              listOfSelectedStoreOwnDeliveryPartners:
                  event.listOfSelectedStoreOwnDeliveryPartners,
              listOfStoreOwnDeliveryPartners:
                  event.listOfStoreOwnDeliveryPartners,
              message: event.message,
              storeEntities: data ?? event.storeEntities,
              storeStateStatus: StoreStateStage.bindDriverWithStores,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace,
            exception, extra) {
          appLog.d('UnBinding Driver with Store error $reason');
          emit(
            BindExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              bindDriverToStoreStage: BindingStage.bindingDriverWithStore,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('UnBinding Driver with Store exception $e');
      emit(
        BindExceptionState(
          message:
              'Something went wrong during getting your all drivers, please try again',
          //exception: e as Exception,
          stackTrace: s,
          bindDriverToStoreStage: BindingStage.bindingDriverWithStore,
        ),
      );
    }
  }
}
