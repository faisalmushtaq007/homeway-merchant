part of 'package:homemakers_merchant/app/features/address/index.dart';

class EditAddressUseCase extends UseCaseByIDAndEntity<AddressModel, int,
    DataSourceState<AddressModel>> {
  EditAddressUseCase({
    required this.userAddressRepository,
  });
  final UserAddressRepository userAddressRepository;

  @override
  Future<DataSourceState<AddressModel>> call(
      {required AddressModel input, required int id}) async {
    return userAddressRepository.editAddress(
        addressEntity: input, addressID: id);
  }
}
