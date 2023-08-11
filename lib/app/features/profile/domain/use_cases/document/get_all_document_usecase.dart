part of 'package:homemakers_merchant/app/features/profile/index.dart';

class GetAllDocumentUseCase extends UseCaseByID<BusinessDocumentUploadedEntity, int, DataSourceState<List<BusinessDocumentUploadedEntity>>> {
  GetAllDocumentUseCase({
    required this.userBusinessDocumentRepository,
  });
  final UserBusinessDocumentRepository userBusinessDocumentRepository;
  @override
  Future<DataSourceState<List<BusinessDocumentUploadedEntity>>> call({required int id, BusinessDocumentUploadedEntity? input}) async {
    return userBusinessDocumentRepository.getAllBusinessDocument();
  }
}
