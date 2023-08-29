import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:homemakers_merchant/app/features/address/index.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/shared/states/data_source_state.dart';
import 'package:homemakers_merchant/utils/app_equatable/app_equatable.dart';
import 'package:homemakers_merchant/utils/app_log.dart';
import 'package:sembast/timestamp.dart';

part 'address_event.dart';

part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressInitial()) {
    on<SaveAddress>(
      _saveAddress,
      transformer: concurrent(),
    );
    on<GetAddressByID>(
      _getAddress,
      transformer: concurrent(),
    );
    on<RemoveAddressByID>(
      _deleteAddress,
      transformer: concurrent(),
    );
    on<GetAllAddress>(
      _getAllAddress,
      transformer: concurrent(),
    );
    on<RemoveAllAddress>(
      _deleteAllAddress,
      transformer: concurrent(),
    );
    on<SelectAllAddress>(
      _selectAllAddress,
      transformer: concurrent(),
    );
    on<SelectDefaultAddress>(
      _selectDefaultAddress,
      transformer: concurrent(),
    );
    on<ConfirmationOnDefaultAddress>(
      _confirmationOnDefaultAddress,
      transformer: concurrent(),
    );
    on<SelectCurrentAddress>(
      _selectCurrentAddress,
      transformer: concurrent(),
    );
    on<GetAllAddressPagination>(
      _getAllAddressPagination,
      transformer: concurrent(),
    );
    //on<SaveAllAddress>(_saveAllAddress);
  }

  FutureOr<void> _saveAddress(SaveAddress event, Emitter<AddressState> emit) async {
    try {
      DataSourceState<AddressModel> result;
      if (!event.hasNewAddress) {
        result = await serviceLocator<EditAddressUseCase>()(id: event.addressEntity.addressID, input: event.addressEntity);
      } else {
        result = await serviceLocator<SaveAddressUseCase>()(event.addressEntity);
      }
      result.when(
        remote: (data, meta) {
          appLog.d('Address bloc save remote ${data?.toMap()}');
          emit(
            SaveAddressState(
              addressEntity: data ?? event.addressEntity,
              hasNewAddress: event.hasNewAddress,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('Address bloc save local ${data?.toMap()}');
          emit(
            SaveAddressState(
              addressEntity: data ?? event.addressEntity,
              hasNewAddress: event.hasNewAddress,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Address bloc save error $reason');
          emit(
            AddressExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              addressStatus: AddressStatus.saveAddress,
            ),
          );
        },
      );
      return;
    } catch (e, s) {
      appLog.e('Address bloc save exception $e');
      emit(
        AddressExceptionState(
          message: 'Something went wrong during saving your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          addressStatus: AddressStatus.saveAddress,
        ),
      );
    }
  }

  FutureOr<void> _getAddress(GetAddressByID event, Emitter<AddressState> emit) async {
    try {
      final DataSourceState<AddressModel> result = await serviceLocator<GetAddressUseCase>()(
        input: event.addressEntity,
        id: event.addressID,
      );
      result.when(
        remote: (data, meta) {
          appLog.d('Address bloc edit remote ${data?.toMap()}');
          emit(
            GetAddressByIDState(
              addressEntity: data ?? event.addressEntity,
              index: event.index,
              addressID: event.addressID,
              addressStatus: AddressStatus.getAddress,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('Address bloc edit local ${data?.toMap()}');
          emit(
            GetAddressByIDState(
              addressEntity: data ?? event.addressEntity,
              index: event.index,
              addressID: event.addressID,
              addressStatus: AddressStatus.getAddress,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Address bloc edit error $reason');
          emit(
            AddressExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              addressStatus: AddressStatus.getAddress,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Address bloc get exception $e');
      emit(
        AddressExceptionState(
          message: 'Something went wrong during getting your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          addressStatus: AddressStatus.getAddress,
        ),
      );
    }
  }

  FutureOr<void> _deleteAddress(RemoveAddressByID event, Emitter<AddressState> emit) async {
    try {
      final DataSourceState<bool> result = await serviceLocator<DeleteAddressUseCase>()(
        input: event.addressEntity,
        id: event.addressID,
      );
      result.when(
        remote: (data, meta) {
          appLog.d('Address bloc delete remote $data');
          emit(
            RemoveAddressByIDState(
              addressEntity: event.addressEntity,
              index: event.index,
              addressEntities: event.addressEntities.toList(),
              addressID: event.addressID,
              hasRemove: data ?? false,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('Address bloc delete local $data');
          emit(
            RemoveAddressByIDState(
              addressEntity: event.addressEntity,
              index: event.index,
              addressEntities: event.addressEntities.toList(),
              addressID: event.addressID,
              hasRemove: data ?? false,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Address bloc delete error $reason');
          emit(
            AddressExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              addressStatus: AddressStatus.deleteAddress,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Address bloc delete exception $e');
      emit(
        AddressExceptionState(
          message: 'Something went wrong during getting your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          addressStatus: AddressStatus.deleteAddress,
        ),
      );
    }
  }

  FutureOr<void> _getAllAddress(GetAllAddress event, Emitter<AddressState> emit) async {
    try {
      emit(AddressLoadingState(
        message: 'Please wait while we are fetching your profile...',
      ));
      final DataSourceState<List<AddressModel>> result = await serviceLocator<GetAllAddressUseCase>()();
      result.when(
        remote: (data, meta) {
          appLog.d('Address bloc get all remote');
          if (data == null || data.isEmpty) {
            emit(
              AddressEmptyState(
                message: 'Address is empty',
                addressEntities: [],
                addressStatus: AddressStatus.getAllAddress,
              ),
            );
          } else {
            emit(
              GetAllAddressState(
                addressEntities: data.toList(),
              ),
            );
          }
        },
        localDb: (data, meta) {
          appLog.d('Address bloc get all local');
          if (data == null || data.isEmpty) {
            emit(
              AddressEmptyState(
                message: 'Address is empty',
                addressEntities: [],
                addressStatus: AddressStatus.getAllAddress,
              ),
            );
          } else {
            emit(
              GetAllAddressState(
                addressEntities: data.toList(),
              ),
            );
          }
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Address bloc get all error $reason');
          emit(
            AddressExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              addressStatus: AddressStatus.getAllAddress,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Address bloc get all $e');
      emit(
        AddressExceptionState(
          message: 'Something went wrong during getting your all stores, please try again',
          //exception: e as Exception,
          stackTrace: s,
          addressStatus: AddressStatus.getAllAddress,
        ),
      );
    }
  }

  FutureOr<void> _deleteAllAddress(RemoveAllAddress event, Emitter<AddressState> emit) async {
    try {
      final DataSourceState<bool> result = await serviceLocator<DeleteAllAddressUseCase>()();
      result.when(
        remote: (data, meta) {
          appLog.d('Address bloc delete all remote $data');
          emit(
            RemoveAllAddressState(
              addressEntities: [],
              hasRemoveAll: data ?? false,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('Address bloc delete all local $data');
          emit(
            RemoveAllAddressState(
              addressEntities: [],
              hasRemoveAll: data ?? false,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Address bloc delete all error $reason');
          emit(
            AddressExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              addressStatus: AddressStatus.deleteAllAddress,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Address bloc delete all exception $e');
      emit(
        AddressExceptionState(
          message: 'Something went wrong during getting your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          addressStatus: AddressStatus.deleteAllAddress,
        ),
      );
    }
  }

  FutureOr<void> _selectAllAddress(SelectAllAddress event, Emitter<AddressState> emit) {}

  FutureOr<void> _selectDefaultAddress(SelectDefaultAddress event, Emitter<AddressState> emit) {}

  FutureOr<void> _confirmationOnDefaultAddress(ConfirmationOnDefaultAddress event, Emitter<AddressState> emit) {}

  FutureOr<void> _selectCurrentAddress(SelectCurrentAddress event, Emitter<AddressState> emit) {}

  FutureOr<void> _getAllAddressPagination(GetAllAddressPagination event, Emitter<AddressState> emit) async {
    try {
      emit(GetAllLoadingAddressPaginationState(isLoading: true, message: 'Please wait while we are fetching all address...'));
      final DataSourceState<List<AddressModel>> result = await serviceLocator<GetAllAddressPaginationUseCase>()(
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
          appLog.d('Get all address bloc get all remote');
          if (data == null || data.isEmpty) {
            emit(
              GetAllEmptyAddressPaginationState(
                message: 'All address is empty',
                addressEntities: [],
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
              GetAllAddressPaginationState(
                addressEntities: data.toList(),
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
          appLog.d('Get all order bloc get all local');
          if (data == null || data.isEmpty) {
            emit(
              GetAllEmptyAddressPaginationState(
                message: 'All address is empty',
                addressEntities: [],
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
              GetAllAddressPaginationState(
                addressEntities: data.toList(),
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
          appLog.d('Get all address bloc get all error $reason');
          emit(
            GetAllExceptionAddressPaginationState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Get all address bloc get all $e');
      emit(
        GetAllExceptionAddressPaginationState(
          message: 'Something went wrong during getting all address, please try again',
          //exception: e as Exception,
          stackTrace: s,
        ),
      );
    }
  }
}
