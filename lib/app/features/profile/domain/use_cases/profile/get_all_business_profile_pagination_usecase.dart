part of 'package:homemakers_merchant/app/features/profile/index.dart';

class GetAllBusinessProfilePaginationUseCase
    extends PaginationQueryAllUseCaseIORecord<
        BusinessProfileEntity,
        int,
        int,
        String?,
        String?,
        String?,
        Timestamp?,
        Timestamp?,
        DataSourceState<List<BusinessProfileEntity>>> {
  GetAllBusinessProfilePaginationUseCase({
    required this.userBusinessProfileRepository,
  });

  final UserBusinessProfileRepository userBusinessProfileRepository;

  @override
  Future<DataSourceState<List<BusinessProfileEntity>>> call({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    BusinessProfileEntity? entity,
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  }) async {
    return await userBusinessProfileRepository.getAllBusinessProfilePagination(
      pageKey: pageKey,
      pageSize: pageSize,
      searchText: searchText,
      extras: (entity.isNotNull) ? entity!.toMap() : const <String, dynamic>{},
      filtering: filtering,
      sorting: sorting,
      startTime: startTime,
      endTime: endTime,
    );
  }
}
