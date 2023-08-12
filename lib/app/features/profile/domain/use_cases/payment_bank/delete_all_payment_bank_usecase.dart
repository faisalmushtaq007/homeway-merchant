part of 'package:homemakers_merchant/app/features/profile/index.dart';

class DeleteAllPaymentBankUseCase extends UseCase<DataSourceState<bool>> {
  DeleteAllPaymentBankUseCase({
    required this.userPaymentBankRepository,
  });
  final UserPaymentBankRepository userPaymentBankRepository;
  @override
  Future<DataSourceState<bool>> call() async {
    return userPaymentBankRepository.deleteAllPaymentBank();
  }
}
