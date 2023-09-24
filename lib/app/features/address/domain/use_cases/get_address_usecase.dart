part of 'package:homemakers_merchant/app/features/address/index.dart';

class GetAddressUseCase
    extends UseCaseByID<AddressModel, int, DataSourceState<AddressModel>> {
  GetAddressUseCase({
    required this.userAddressRepository,
  });
  final UserAddressRepository userAddressRepository;
  @override
  Future<DataSourceState<AddressModel>> call(
      {required int id, AddressModel? input}) async {
    return userAddressRepository.getAddress(
        addressEntity: input, addressID: id);
  }
}
