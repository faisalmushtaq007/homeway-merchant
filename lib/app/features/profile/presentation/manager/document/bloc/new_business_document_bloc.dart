import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homemakers_merchant/app/features/authentication/index.dart';
import 'package:homemakers_merchant/app/features/profile/index.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/core/extensions/global_extensions/list_ext.dart';
import 'package:homemakers_merchant/core/extensions/global_extensions/src/object.dart';
import 'package:homemakers_merchant/shared/states/data_source_state.dart';
import 'package:homemakers_merchant/utils/app_log.dart';
import 'package:sembast/timestamp.dart';

part 'new_business_document_event.dart';
part 'new_business_document_state.dart';

class NewBusinessDocumentBloc
    extends Bloc<NewBusinessDocumentEvent, NewBusinessDocumentState> {
  NewBusinessDocumentBloc() : super(NewBusinessDocumentInitial()) {
    on<UploadNewBusinessDocument>(_uploadNewBusinessDocument);
    on<GetNewUploadBusinessDocument>(_getNewUploadBusinessDocument);
    on<GetAllNewUploadBusinessDocument>(_getAllNewUploadBusinessDocument);
    on<DeleteNewUploadBusinessDocument>(_deleteNewUploadBusinessDocument);
    on<DeleteAllNewUploadBusinessDocument>(_deleteAllNewUploadBusinessDocument);
  }

  FutureOr<void> _uploadNewBusinessDocument(UploadNewBusinessDocument event,
      Emitter<NewBusinessDocumentState> emit,) async {
    /*try {
      DataSourceState<NewBusinessDocumentEntity> result;
      if (!event.hasNewUploadBusinessDocument) {
        result = await serviceLocator<EditDocumentUseCase>()(id: event.businessDocumentUploadedEntity?.documentID, input: event.businessDocumentUploadedEntity);
      } else {
        result = await serviceLocator<SaveDocumentUseCase>()(event.businessDocumentUploadedEntity);
      }
      await result.when(
        remote: (data, meta) async {
          appLog.d('NewBusinessDocument  bloc save remote ${data?.toMap()}');
          if (data.isNotNull) {
            await updateUserProfile(data!);
          }
          await Future.delayed(const Duration(milliseconds: 500), () {});
          emit(
            UploadNewBusinessDocumentState(
              businessDocumentUploadedEntity: event.businessDocumentUploadedEntity,
              hasNewUploadBusinessDocument: event.hasNewUploadBusinessDocument,
              status: UploadBusinessDocumentStatus.save,
            ),
          );
        },
        localDb: (data, meta) async {
          appLog.d('NewBusinessDocument  bloc save local ${data?.toMap()}');
          if (data.isNotNull) {
            await updateUserProfile(data!);
          }
          await Future.delayed(const Duration(milliseconds: 500), () {});
          emit(
            UploadNewBusinessDocumentState(
              businessDocumentUploadedEntity: event.businessDocumentUploadedEntity,
              hasNewUploadBusinessDocument: event.hasNewUploadBusinessDocument,
              status: UploadBusinessDocumentStatus.save,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('NewBusinessDocument  bloc save error $reason');
          emit(
            NewBusinessDocumentExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              status: UploadBusinessDocumentStatus.save,
            ),
          );
        },
      );
      return;
    } catch (e, s) {
      appLog.e('NewBusinessDocument  bloc save exception $e');
      emit(
        NewBusinessDocumentExceptionState(
          message: 'Something went wrong during saving your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          status: UploadBusinessDocumentStatus.save,
        ),
      );
    }*/
    try {
      int currentStage=4;
      final DataSourceState<List<NewBusinessDocumentEntity>> results =
          await serviceLocator<SaveAllDocumentUseCase>()(
              event.allBusinessDocuments.toList(),);
      if(event.hasEditBusinessDocument){
        currentStage=serviceLocator<AppUserEntity>().currentUserStage;
      }else{
        currentStage=4;
      }
      await results.when(
        remote: (data, meta) async {
          appLog.d('Business Document bloc save remote ${data?.length}');
          if (data.isNotNullOrEmpty) {
            await updateUserProfile(data!.toList(),currentUserStage:currentStage,);
          }
          await Future.delayed(const Duration(milliseconds: 500), () {});
          emit(
            UploadNewBusinessDocumentState(
              allBusinessDocuments: data ?? event.allBusinessDocuments.toList(),
              hasEditBusinessDocument: event.hasEditBusinessDocument,
            ),
          );
        },
        localDb: (data, meta) async {
          appLog.d('Business Document bloc save local ${data?.length}');
          if (data.isNotNullOrEmpty) {
            await updateUserProfile(data!.toList(),currentUserStage: currentStage);
          }
          await Future.delayed(const Duration(milliseconds: 500), () {});
          emit(
            UploadNewBusinessDocumentState(
              allBusinessDocuments: data ?? event.allBusinessDocuments.toList(),
              hasEditBusinessDocument: event.hasEditBusinessDocument,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace,
            exception, extra,) {
          appLog.d('Business Document bloc save error $reason');
          emit(
            NewBusinessDocumentExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              status: UploadBusinessDocumentStatus.save,
            ),
          );
        },
      );

      return;
    } catch (e, s) {
      appLog.e('Business Document bloc save exception $e');
      emit(
        NewBusinessDocumentExceptionState(
          message:
              'Something went wrong during saving your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          status: UploadBusinessDocumentStatus.save,
        ),
      );
    }
  }

  Future<void> updateUserProfile(
      List<NewBusinessDocumentEntity> allBusinessDocuments,{int currentUserStage=4,}) async {
    final getCurrentUserResult =
        await serviceLocator<GetAllAppUserPaginationUseCase>()();
    await getCurrentUserResult.when(
      remote: (data, meta) {},
      localDb: (data, meta) async {
        if (data.isNotNullOrEmpty) {
          appLog.d('Document GetAllAppUserPaginationUseCase is not null');

          final AppUserEntity cacheAppUserEntity = data!.last.copyWith(
            userID: data.last.userID,
            businessProfile: data.last.businessProfile
                ?.copyWith(allBusinessDocuments: allBusinessDocuments),
            currentUserStage: currentUserStage,
          );
          final editUserResult = await serviceLocator<SaveAllAppUserUseCase>()(
            [cacheAppUserEntity],
          );
          editUserResult.when(
            remote: (data, meta) {
              appLog.d(
                  'Update current user with business profile save remote ${data?.last.toMap()}',);
            },
            localDb: (data, meta) {
              appLog.d(
                  'Update current user with business profile save local ${data?.last.toMap()}',);
              if (data != null) {
                var cachedAppUserEntity = serviceLocator<AppUserEntity>()
                  ..currentUserStage = currentUserStage
                  ..businessProfile = data.last.businessProfile
                      ?.copyWith(allBusinessDocuments: allBusinessDocuments);
                serviceLocator<UserModelStorageController>()
                    .setUserModel(cachedAppUserEntity);
              }
            },
            error: (dataSourceFailure, reason, error, networkException,
                stackTrace, exception, extra,) {
              appLog.d(
                  'Update current user with business profile exception $error',);
            },
          );
        } else {
          appLog.d('Document GetAllAppUserPaginationUseCase is null');
        }
      },
      error: (dataSourceFailure, reason, error, networkException, stackTrace,
          exception, extra,) {
        appLog.d('Document updateUserProfile $reason ');
      },
    );
    return;
  }

  FutureOr<void> _getNewUploadBusinessDocument(
      GetNewUploadBusinessDocument event,
      Emitter<NewBusinessDocumentState> emit,) async {
    try {
      final DataSourceState<NewBusinessDocumentEntity> result =
          await serviceLocator<GetDocumentUseCase>()(
        input: event.businessDocumentUploadedEntity,
        id: event.documentID,
      );
      result.when(
        remote: (data, meta) {
          appLog.d('NewBusinessDocument  bloc edit remote ${data?.toMap()}');
          emit(
            GetNewBusinessDocumentState(
              businessDocumentUploadedEntity:
                  data ?? event.businessDocumentUploadedEntity,
              status: UploadBusinessDocumentStatus.get,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('NewBusinessDocument  bloc edit local ${data?.toMap()}');
          emit(
            GetNewBusinessDocumentState(
              businessDocumentUploadedEntity:
                  data ?? event.businessDocumentUploadedEntity,
              status: UploadBusinessDocumentStatus.get,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace,
            exception, extra,) {
          appLog.d('NewBusinessDocument  bloc edit error $reason');
          emit(
            NewBusinessDocumentExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              status: UploadBusinessDocumentStatus.get,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('NewBusinessDocument  bloc get exception $e');
      emit(
        NewBusinessDocumentExceptionState(
          message:
              'Something went wrong during getting your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          status: UploadBusinessDocumentStatus.get,
        ),
      );
    }
  }

  FutureOr<void> _getAllNewUploadBusinessDocument(
      GetAllNewUploadBusinessDocument event,
      Emitter<NewBusinessDocumentState> emit,) async {
    try {
      emit(NewBusinessDocumentLoadingState(
          message: 'Please wait while we are fetching your profile...',),);
      final DataSourceState<List<NewBusinessDocumentEntity>> result =
          await serviceLocator<GetAllDocumentUseCase>()();
      result.when(
        remote: (data, meta) {
          appLog.d('NewBusinessDocument  bloc get all remote');
          if (data == null || data.isEmpty) {
            emit(
              NewBusinessDocumentEmptyState(
                message: 'Business document is empty',
                businessDocumentEntities: [],
                status: UploadBusinessDocumentStatus.getAll,
              ),
            );
          } else {
            emit(
              GetAllNewUploadBusinessDocumentState(
                businessDocumentEntities: data.toList(),
              ),
            );
          }
        },
        localDb: (data, meta) {
          appLog.d('NewBusinessDocument  bloc get all local');
          if (data == null || data.isEmpty) {
            emit(
              NewBusinessDocumentEmptyState(
                message: 'Business document is empty',
                businessDocumentEntities: [],
                status: UploadBusinessDocumentStatus.getAll,
              ),
            );
          } else {
            emit(
              GetAllNewUploadBusinessDocumentState(
                businessDocumentEntities: data.toList(),
              ),
            );
          }
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace,
            exception, extra,) {
          appLog.d('NewBusinessDocument  bloc get all error $reason');
          emit(
            NewBusinessDocumentExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              status: UploadBusinessDocumentStatus.getAll,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('NewBusinessDocument  bloc get all $e');
      emit(
        NewBusinessDocumentExceptionState(
          message:
              'Something went wrong during getting your all stores, please try again',
          //exception: e as Exception,
          stackTrace: s,
          status: UploadBusinessDocumentStatus.getAll,
        ),
      );
    }
  }

  FutureOr<void> _deleteNewUploadBusinessDocument(
      DeleteNewUploadBusinessDocument event,
      Emitter<NewBusinessDocumentState> emit,) async {
    try {
      final DataSourceState<bool> result =
          await serviceLocator<DeleteDocumentUseCase>()(
        input: event.businessDocumentUploadedEntity,
        id: event.documentID,
      );
      result.when(
        remote: (data, meta) {
          appLog.d('NewBusinessDocument  bloc delete remote $data');
          emit(
            DeleteNewBusinessDocumentState(
              hasDeleteUploadedDocument: data ?? false,
              status: UploadBusinessDocumentStatus.delete,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('NewBusinessDocument  bloc delete local $data');
          emit(
            DeleteNewBusinessDocumentState(
              hasDeleteUploadedDocument: data ?? false,
              status: UploadBusinessDocumentStatus.delete,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace,
            exception, extra,) {
          appLog.d('NewBusinessDocument  bloc delete error $reason');
          emit(
            NewBusinessDocumentExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              status: UploadBusinessDocumentStatus.delete,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('NewBusinessDocument  bloc delete exception $e');
      emit(
        NewBusinessDocumentExceptionState(
          message:
              'Something went wrong during getting your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          status: UploadBusinessDocumentStatus.delete,
        ),
      );
    }
  }

  FutureOr<void> _deleteAllNewUploadBusinessDocument(
      DeleteAllNewUploadBusinessDocument event,
      Emitter<NewBusinessDocumentState> emit,) async {
    try {
      final DataSourceState<bool> result =
          await serviceLocator<DeleteAllDocumentUseCase>()();
      result.when(
        remote: (data, meta) {
          appLog.d('NewBusinessDocument  bloc delete all remote $data');
          emit(
            DeleteAllNewBusinessDocumentState(
              hasDeleteAllUploadedDocument: data ?? false,
              status: UploadBusinessDocumentStatus.deleteAll,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('NewBusinessDocument  bloc delete all local $data');
          emit(
            DeleteAllNewBusinessDocumentState(
              hasDeleteAllUploadedDocument: data ?? false,
              status: UploadBusinessDocumentStatus.deleteAll,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace,
            exception, extra,) {
          appLog.d('NewBusinessDocument  bloc delete all error $reason');
          emit(
            NewBusinessDocumentExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              status: UploadBusinessDocumentStatus.deleteAll,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('NewBusinessDocument  bloc delete all exception $e');
      emit(
        NewBusinessDocumentExceptionState(
          message:
              'Something went wrong during getting your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          status: UploadBusinessDocumentStatus.deleteAll,
        ),
      );
    }
  }
}
