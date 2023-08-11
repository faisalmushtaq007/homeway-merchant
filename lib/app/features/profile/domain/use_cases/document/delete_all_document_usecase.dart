part of 'package:homemakers_merchant/app/features/profile/index.dart';

class DeleteAllDocumentUseCase extends UseCaseByID<BusinessDocumentUploadedEntity, int, DataSourceState<bool>> {
  DeleteAllDocumentUseCase({
    required this.userBusinessDocumentRepository,
  });
  final UserBusinessDocumentRepository userBusinessDocumentRepository;
  @override
  Future<DataSourceState<bool>> call({required int id, BusinessDocumentUploadedEntity? input}) async {
    return userBusinessDocumentRepository.deleteAllBusinessDocument();
  }
}
