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

part 'payment_bank_event.dart';

part 'payment_bank_state.dart';

class PaymentBankBloc extends Bloc<PaymentBankEvent, PaymentBankState> {
  PaymentBankBloc() : super(const PaymentBankInitial()) {
    on<SavePaymentBank>(_savePaymentBank);
    on<GetPaymentBank>(_getPaymentBank);
    on<DeletePaymentBank>(_deletePaymentBank);
    on<GetAllPaymentBank>(_getAllPaymentBank);
    on<DeleteAllPaymentBank>(_deleteAllPaymentBank);
  }

  FutureOr<void> _savePaymentBank(SavePaymentBank event, Emitter<PaymentBankState> emit) async {
    try {
      DataSourceState<PaymentBankEntity> result;
      appLog.d(
          'Payment Bank bloc currentStage,${serviceLocator<AppUserEntity>().currentUserStage}, ${event.hasEditPaymentBank}');
      int currentStage = 3;
      // Existing information
      if (event.hasEditPaymentBank) {
        currentStage = serviceLocator<AppUserEntity>().currentUserStage;
        appLog.d('Payment Bank bloc 1. currentStage $currentStage');
        result = await serviceLocator<EditPaymentBankUseCase>()(
            id: event.paymentBankEntity.paymentBankID, input: event.paymentBankEntity);
      }
      // New Information
      else {
        appLog.d('Payment Bank bloc 2. currentStage $currentStage');
        currentStage = 3;
        result = await serviceLocator<SavePaymentBankUseCase>()(event.paymentBankEntity);
      }
      appLog.d('Payment Bank bloc currentStage $currentStage');
      await result.when(
        remote: (data, meta) async {
          appLog.d('Payment Bank bloc save remote ${data?.paymentBankID}');
          if (data.isNotNull) {
            await updateUserProfile(data!, currentUserStage: currentStage);
          }
          await Future.delayed(const Duration(milliseconds: 500), () {});
          emit(
            SavePaymentBankState(
              paymentBankEntity: data ?? event.paymentBankEntity,
              hasEditPaymentBank: event.hasEditPaymentBank,
            ),
          );
          await Future.delayed(const Duration(milliseconds: 500), () {});
          emit(NavigateToNextPageState(appUserEntity: serviceLocator<AppUserEntity>()));
        },
        localDb: (data, meta) async {
          appLog.d('Payment Bank bloc save local ${data?.paymentBankID}');
          if (data.isNotNull) {
            await updateUserProfile(data!, currentUserStage: currentStage);
          }
          await Future.delayed(const Duration(milliseconds: 500), () {});
          emit(
            SavePaymentBankState(
              paymentBankEntity: data ?? event.paymentBankEntity,
              hasEditPaymentBank: event.hasEditPaymentBank,
            ),
          );
          await Future.delayed(const Duration(milliseconds: 500), () {});
          emit(NavigateToNextPageState(appUserEntity: serviceLocator<AppUserEntity>()));
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Payment Bank bloc save error $reason');
          emit(
            PaymentBankExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              paymentBankStatus: PaymentBankStatus.savePaymentBank,
            ),
          );
        },
      );
      return;
    } catch (e, s) {
      appLog.e('Payment Bank bloc save exception $e');
      emit(
        PaymentBankExceptionState(
          message: 'Something went wrong during saving your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          paymentBankStatus: PaymentBankStatus.savePaymentBank,
        ),
      );
    }
  }

  Future<void> updateUserProfile(PaymentBankEntity paymentBankData, {int currentUserStage = 3}) async {
    final getCurrentUserResult = await serviceLocator<GetAllAppUserPaginationUseCase>()();
    await getCurrentUserResult.when(
      remote: (data, meta) {},
      localDb: (data, meta) async {
        if (data.isNotNullOrEmpty) {
          appLog.d('Bank GetAllAppUserPaginationUseCase is not null');
          final AppUserEntity cacheAppUserEntity = data!.last.copyWith(
            userID: data.last.userID,
            paymentBankEntity: paymentBankData,
            hasMultiplePaymentBanks: false,
            paymentBankEntities: <PaymentBankEntity>[],
            currentUserStage: currentUserStage,
          );
          final editUserResult = await serviceLocator<SaveAllAppUserUseCase>()(
            [cacheAppUserEntity],
          );
          editUserResult.when(
            remote: (data, meta) {
              appLog
                  .d('Update current user with business profile save remote ${data?.last.toMap()['currentUserStage']}');
            },
            localDb: (data, meta) {
              appLog
                  .d('Update current user with business profile save local ${data?.last.toMap()['currentUserStage']}');
              if (data != null) {
                var cachedAppUserEntity = serviceLocator<AppUserEntity>()
                  ..currentUserStage = currentUserStage
                  ..paymentBankEntity = paymentBankData
                  ..hasMultiplePaymentBanks = false
                  ..paymentBankEntities = <PaymentBankEntity>[];
                serviceLocator<UserModelStorageController>().setUserModel(cachedAppUserEntity);
              }
            },
            error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
              appLog.d('Update current user with business profile exception $error');
            },
          );
        } else {
          appLog.d('Bank GetAllAppUserPaginationUseCase is null');
        }
      },
      error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
        appLog.d('Bank updateUserProfile $reason ');
      },
    );

    return;
  }

  FutureOr<void> _getPaymentBank(GetPaymentBank event, Emitter<PaymentBankState> emit) async {
    try {
      final DataSourceState<PaymentBankEntity> result = await serviceLocator<GetPaymentBankUseCase>()(
        input: event.paymentBankEntity,
        id: event.paymentBankID,
      );
      result.when(
        remote: (data, meta) {
          appLog.d('Payment Bank bloc edit remote ${data?.paymentBankID}');
          emit(
            GetPaymentBankState(
              paymentBankEntity: data ?? event.paymentBankEntity,
              index: event.index,
              paymentBankID: event.paymentBankID,
              paymentBankStatus: PaymentBankStatus.getPaymentBank,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('Payment Bank bloc edit local ${data?.paymentBankID}');
          emit(
            GetPaymentBankState(
              paymentBankEntity: data ?? event.paymentBankEntity,
              index: event.index,
              paymentBankID: event.paymentBankID,
              paymentBankStatus: PaymentBankStatus.getPaymentBank,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Payment Bank bloc edit error $reason');
          emit(
            PaymentBankExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              paymentBankStatus: PaymentBankStatus.getPaymentBank,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Payment Bank bloc get exception $e');
      emit(
        PaymentBankExceptionState(
          message: 'Something went wrong during getting your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          paymentBankStatus: PaymentBankStatus.getPaymentBank,
        ),
      );
    }
  }

  FutureOr<void> _deletePaymentBank(DeletePaymentBank event, Emitter<PaymentBankState> emit) async {
    try {
      final DataSourceState<bool> result = await serviceLocator<DeletePaymentBankUseCase>()(
        input: event.paymentBankEntity,
        id: event.paymentBankID,
      );
      result.when(
        remote: (data, meta) {
          appLog.d('Payment Bank bloc delete remote $data');
          emit(
            DeletePaymentBankState(
              paymentBankEntity: event.paymentBankEntity,
              index: event.index,
              paymentBankEntities: event.paymentBankEntities.toList(),
              paymentBankID: event.paymentBankID,
              hasDelete: data ?? false,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('Payment Bank bloc delete local $data');
          emit(
            DeletePaymentBankState(
              paymentBankEntity: event.paymentBankEntity,
              index: event.index,
              paymentBankEntities: event.paymentBankEntities.toList(),
              paymentBankID: event.paymentBankID,
              hasDelete: data ?? false,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Payment Bank bloc delete error $reason');
          emit(
            PaymentBankExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              paymentBankStatus: PaymentBankStatus.deletePaymentBank,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Payment Bank bloc delete exception $e');
      emit(
        PaymentBankExceptionState(
          message: 'Something went wrong during getting your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          paymentBankStatus: PaymentBankStatus.deletePaymentBank,
        ),
      );
    }
  }

  FutureOr<void> _getAllPaymentBank(GetAllPaymentBank event, Emitter<PaymentBankState> emit) async {
    try {
      emit(const PaymentBankLoadingState(message: 'Please wait while we are fetching your profile...'));
      final DataSourceState<List<PaymentBankEntity>> result = await serviceLocator<GetAllPaymentBankUseCase>()();
      result.when(
        remote: (data, meta) {
          appLog.d('Payment Bank bloc get all remote');
          if (data == null || data.isEmpty) {
            emit(
              const PaymentBankEmptyState(
                message: 'Payment Bank is empty',
                paymentBankEntities: [],
                paymentBankStatus: PaymentBankStatus.getAllPaymentBank,
              ),
            );
          } else {
            emit(
              GetAllPaymentBankState(
                paymentBankEntities: data.toList(),
              ),
            );
          }
        },
        localDb: (data, meta) {
          appLog.d('Payment Bank bloc get all local');
          if (data == null || data.isEmpty) {
            emit(
              const PaymentBankEmptyState(
                message: 'Payment Bank is empty',
                paymentBankEntities: [],
                paymentBankStatus: PaymentBankStatus.getAllPaymentBank,
              ),
            );
          } else {
            emit(
              GetAllPaymentBankState(
                paymentBankEntities: data.toList(),
              ),
            );
          }
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Payment Bank bloc get all error $reason');
          emit(
            PaymentBankExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              paymentBankStatus: PaymentBankStatus.getAllPaymentBank,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Payment Bank bloc get all $e');
      emit(
        PaymentBankExceptionState(
          message: 'Something went wrong during getting your all stores, please try again',
          //exception: e as Exception,
          stackTrace: s,
          paymentBankStatus: PaymentBankStatus.getAllPaymentBank,
        ),
      );
    }
  }

  FutureOr<void> _deleteAllPaymentBank(DeleteAllPaymentBank event, Emitter<PaymentBankState> emit) async {
    try {
      final DataSourceState<bool> result = await serviceLocator<DeleteAllPaymentBankUseCase>()();
      result.when(
        remote: (data, meta) {
          appLog.d('Payment Bank bloc delete all remote $data');
          emit(
            DeleteAllPaymentBankState(
              paymentBankEntities: [],
              hasDeleteAll: data ?? false,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('Payment Bank bloc delete all local $data');
          emit(
            DeleteAllPaymentBankState(
              paymentBankEntities: [],
              hasDeleteAll: data ?? false,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Payment Bank bloc delete all error $reason');
          emit(
            PaymentBankExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              paymentBankStatus: PaymentBankStatus.deleteAllPaymentBank,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Payment Bank bloc delete all exception $e');
      emit(
        PaymentBankExceptionState(
          message: 'Something went wrong during getting your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          paymentBankStatus: PaymentBankStatus.deleteAllPaymentBank,
        ),
      );
    }
  }
}
