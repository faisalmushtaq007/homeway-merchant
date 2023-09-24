part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class GetAllAppUserPaginationUseCase extends PaginationQueryAllUseCaseIORecord<
    AppUserEntity,
    int,
    int,
    String?,
    String?,
    String?,
    Timestamp?,
    Timestamp?,
    DataSourceState<List<AppUserEntity>>> {
  GetAllAppUserPaginationUseCase({
    required this.authenticationRepository,
  });

  final AuthenticationRepository authenticationRepository;

  @override
  Future<DataSourceState<List<AppUserEntity>>> call({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    AppUserEntity? entity,
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  }) async {
    return await authenticationRepository.getAllUsersPagination(
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
