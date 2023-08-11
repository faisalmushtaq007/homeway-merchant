part of 'package:homemakers_merchant/app/features/profile/index.dart';

class SaveDocumentUseCase extends UseCaseIO<BusinessDocumentUploadedEntity, DataSourceState<BusinessDocumentUploadedEntity>> {
  SaveDocumentUseCase({
    required this.userBusinessDocumentRepository,
  });
  final UserBusinessDocumentRepository userBusinessDocumentRepository;
  @override
  Future<DataSourceState<BusinessDocumentUploadedEntity>> call(BusinessDocumentUploadedEntity input) async {
    return userBusinessDocumentRepository.saveBusinessDocument(businessDocumentUploadedEntity: input);
  }
}
