part of 'package:homemakers_merchant/app/features/profile/index.dart';

abstract interface class UserPaymentBankRepository {
  Future<DataSourceState<PaymentBankEntity>> savePaymentBank({
    required PaymentBankEntity paymentBankEntity,
    AppUserEntity? appUserEntity,
  });

  Future<DataSourceState<PaymentBankEntity>> editPaymentBank({
    required PaymentBankEntity paymentBankEntity,
    required int paymentBankID,
    AppUserEntity? appUserEntity,
  });

  Future<DataSourceState<bool>> deletePaymentBank({
    required int paymentBankID,
    PaymentBankEntity? paymentBankEntity,
    AppUserEntity? appUserEntity,
  });

  Future<DataSourceState<bool>> deleteAllPaymentBank({
    AppUserEntity? appUserEntity,
  });

  Future<DataSourceState<PaymentBankEntity>> getPaymentBank({
    required int paymentBankID,
    AppUserEntity? appUserEntity,
    PaymentBankEntity? paymentBankEntity,
  });

  Future<DataSourceState<List<PaymentBankEntity>>> getAllPaymentBank({
    AppUserEntity? appUserEntity,
  });

  Future<DataSourceState<List<PaymentBankEntity>>>
      getAllPaymentBanksPagination({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    Map<String, dynamic> extras = const <String, dynamic>{},
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  });

  Future<DataSourceState<List<PaymentBankEntity>>> saveAllPaymentBanks({
    required List<PaymentBankEntity> paymentBanks,
    bool hasUpdateAll = false,
  });
}
