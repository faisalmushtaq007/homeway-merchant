part of 'package:homemakers_merchant/app/features/profile/index.dart';

class GetDocumentUseCase extends UseCaseByID<NewBusinessDocumentEntity, int, DataSourceState<NewBusinessDocumentEntity>> {
  GetDocumentUseCase({
    required this.userBusinessDocumentRepository,
  });
  final UserBusinessDocumentRepository userBusinessDocumentRepository;
  @override
  Future<DataSourceState<NewBusinessDocumentEntity>> call({required int id, NewBusinessDocumentEntity? input}) async {
    return userBusinessDocumentRepository.getBusinessDocument(businessDocumentUploadedEntity: input, documentID: id);
  }
}
