part of 'package:homemakers_merchant/app/features/address/index.dart';

class GetAllAddressUseCase extends UseCase<DataSourceState<List<AddressModel>>> {
  GetAllAddressUseCase({
    required this.userAddressRepository,
  });
  final UserAddressRepository userAddressRepository;
  @override
  Future<DataSourceState<List<AddressModel>>> call() async {
    return userAddressRepository.getAllAddress();
  }
}
