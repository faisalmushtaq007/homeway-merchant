part of 'package:homemakers_merchant/app/features/store/index.dart';

class GetAllStorePaginationUseCase extends PaginationQueryAllUseCaseIORecord<StoreEntity, int, int, String?, String?,
    String?, Timestamp?, Timestamp?, DataSourceState<List<StoreEntity>>> {
  GetAllStorePaginationUseCase({
    required this.storeRepository,
  });

  final StoreRepository storeRepository;

  @override
  Future<DataSourceState<List<StoreEntity>>> call(
      {int pageKey = 0,
      int pageSize = 20,
      String? searchText,
      StoreEntity? entity,
      String? filtering,
      String? sorting,
      Timestamp? startTime,
      Timestamp? endTime}) async {
    return await storeRepository.getAllStorePagination(
      pageKey: pageKey,
      pageSize: pageSize,
      searchText: searchText,
      storeEntity: entity,
      filtering: filtering,
      sorting: sorting,
      startTime: startTime,
      endTime: endTime,
    );
  }
}
