part of 'package:homemakers_merchant/app/features/menu/index.dart';

class GetAllAddonsPaginationUseCase extends PaginationQueryAllUseCaseIORecord<
    Addons,
    int,
    int,
    String?,
    String?,
    String?,
    Timestamp?,
    Timestamp?,
    DataSourceState<List<Addons>>> {
  GetAllAddonsPaginationUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;

  @override
  Future<DataSourceState<List<Addons>>> call(
      {int pageKey = 0,
      int pageSize = 10,
      String? searchText,
      Addons? entity,
      String? filtering,
      String? sorting,
      Timestamp? startTime,
      Timestamp? endTime}) async {
    return await menuRepository.getAllAddonsPagination(
      pageKey: pageKey,
      pageSize: pageSize,
      searchText: searchText,
      addonsEntity: entity,
      filtering: filtering,
      sorting: sorting,
      startTime: startTime,
      endTime: endTime,
    );
  }
}
