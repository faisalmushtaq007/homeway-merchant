import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homemakers_merchant/app/features/authentication/index.dart';
import 'package:homemakers_merchant/app/features/profile/index.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/core/extensions/global_extensions/list_ext.dart';
import 'package:homemakers_merchant/core/extensions/global_extensions/src/object.dart';
import 'package:homemakers_merchant/shared/states/data_source_state.dart';
import 'package:homemakers_merchant/utils/app_equatable/app_equatable.dart';
import 'package:homemakers_merchant/utils/app_log.dart';
import 'package:sembast/timestamp.dart';

part 'business_profile_event.dart';

part 'business_profile_state.dart';

class BusinessProfileBloc
    extends Bloc<BusinessProfileEvent, BusinessProfileState> {
  BusinessProfileBloc() : super(const BusinessProfileInitial()) {
    on<SaveBusinessProfile>(_saveBusinessProfile);
    on<SaveBusinessType>(_saveBusinessType);
    on<GetBusinessType>(_getBusinessType);
    on<GetBusinessProfile>(_getBusinessProfile);
    on<DeleteBusinessProfile>(_deleteBusinessProfile);
    on<GetAllBusinessProfile>(_getAllBusinessProfile);
    on<DeleteAllBusinessProfile>(_deleteAllBusinessProfile);
    on<NavigateToAddressPage>(_navigateToAddressPage);
    on<GetCurrentUserProfile>(_getCurrentUserProfile);
    on<GetAllBusinessProfilePagination>(_getAllBusinessProfilePagination);
    on<GetAllAppUserProfilePagination>(_getAllAppUserProfilePagination);
  }

  FutureOr<void> _saveBusinessProfile(
      SaveBusinessProfile event, Emitter<BusinessProfileState> emit) async {
    /*try {*/
    DataSourceState<BusinessProfileEntity> result;
    int currentStage=event.hasSaveBusinessType ? 2 : 1;
    if (event.hasEditBusinessProfile || event.hasSaveBusinessType) {
      currentStage=serviceLocator<AppUserEntity>().currentUserStage;
      result = await serviceLocator<EditBusinessProfileUseCase>()(
          id: event.businessProfileEntity.businessProfileID,
          input: event.businessProfileEntity);
    } else {
      currentStage=event.hasSaveBusinessType ? 2 : 1;
      result = await serviceLocator<SaveBusinessProfileUseCase>()(
          event.businessProfileEntity);
    }
    await result.when(
      remote: (data, meta) async {
        appLog.d('Profile bloc save remote ${data?.businessProfileID}');
        if (data != null) {
          await updateUserProfile(data, currentStage);
        }
        await Future.delayed(const Duration(milliseconds: 500), () {});
        emit(
          SaveBusinessProfileState(
            businessProfileEntity: data ?? event.businessProfileEntity,
            hasEditBusinessProfile: event.hasEditBusinessProfile,
            businessProfileStatus: BusinessProfileStatus.saveBusinessProfile,
            hasSaveBusinessType: event.hasSaveBusinessType,
          ),
        );
      },
      localDb: (data, meta) async {
        appLog.d('Profile bloc save local ${data?.businessProfileID}');
        if (data != null) {
          await updateUserProfile(data, currentStage);
        }
        await Future.delayed(const Duration(milliseconds: 500), () {});
        emit(
          SaveBusinessProfileState(
            businessProfileEntity: data ?? event.businessProfileEntity,
            hasEditBusinessProfile: event.hasEditBusinessProfile,
            businessProfileStatus: BusinessProfileStatus.saveBusinessProfile,
            hasSaveBusinessType: event.hasSaveBusinessType,
          ),
        );
      },
      error: (dataSourceFailure, reason, error, networkException, stackTrace,
          exception, extra) {
        appLog.d('Profile bloc save error $reason');
        emit(
          BusinessProfileExceptionState(
            message: reason,
            //exception: e as Exception,
            stackTrace: stackTrace,
            businessProfileStatus: BusinessProfileStatus.saveBusinessProfile,
          ),
        );
      },
    );
/*    } catch (e, s) {
      appLog.e('Profile bloc save exception $e');
      emit(
        BusinessProfileExceptionState(
          message: 'Something went wrong during saving your profile details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          businessProfileStatus: BusinessProfileStatus.saveBusinessProfile,
        ),
      );
    }*/
  }

  Future<void> updateUserProfile(
      BusinessProfileEntity businessProfileEntity, int stage) async {
    final getCurrentUserResult = await serviceLocator<GetAllAppUserUseCase>()();
    await getCurrentUserResult.when(
      remote: (data, meta) {},
      localDb: (data, meta) async {
        if (data.isNotNullOrEmpty) {
          appLog.d('Profile GetAllAppUserPaginationUseCase is not null');

          final AppUserEntity cacheAppUserEntity = data!.last.copyWith(
            userID: data.last.userID,
            businessProfile: businessProfileEntity,
            currentUserStage: stage,
          );
          final editUserResult = await serviceLocator<SaveAllAppUserUseCase>()(
            [cacheAppUserEntity],
          );
          editUserResult.when(
            remote: (data, meta) {
              appLog.d(
                  'Update current user with business profile save remote ${data?.last.toMap()}');
            },
            localDb: (data, meta) {
              appLog.d(
                  'Update current user with business profile save local ${data?.last.toMap()}');
              if (data != null) {
                var cachedAppUserEntity = serviceLocator<AppUserEntity>()
                  ..businessProfile = businessProfileEntity
                  ..currentUserStage = stage;
                serviceLocator<UserModelStorageController>()
                    .setUserModel(cachedAppUserEntity);
              }
            },
            error: (dataSourceFailure, reason, error, networkException,
                stackTrace, exception, extra) {
              appLog.d(
                  'Update current user with business profile exception $error');
            },
          );
        } else {
          appLog.d('Profile GetAllAppUserPaginationUseCase is null');
        }
      },
      error: (dataSourceFailure, reason, error, networkException, stackTrace,
          exception, extra) {
        appLog.d('Profile updateUserProfile $reason ');
      },
    );

    return;
  }

  FutureOr<void> _saveBusinessType(
      SaveBusinessType event, Emitter<BusinessProfileState> emit) async {
    emit(
      SaveBusinessTypeState(
        businessTypeEntity: event.businessTypeEntity,
        businessProfileEntity: event.businessProfileEntity,
        hasEditBusinessType: event.hasEditBusinessType,
      ),
    );
    return;
  }

  FutureOr<void> _getBusinessType(
      GetBusinessType event, Emitter<BusinessProfileState> emit) async {}

  FutureOr<void> _getBusinessProfile(
      GetBusinessProfile event, Emitter<BusinessProfileState> emit) async {
    try {
      final DataSourceState<BusinessProfileEntity> result =
          await serviceLocator<GetBusinessProfileUseCase>()(
        input: event.businessProfileEntity,
        id: event.businessProfileID,
      );
      result.when(
        remote: (data, meta) {
          appLog.d('Profile bloc edit remote ${data?.businessProfileID}');
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
          appLog.d('Profile bloc edit local ${data?.businessProfileID}');
          emit(
            GetBusinessProfileState(
              businessProfileEntity: data ?? event.businessProfileEntity,
              index: event.index,
              businessProfileID: event.businessProfileID,
              businessProfileStatus: BusinessProfileStatus.getBusinessProfile,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace,
            exception, extra) {
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
          message:
              'Something went wrong during getting your profile details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          businessProfileStatus: BusinessProfileStatus.getBusinessProfile,
        ),
      );
    }
  }

  FutureOr<void> _deleteBusinessProfile(
      DeleteBusinessProfile event, Emitter<BusinessProfileState> emit) async {
    try {
      final DataSourceState<bool> result =
          await serviceLocator<DeleteBusinessProfileUseCase>()(
        input: event.businessProfileEntity,
        id: event.businessProfileID,
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
              businessProfileStatus:
                  BusinessProfileStatus.deleteBusinessProfile,
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
              businessProfileStatus:
                  BusinessProfileStatus.deleteBusinessProfile,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace,
            exception, extra) {
          appLog.d('Profile bloc delete error $reason');
          emit(
            BusinessProfileExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              businessProfileStatus:
                  BusinessProfileStatus.deleteBusinessProfile,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Profile bloc delete exception $e');
      emit(
        BusinessProfileExceptionState(
          message:
              'Something went wrong during deleting your profile details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          businessProfileStatus: BusinessProfileStatus.deleteBusinessProfile,
        ),
      );
    }
  }

  FutureOr<void> _getAllBusinessProfile(
      GetAllBusinessProfile event, Emitter<BusinessProfileState> emit) async {
    try {
      emit(const BusinessProfileLoadingState(
          message: 'Please wait while we are fetching your profile...'));
      final DataSourceState<List<BusinessProfileEntity>> result =
          await serviceLocator<GetAllBusinessProfileUseCase>()();
      result.when(
        remote: (data, meta) {
          appLog.d('Profile bloc get all remote');
          if (data == null || data.isEmpty) {
            emit(
              const BusinessProfileEmptyState(
                message: 'Profile is empty',
                businessProfileEntities: [],
                businessProfileStatus:
                    BusinessProfileStatus.getAllBusinessProfile,
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
              const BusinessProfileEmptyState(
                message: 'Profile is empty',
                businessProfileEntities: [],
                businessProfileStatus:
                    BusinessProfileStatus.getAllBusinessProfile,
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
        error: (dataSourceFailure, reason, error, networkException, stackTrace,
            exception, extra) {
          appLog.d('Profile bloc get all error $reason');
          emit(
            BusinessProfileExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              businessProfileStatus:
                  BusinessProfileStatus.getAllBusinessProfile,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Profile bloc get all $e');
      emit(
        BusinessProfileExceptionState(
          message:
              'Something went wrong during getting your all profiles, please try again',
          //exception: e as Exception,
          stackTrace: s,
          businessProfileStatus: BusinessProfileStatus.getAllBusinessProfile,
        ),
      );
    }
  }

  FutureOr<void> _deleteAllBusinessProfile(DeleteAllBusinessProfile event,
      Emitter<BusinessProfileState> emit) async {
    try {
      final DataSourceState<bool> result =
          await serviceLocator<DeleteAllBusinessProfileUseCase>()();
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
        error: (dataSourceFailure, reason, error, networkException, stackTrace,
            exception, extra) {
          appLog.d('Profile bloc delete all error $reason');
          emit(
            BusinessProfileExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              businessProfileStatus:
                  BusinessProfileStatus.deleteAllBusinessProfile,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Profile bloc delete all exception $e');
      emit(
        BusinessProfileExceptionState(
          message:
              'Something went wrong during deleting your profile details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          businessProfileStatus: BusinessProfileStatus.deleteAllBusinessProfile,
        ),
      );
    }
  }

  FutureOr<void> _navigateToAddressPage(
      NavigateToAddressPage event, Emitter<BusinessProfileState> emit) async {
    emit(
      NavigateToAddressPageState(
        businessTypeEntity: event.businessTypeEntity,
        businessProfileEntity: event.businessProfileEntity,
      ),
    );
    return;
  }

  FutureOr<void> _getCurrentUserProfile(
      GetCurrentUserProfile event, Emitter<BusinessProfileState> emit) async {
    try {
      final DataSourceState<AppUserEntity?> result =
          await serviceLocator<GetCurrentAppUserUseCase>()(
        input: AppUserEntity(
          userID: event.userID,
          uid: event.userID.toString(),
          phoneNumber: event.phoneNumberWithFormat,
          phoneNumberWithoutDialCode: event.phoneNumberWithoutFormat,
        ),
      );
      result.when(
        remote: (data, meta) {
          appLog.d('Profile bloc getCurrentUser remote ${data?.userID}');
          emit(
            GetCurrentUserProfileState(appUserEntity: data),
          );
        },
        localDb: (data, meta) {
          appLog.d('Profile bloc getCurrentUser local ${data?.userID}');
          emit(
            GetCurrentUserProfileState(appUserEntity: data),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace,
            exception, extra) {
          appLog.d('Profile bloc getCurrentUser error $reason');
          emit(
            BusinessProfileExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              businessProfileStatus: BusinessProfileStatus.getCurrentUser,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Profile bloc getCurrentUser exception $e');
      emit(
        BusinessProfileExceptionState(
          message:
              'Something went wrong during getting your user details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          businessProfileStatus: BusinessProfileStatus.getCurrentUser,
        ),
      );
    }
  }

  FutureOr<void> _getAllBusinessProfilePagination(
      GetAllBusinessProfilePagination event,
      Emitter<BusinessProfileState> emit) async {
    try {
      emit(const GetAllBusinessProfilePaginationLoadingState(
          isLoading: true,
          message: 'Please wait while we are fetching all profile...'));
      final DataSourceState<List<BusinessProfileEntity>> result =
          await serviceLocator<GetAllBusinessProfilePaginationUseCase>()(
        pageKey: event.pageKey,
        pageSize: event.pageSize,
        searchText: event.searchItem,
        filtering: event.filtering,
        sorting: event.sorting,
        startTime: event.startTime,
        endTime: event.endTime,
      );
      result.when(
        remote: (data, meta) {
          appLog.d('Get all profile bloc get all remote');
          if (data == null || data.isEmpty) {
            emit(
              const GetAllBusinessProfilePaginationEmptyState(
                message: 'All profile is empty',
                businessProfileEntities: [],
              ),
            );
          } else {
            emit(
              GetAllBusinessProfilePaginationState(
                businessProfileEntities: data.toList(),
                endTime: event.endTime,
                startTime: event.startTime,
                pageKey: event.pageKey,
                pageSize: event.pageSize,
                searchItem: event.searchItem,
                sorting: event.sorting,
                filtering: event.filtering,
              ),
            );
          }
        },
        localDb: (data, meta) {
          appLog.d('Get all profile bloc get all local');
          if (data == null || data.isEmpty) {
            emit(
              const GetAllBusinessProfilePaginationEmptyState(
                message: 'All profile is empty',
                businessProfileEntities: [],
              ),
            );
          } else {
            emit(
              GetAllBusinessProfilePaginationState(
                businessProfileEntities: data.toList(),
                endTime: event.endTime,
                startTime: event.startTime,
                pageKey: event.pageKey,
                pageSize: event.pageSize,
                searchItem: event.searchItem,
                sorting: event.sorting,
                filtering: event.filtering,
              ),
            );
          }
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace,
            exception, extra) {
          appLog.d('Get all profile bloc get all error $reason');
          emit(
            GetAllBusinessProfilePaginationExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Get all profile bloc get all $e');
      emit(
        GetAllBusinessProfilePaginationExceptionState(
          message:
              'Something went wrong during getting all profile, please try again',
          //exception: e as Exception,
          stackTrace: s,
        ),
      );
    }
  }

  FutureOr<void> _getAllAppUserProfilePagination(
      GetAllAppUserProfilePagination event,
      Emitter<BusinessProfileState> emit) async {
    try {
      emit(const GetAllAppUserProfileLoadingState(
          isLoading: true,
          message: 'Please wait while we are fetching all users...'));
      final DataSourceState<List<AppUserEntity>> result =
          await serviceLocator<GetAllAppUserPaginationUseCase>()(
              pageKey: event.pageKey,
              pageSize: event.pageSize,
              searchText: event.searchItem,
              filtering: event.filtering,
              sorting: event.sorting,
              startTime: event.startTime,
              endTime: event.endTime,
              entity: event.appUserEntity ?? serviceLocator<AppUserEntity>());
      await result.when(
        remote: (data, meta) {
          appLog.d('Get all users bloc get all remote');
          if (data == null || data.isEmpty) {
            emit(
              const GetAllAppUserProfileEmptyState(
                message: 'All users is empty',
              ),
            );
          } else {
            emit(
              GetAllAppUserProfilePaginationState(
                appUserEntities: data.toList(),
                endTime: event.endTime,
                startTime: event.startTime,
                pageKey: event.pageKey,
                pageSize: event.pageSize,
                searchItem: event.searchItem,
                sorting: event.sorting,
                filtering: event.filtering,
              ),
            );
          }
        },
        localDb: (data, meta) {
          appLog.d('Get all users bloc get all local');
          if (data == null || data.isEmpty) {
            emit(
              const GetAllAppUserProfileEmptyState(
                message: 'All users is empty',
              ),
            );
          } else {
            emit(
              GetAllAppUserProfilePaginationState(
                appUserEntities: data.toList(),
                endTime: event.endTime,
                startTime: event.startTime,
                pageKey: event.pageKey,
                pageSize: event.pageSize,
                searchItem: event.searchItem,
                sorting: event.sorting,
                filtering: event.filtering,
              ),
            );
          }
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace,
            exception, extra) {
          appLog.d('Get all users bloc get all error $reason');
          emit(
            GetAllAppUserProfileExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Get all users bloc get all $e');
      emit(
        GetAllAppUserProfileExceptionState(
          message:
              'Something went wrong during getting all users, please try again',
          //exception: e as Exception,
          stackTrace: s,
        ),
      );
    }
  }
}
