part of 'package:homemakers_merchant/app/features/profile/index.dart';

class SavePaymentBankUseCase
    extends UseCaseIO<PaymentBankEntity, DataSourceState<PaymentBankEntity>> {
  SavePaymentBankUseCase({
    required this.userPaymentBankRepository,
  });
  final UserPaymentBankRepository userPaymentBankRepository;
  @override
  Future<DataSourceState<PaymentBankEntity>> call(
      PaymentBankEntity input) async {
    return userPaymentBankRepository.savePaymentBank(paymentBankEntity: input);
  }
}
