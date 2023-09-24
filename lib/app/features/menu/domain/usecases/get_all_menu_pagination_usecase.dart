part of 'package:homemakers_merchant/app/features/menu/index.dart';

class GetAllMenuPaginationUseCase extends PaginationQueryAllUseCaseIORecord<
    MenuEntity,
    int,
    int,
    String?,
    String?,
    String?,
    Timestamp?,
    Timestamp?,
    DataSourceState<List<MenuEntity>>> {
  GetAllMenuPaginationUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;

  @override
  Future<DataSourceState<List<MenuEntity>>> call(
      {int pageKey = 0,
      int pageSize = 20,
      String? searchText,
      MenuEntity? entity,
      String? filtering,
      String? sorting,
      Timestamp? startTime,
      Timestamp? endTime}) async {
    return await menuRepository.getAllMenuPagination(
      pageKey: pageKey,
      pageSize: pageSize,
      searchText: searchText,
      menuEntity: entity,
      filtering: filtering,
      sorting: sorting,
      startTime: startTime,
      endTime: endTime,
    );
  }
}
