part of 'package:homemakers_merchant/app/features/address/index.dart';

class DeleteAddressUseCase
    extends UseCaseByID<AddressModel, int, DataSourceState<bool>> {
  DeleteAddressUseCase({
    required this.userAddressRepository,
  });
  final UserAddressRepository userAddressRepository;
  @override
  Future<DataSourceState<bool>> call(
      {required int id, AddressModel? input}) async {
    return userAddressRepository.deleteAddress(
        addressEntity: input, addressID: id);
  }
}
