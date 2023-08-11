part of 'package:homemakers_merchant/app/features/profile/index.dart';

class DeleteAllPaymentBankUseCase extends UseCaseByID<StoreEntity, int, DataSourceState<bool>> {
  DeleteAllPaymentBankUseCase({
    required this.userPaymentBankRepository,
  });
  final UserPaymentBankRepository userPaymentBankRepository;
  @override
  Future<DataSourceState<bool>> call({required int id, StoreEntity? input}) async {
    return userPaymentBankRepository.deleteAllPaymentBank();
  }
}
