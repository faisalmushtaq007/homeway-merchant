part of 'package:homemakers_merchant/app/features/profile/index.dart';

class SaveAllPaymentBankUseCase extends UseCaseIO<List<PaymentBankEntity>, DataSourceState<List<PaymentBankEntity>>> {
  SaveAllPaymentBankUseCase({
    required this.userPaymentBankRepository,
  });
  final UserPaymentBankRepository userPaymentBankRepository;
  @override
  Future<DataSourceState<List<PaymentBankEntity>>> call(List<PaymentBankEntity> input) async {
    return await userPaymentBankRepository.saveAllPaymentBanks(
      paymentBanks: input,
      hasUpdateAll: false,
    );
  }
}
