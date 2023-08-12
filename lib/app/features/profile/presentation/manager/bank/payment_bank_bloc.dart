import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:homemakers_merchant/app/features/profile/index.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/shared/states/data_source_state.dart';
import 'package:homemakers_merchant/utils/app_equatable/app_equatable.dart';
import 'package:homemakers_merchant/utils/app_log.dart';

part 'payment_bank_event.dart';
part 'payment_bank_state.dart';

class PaymentBankBloc extends Bloc<PaymentBankEvent, PaymentBankState> {
  PaymentBankBloc() : super(PaymentBankInitial()) {
    on<SavePaymentBank>(_savePaymentBank);
    on<GetPaymentBank>(_getPaymentBank);
    on<DeletePaymentBank>(_deletePaymentBank);
    on<GetAllPaymentBank>(_getAllPaymentBank);
    on<DeleteAllPaymentBank>(_deleteAllPaymentBank);
  }

  FutureOr<void> _savePaymentBank(SavePaymentBank event, Emitter<PaymentBankState> emit) async {
    try {
      DataSourceState<PaymentBankEntity> result;
      if (!event.hasEditPaymentBank && event.currentIndex != -1) {
        result = await serviceLocator<EditPaymentBankUseCase>()(id: event.paymentBankEntity.paymentBankID, input: event.paymentBankEntity);
      } else {
        result = await serviceLocator<SavePaymentBankUseCase>()(event.paymentBankEntity);
      }
      result.when(
        remote: (data, meta) {
          appLog.d('Payment Bank bloc save remote ${data?.toMap()}');
          emit(
            SavePaymentBankState(
              paymentBankEntity: data ?? event.paymentBankEntity,
              hasEditPaymentBank: event.hasEditPaymentBank,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('Payment Bank bloc save local ${data?.toMap()}');
          emit(
            SavePaymentBankState(
              paymentBankEntity: data ?? event.paymentBankEntity,
              hasEditPaymentBank: event.hasEditPaymentBank,
            ),
          );
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

  FutureOr<void> _getPaymentBank(GetPaymentBank event, Emitter<PaymentBankState> emit) async {
    try {
      final DataSourceState<PaymentBankEntity> result = await serviceLocator<GetPaymentBankUseCase>()(
        input: event.paymentBankEntity,
        id: event.paymentBankID,
      );
      result.when(
        remote: (data, meta) {
          appLog.d('Payment Bank bloc edit remote ${data?.toMap()}');
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
          appLog.d('Payment Bank bloc edit local ${data?.toMap()}');
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
      emit(PaymentBankLoadingState(message: 'Please wait while we are fetching your profile...'));
      final DataSourceState<List<PaymentBankEntity>> result = await serviceLocator<GetAllPaymentBankUseCase>()();
      result.when(
        remote: (data, meta) {
          appLog.d('Payment Bank bloc get all remote');
          if (data == null || data.isEmpty) {
            emit(
              PaymentBankEmptyState(
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
              PaymentBankEmptyState(
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
