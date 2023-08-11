part of 'package:homemakers_merchant/app/features/profile/index.dart';

class DeleteDocumentUseCase extends UseCaseByID<BusinessDocumentUploadedEntity, int, DataSourceState<bool>> {
  DeleteDocumentUseCase({
    required this.userBusinessDocumentRepository,
  });
  final UserBusinessDocumentRepository userBusinessDocumentRepository;
  @override
  Future<DataSourceState<bool>> call({required int id, BusinessDocumentUploadedEntity? input}) async {
    return userBusinessDocumentRepository.deleteBusinessDocument(businessDocumentUploadedEntity: input, documentID: id);
  }
}
