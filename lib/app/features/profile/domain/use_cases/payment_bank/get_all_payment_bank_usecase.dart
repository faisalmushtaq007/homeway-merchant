part of 'package:homemakers_merchant/app/features/profile/index.dart';

class GetAllPaymentBankUseCase extends UseCaseByID<PaymentBankEntity, int, DataSourceState<List<PaymentBankEntity>>> {
  GetAllPaymentBankUseCase({
    required this.userPaymentBankRepository,
  });
  final UserPaymentBankRepository userPaymentBankRepository;
  @override
  Future<DataSourceState<List<PaymentBankEntity>>> call({required int id, PaymentBankEntity? input}) async {
    return userPaymentBankRepository.getAllPaymentBank();
  }
}
