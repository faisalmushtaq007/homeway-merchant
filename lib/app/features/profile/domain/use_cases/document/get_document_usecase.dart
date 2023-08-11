part of 'package:homemakers_merchant/app/features/profile/index.dart';

class GetDocumentUseCase extends UseCaseByID<BusinessDocumentUploadedEntity, int, DataSourceState<BusinessDocumentUploadedEntity>> {
  GetDocumentUseCase({
    required this.userBusinessDocumentRepository,
  });
  final UserBusinessDocumentRepository userBusinessDocumentRepository;
  @override
  Future<DataSourceState<BusinessDocumentUploadedEntity>> call({required int id, BusinessDocumentUploadedEntity? input}) async {
    return userBusinessDocumentRepository.getBusinessDocument(businessDocumentUploadedEntity: input, documentID: id);
  }
}
