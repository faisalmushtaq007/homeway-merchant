part of 'package:homemakers_merchant/app/features/profile/index.dart';

class EditDocumentUseCase extends UseCaseByIDAndEntity<BusinessDocumentUploadedEntity, int, DataSourceState<BusinessDocumentUploadedEntity>> {
  EditDocumentUseCase({
    required this.userBusinessDocumentRepository,
  });
  final UserBusinessDocumentRepository userBusinessDocumentRepository;

  @override
  Future<DataSourceState<BusinessDocumentUploadedEntity>> call({required BusinessDocumentUploadedEntity input, required int id}) async {
    return userBusinessDocumentRepository.editBusinessDocument(businessDocumentUploadedEntity: input, documentID: id);
  }
}
