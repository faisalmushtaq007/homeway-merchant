part of 'package:homemakers_merchant/app/features/profile/index.dart';

class DeletePaymentBankUseCase extends UseCaseByID<PaymentBankEntity, int, DataSourceState<bool>> {
  DeletePaymentBankUseCase({
    required this.userPaymentBankRepository,
  });
  final UserPaymentBankRepository userPaymentBankRepository;
  @override
  Future<DataSourceState<bool>> call({required int id, PaymentBankEntity? input}) async {
    return userPaymentBankRepository.deletePaymentBank(paymentBankEntity: input, paymentBankID: id);
  }
}
