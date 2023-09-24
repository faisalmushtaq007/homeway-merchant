part of 'package:homemakers_merchant/app/features/address/index.dart';

class GetAllAddressPaginationUseCase extends AddressQueryAllUseCaseIORecord<
    AddressModel,
    int,
    int,
    String?,
    String?,
    String?,
    Timestamp?,
    Timestamp?,
    DataSourceState<List<AddressModel>>> {
  GetAllAddressPaginationUseCase({
    required this.userAddressRepository,
  });

  final UserAddressRepository userAddressRepository;

  @override
  Future<DataSourceState<List<AddressModel>>> call(
      {int pageKey = 0,
      int pageSize = 20,
      String? searchText,
      AddressModel? addressEntity,
      String? filtering,
      String? sorting,
      Timestamp? startTime,
      Timestamp? endTime}) async {
    return await userAddressRepository.getAllAddressPagination(
      pageKey: pageKey,
      pageSize: pageSize,
      searchText: searchText,
      addressEntity: addressEntity,
      filtering: filtering,
      sorting: sorting,
      startTime: startTime,
      endTime: endTime,
    );
  }
}
