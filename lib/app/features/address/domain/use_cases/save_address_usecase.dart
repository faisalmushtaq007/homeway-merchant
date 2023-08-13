part of 'package:homemakers_merchant/app/features/address/index.dart';

class SaveAddressUseCase extends UseCaseIO<AddressModel, DataSourceState<AddressModel>> {
  SaveAddressUseCase({
    required this.userAddressRepository,
  });
  final UserAddressRepository userAddressRepository;
  @override
  Future<DataSourceState<AddressModel>> call(AddressModel input) async {
    return userAddressRepository.saveAddress(addressEntity: input);
  }
}
