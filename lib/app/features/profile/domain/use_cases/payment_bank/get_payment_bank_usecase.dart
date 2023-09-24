part of 'package:homemakers_merchant/app/features/profile/index.dart';

class GetPaymentBankUseCase extends UseCaseByID<PaymentBankEntity, int,
    DataSourceState<PaymentBankEntity>> {
  GetPaymentBankUseCase({
    required this.userPaymentBankRepository,
  });
  final UserPaymentBankRepository userPaymentBankRepository;
  @override
  Future<DataSourceState<PaymentBankEntity>> call(
      {required int id, PaymentBankEntity? input}) async {
    return userPaymentBankRepository.getPaymentBank(
        paymentBankEntity: input, paymentBankID: id);
  }
}
