part of 'package:homemakers_merchant/app/features/profile/index.dart';

class GetAllPaymentBankUseCase extends UseCase<DataSourceState<List<PaymentBankEntity>>> {
  GetAllPaymentBankUseCase({
    required this.userPaymentBankRepository,
  });
  final UserPaymentBankRepository userPaymentBankRepository;
  @override
  Future<DataSourceState<List<PaymentBankEntity>>> call() async {
    return userPaymentBankRepository.getAllPaymentBank();
  }
}
