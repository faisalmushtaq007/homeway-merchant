part of 'package:homemakers_merchant/app/features/profile/index.dart';

class SaveAllDocumentUseCase extends UseCaseIO<List<NewBusinessDocumentEntity>, DataSourceState<List<NewBusinessDocumentEntity>>> {
  SaveAllDocumentUseCase({
    required this.userBusinessDocumentRepository,
  });
  final UserBusinessDocumentRepository userBusinessDocumentRepository;
  @override
  Future<DataSourceState<List<NewBusinessDocumentEntity>>> call(List<NewBusinessDocumentEntity> input) async {
    return await userBusinessDocumentRepository.saveAllBusinessDocuments(
      businessDocuments: input,
      hasUpdateAll: false,
    );
  }
}
