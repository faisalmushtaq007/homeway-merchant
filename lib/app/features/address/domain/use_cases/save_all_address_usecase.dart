part of 'package:homemakers_merchant/app/features/address/index.dart';

class SaveAllAddressUseCase extends UseCaseIO<List<AddressModel>, DataSourceState<List<AddressModel>>> {
  SaveAllAddressUseCase({
    required this.userAddressRepository,
  });
  final UserAddressRepository userAddressRepository;
  @override
  Future<DataSourceState<List<AddressModel>>> call(List<AddressModel> input) async {
    return userAddressRepository.saveAllAddress(
      addressEntities: input,
      hasUpdateAll: false,
    );
  }
}
