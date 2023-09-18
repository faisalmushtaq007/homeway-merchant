part of 'package:homemakers_merchant/app/features/profile/index.dart';

class GetAllDocumentPaginationUseCase extends PaginationQueryAllUseCaseIORecord<NewBusinessDocumentEntity, int, int, String?,
    String?, String?, Timestamp?, Timestamp?, DataSourceState<List<NewBusinessDocumentEntity>>> {
  GetAllDocumentPaginationUseCase({
    required this.userBusinessDocumentRepository,
  });

  final UserBusinessDocumentRepository userBusinessDocumentRepository;

  @override
  Future<DataSourceState<List<NewBusinessDocumentEntity>>> call({
    int pageKey=0,
    int pageSize=10,
    String? searchText,
    NewBusinessDocumentEntity? entity,
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  }) async{
    return await userBusinessDocumentRepository.getAllBusinessDocumentsPagination(
      pageKey: pageKey,
      pageSize: pageSize,
      searchText: searchText,
      extras: (entity.isNotNull)?entity!.toMap():const <String,dynamic>{},
      filtering: filtering,
      sorting: sorting,
      startTime: startTime,
      endTime: endTime,
    );
  }
}
