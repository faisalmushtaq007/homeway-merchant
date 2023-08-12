import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:homemakers_merchant/app/features/profile/common/profile_status_enum.dart';
import 'package:homemakers_merchant/app/features/profile/index.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/shared/states/data_source_state.dart';
import 'package:homemakers_merchant/utils/app_equatable/app_equatable.dart';
import 'package:homemakers_merchant/utils/app_log.dart';

part 'business_profile_event.dart';

part 'business_profile_state.dart';

class BusinessProfileBloc extends Bloc<BusinessProfileEvent, BusinessProfileState> {
  BusinessProfileBloc() : super(BusinessProfileInitial()) {
    on<SaveBusinessProfile>(_saveBusinessProfile);
    on<SaveBusinessType>(_saveBusinessType);
    on<GetBusinessType>(_getBusinessType);
    on<GetBusinessProfile>(_getBusinessProfile);
    on<DeleteBusinessProfile>(_deleteBusinessProfile);
    on<GetAllBusinessProfile>(_getAllBusinessProfile);
    on<DeleteAllBusinessProfile>(_deleteAllBusinessProfile);
    on<NavigateToAddressPage>(_navigateToAddressPage);
  }

  FutureOr<void> _saveBusinessProfile(SaveBusinessProfile event, Emitter<BusinessProfileState> emit) async {
    try {
      DataSourceState<BusinessProfileEntity> result;
      if (!event.hasEditBusinessProfile && event.currentIndex != -1) {
        result = await serviceLocator<EditBusinessProfileUseCase>()(id: event.businessProfileEntity.businessProfileID, input: event.businessProfileEntity);
      } else {
        result = await serviceLocator<SaveBusinessProfileUseCase>()(event.businessProfileEntity);
      }
      result.when(
        remote: (data, meta) {
          appLog.d('Profile bloc save remote ${data?.toMap()}');
          emit(
            SaveBusinessProfileState(
              businessProfileEntity: data ?? event.businessProfileEntity,
              hasEditBusinessProfile: event.hasEditBusinessProfile,
              businessProfileStatus: BusinessProfileStatus.saveBusinessType,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('Profile bloc save local ${data?.toMap()}');
          emit(
            SaveBusinessProfileState(
              businessProfileEntity: data ?? event.businessProfileEntity,
              hasEditBusinessProfile: event.hasEditBusinessProfile,
              businessProfileStatus: BusinessProfileStatus.saveBusinessType,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Profile bloc save error $reason');
          emit(
            BusinessProfileExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              businessProfileStatus: BusinessProfileStatus.saveBusinessType,
            ),
          );
        },
      );
      return;
    } catch (e, s) {
      appLog.e('Profile bloc save exception $e');
      emit(
        BusinessProfileExceptionState(
          message: 'Something went wrong during saving your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          businessProfileStatus: BusinessProfileStatus.saveBusinessType,
        ),
      );
    }
  }

  FutureOr<void> _saveBusinessType(SaveBusinessType event, Emitter<BusinessProfileState> emit) async {
    emit(
      SaveBusinessTypeState(
        businessTypeEntity: event.businessTypeEntity,
        businessProfileEntity: event.businessProfileEntity,
        hasEditBusinessType: event.hasEditBusinessType,
      ),
    );
    return;
  }

  FutureOr<void> _getBusinessType(GetBusinessType event, Emitter<BusinessProfileState> emit) async {}

  FutureOr<void> _getBusinessProfile(GetBusinessProfile event, Emitter<BusinessProfileState> emit) async {
    try {
      final DataSourceState<BusinessTypeEntity> result = await serviceLocator<GetBusinessProfileUseCase>()(
        input: event.businessProfileEntity,
        id: int.parse(event.businessProfileID),
      );
      result.when(
        remote: (data, meta) {
          appLog.d('Profile bloc edit remote ${data?.toMap()}');
          emit(
            GetBusinessProfileState(
              businessProfileEntity: data ?? event.businessProfileEntity,
              index: event.index,
              businessProfileID: event.businessProfileID,
              businessProfileStatus: BusinessProfileStatus.getBusinessProfile,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('Profile bloc edit local ${data?.toMap()}');
          emit(
            GetBusinessProfileState(
              businessProfileEntity: data ?? event.businessProfileEntity,
              index: event.index,
              businessProfileID: event.businessProfileID,
              businessProfileStatus: BusinessProfileStatus.getBusinessProfile,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Profile bloc edit error $reason');
          emit(
            BusinessProfileExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              businessProfileStatus: BusinessProfileStatus.getBusinessProfile,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Profile bloc get exception $e');
      emit(
        BusinessProfileExceptionState(
          message: 'Something went wrong during getting your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          businessProfileStatus: BusinessProfileStatus.getBusinessProfile,
        ),
      );
    }
  }

  FutureOr<void> _deleteBusinessProfile(DeleteBusinessProfile event, Emitter<BusinessProfileState> emit) async {
    try {
      final DataSourceState<bool> result = await serviceLocator<DeleteBusinessProfileUseCase>()(
        input: event.businessProfileEntity,
        id: int.parse(event.businessProfileID),
      );
      result.when(
        remote: (data, meta) {
          appLog.d('Profile bloc delete remote $data');
          emit(
            DeleteBusinessProfileState(
              businessProfileEntity: event.businessProfileEntity,
              index: event.index,
              businessProfileEntities: event.businessProfileEntities.toList(),
              businessProfileID: event.businessProfileID,
              hasDelete: data ?? false,
              businessProfileStatus: BusinessProfileStatus.deleteBusinessProfile,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('Profile bloc delete local $data');
          emit(
            DeleteBusinessProfileState(
              businessProfileEntity: event.businessProfileEntity,
              index: event.index,
              businessProfileEntities: event.businessProfileEntities.toList(),
              businessProfileID: event.businessProfileID,
              hasDelete: data ?? false,
              businessProfileStatus: BusinessProfileStatus.deleteBusinessProfile,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Profile bloc delete error $reason');
          emit(
            BusinessProfileExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              businessProfileStatus: BusinessProfileStatus.deleteBusinessProfile,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Profile bloc delete exception $e');
      emit(
        BusinessProfileExceptionState(
          message: 'Something went wrong during getting your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          businessProfileStatus: BusinessProfileStatus.deleteBusinessProfile,
        ),
      );
    }
  }

  FutureOr<void> _getAllBusinessProfile(GetAllBusinessProfile event, Emitter<BusinessProfileState> emit) async {
    try {
      emit(BusinessProfileLoadingState(message: 'Please wait while we are fetching your profile...'));
      final DataSourceState<List<BusinessProfileEntity>> result = await serviceLocator<GetAllBusinessProfileUseCase>()();
      result.when(
        remote: (data, meta) {
          appLog.d('Profile bloc get all remote');
          if (data == null || data.isEmpty) {
            emit(
              BusinessProfileEmptyState(
                message: 'Profile is empty',
                businessProfileEntities: [],
                businessProfileStatus: BusinessProfileStatus.getAllBusinessProfile,
              ),
            );
          } else {
            emit(
              GetAllBusinessProfileState(
                businessProfileEntities: data.toList(),
              ),
            );
          }
        },
        localDb: (data, meta) {
          appLog.d('Profile bloc get all local');
          if (data == null || data.isEmpty) {
            emit(
              BusinessProfileEmptyState(
                message: 'Profile is empty',
                businessProfileEntities: [],
                businessProfileStatus: BusinessProfileStatus.getAllBusinessProfile,
              ),
            );
          } else {
            emit(
              GetAllBusinessProfileState(
                businessProfileEntities: data.toList(),
              ),
            );
          }
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Profile bloc get all error $reason');
          emit(
            BusinessProfileExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              businessProfileStatus: BusinessProfileStatus.getAllBusinessProfile,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Profile bloc get all $e');
      emit(
        BusinessProfileExceptionState(
          message: 'Something went wrong during getting your all stores, please try again',
          //exception: e as Exception,
          stackTrace: s,
          businessProfileStatus: BusinessProfileStatus.getAllBusinessProfile,
        ),
      );
    }
  }

  FutureOr<void> _deleteAllBusinessProfile(DeleteAllBusinessProfile event, Emitter<BusinessProfileState> emit) async {
    try {
      final DataSourceState<bool> result = await serviceLocator<DeleteAllBusinessProfileUseCase>()();
      result.when(
        remote: (data, meta) {
          appLog.d('Profile bloc delete all remote $data');
          emit(
            DeleteAllBusinessProfileState(
              businessProfileEntities: [],
              hasDeleteAll: data ?? false,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('Profile bloc delete all local $data');
          emit(
            DeleteAllBusinessProfileState(
              businessProfileEntities: [],
              hasDeleteAll: data ?? false,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Profile bloc delete all error $reason');
          emit(
            BusinessProfileExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              businessProfileStatus: BusinessProfileStatus.deleteAllBusinessProfile,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Profile bloc delete all exception $e');
      emit(
        BusinessProfileExceptionState(
          message: 'Something went wrong during getting your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          businessProfileStatus: BusinessProfileStatus.deleteAllBusinessProfile,
        ),
      );
    }
  }

  FutureOr<void> _navigateToAddressPage(NavigateToAddressPage event, Emitter<BusinessProfileState> emit) async {
    emit(
      NavigateToAddressPageState(
        businessTypeEntity: event.businessTypeEntity,
        businessProfileEntity: event.businessProfileEntity,
      ),
    );
    return;
  }
}
