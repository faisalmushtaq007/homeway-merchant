part of 'package:homemakers_merchant/app/features/store/index.dart';


class GetAllDriverPaginationUseCase extends PaginationQueryAllUseCaseIORecord<
    StoreOwnDeliveryPartnersInfo,
    int,
    int,
    String?,
    String?,
    String?,
    Timestamp?,
    Timestamp?,
    DataSourceState<List<StoreOwnDeliveryPartnersInfo>>> {
  GetAllDriverPaginationUseCase({
    required this.storeRepository,
  });

  final StoreRepository storeRepository;

  @override
  Future<DataSourceState<List<StoreOwnDeliveryPartnersInfo>>> call(
      {int pageKey = 0,
      int pageSize = 10,
      String? searchText,
      StoreOwnDeliveryPartnersInfo? entity,
      String? filtering,
      String? sorting,
      Timestamp? startTime,
      Timestamp? endTime}) async {
    return await storeRepository.getAllDriverPagination(
      pageKey: pageKey,
      pageSize: pageSize,
      searchText: searchText,
      driverEntity: entity,
      filtering: filtering,
      sorting: sorting,
      startTime: startTime,
      endTime: endTime,
    );
  }
}
