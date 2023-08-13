part of 'package:homemakers_merchant/app/features/address/index.dart';

class DeleteAllAddressUseCase extends UseCase<DataSourceState<bool>> {
  DeleteAllAddressUseCase({
    required this.userAddressRepository,
  });
  final UserAddressRepository userAddressRepository;
  @override
  Future<DataSourceState<bool>> call() async {
    return userAddressRepository.deleteAllAddress();
  }
}
