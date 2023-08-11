part of 'package:homemakers_merchant/app/features/profile/index.dart';

class PaymentBankRepositoryImplement implements UserPaymentBankRepository {
  @override
  Future<DataSourceState<bool>> deleteAllPaymentBank({AppUserEntity? appUserEntity}) {
    // TODO: implement deleteAllPaymentBank
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<bool>> deletePaymentBank({required int paymentBankID, PaymentBankEntity? paymentBankEntity, AppUserEntity? appUserEntity}) {
    // TODO: implement deletePaymentBank
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<PaymentBankEntity>> editPaymentBank(
      {required PaymentBankEntity paymentBankEntity, required int paymentBankID, AppUserEntity? appUserEntity}) {
    // TODO: implement editPaymentBank
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<List<PaymentBankEntity>>> getAllPaymentBank({AppUserEntity? appUserEntity}) {
    // TODO: implement getAllPaymentBank
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<PaymentBankEntity>> getPaymentBank({required int paymentBankID, AppUserEntity? appUserEntity, PaymentBankEntity? paymentBankEntity}) {
    // TODO: implement getPaymentBank
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<PaymentBankEntity>> savePaymentBank({required PaymentBankEntity paymentBankEntity, AppUserEntity? appUserEntity}) {
    // TODO: implement savePaymentBank
    throw UnimplementedError();
  }
}
