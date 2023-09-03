part of 'package:homemakers_merchant/app/features/profile/index.dart';

class EditDocumentUseCase extends UseCaseByIDAndEntity<NewBusinessDocumentEntity, int, DataSourceState<NewBusinessDocumentEntity>> {
  EditDocumentUseCase({
    required this.userBusinessDocumentRepository,
  });
  final UserBusinessDocumentRepository userBusinessDocumentRepository;

  @override
  Future<DataSourceState<NewBusinessDocumentEntity>> call({required NewBusinessDocumentEntity input, required int id}) async {
    return userBusinessDocumentRepository.editBusinessDocument(businessDocumentUploadedEntity: input, documentID: id);
  }
}
