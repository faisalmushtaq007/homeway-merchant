part of 'package:homemakers_merchant/app/features/profile/index.dart';

class EditPaymentBankUseCase extends UseCaseByIDAndEntity<PaymentBankEntity,
    int, DataSourceState<PaymentBankEntity>> {
  EditPaymentBankUseCase({
    required this.userPaymentBankRepository,
  });
  final UserPaymentBankRepository userPaymentBankRepository;

  @override
  Future<DataSourceState<PaymentBankEntity>> call(
      {required PaymentBankEntity input, required int id}) async {
    return userPaymentBankRepository.editPaymentBank(
        paymentBankEntity: input, paymentBankID: id);
  }
}
