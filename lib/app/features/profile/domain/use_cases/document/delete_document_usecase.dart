part of 'package:homemakers_merchant/app/features/profile/index.dart';

class DeleteDocumentUseCase
    extends UseCaseByID<NewBusinessDocumentEntity, int, DataSourceState<bool>> {
  DeleteDocumentUseCase({
    required this.userBusinessDocumentRepository,
  });
  final UserBusinessDocumentRepository userBusinessDocumentRepository;
  @override
  Future<DataSourceState<bool>> call(
      {required int id, NewBusinessDocumentEntity? input}) async {
    return userBusinessDocumentRepository.deleteBusinessDocument(
        businessDocumentUploadedEntity: input, documentID: id);
  }
}
