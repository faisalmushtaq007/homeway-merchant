part of 'package:homemakers_merchant/app/features/profile/index.dart';

class SaveDocumentUseCase extends UseCaseIO<NewBusinessDocumentEntity,
    DataSourceState<NewBusinessDocumentEntity>> {
  SaveDocumentUseCase({
    required this.userBusinessDocumentRepository,
  });
  final UserBusinessDocumentRepository userBusinessDocumentRepository;
  @override
  Future<DataSourceState<NewBusinessDocumentEntity>> call(
      NewBusinessDocumentEntity input) async {
    return userBusinessDocumentRepository.saveBusinessDocument(
        businessDocumentUploadedEntity: input);
  }
}
