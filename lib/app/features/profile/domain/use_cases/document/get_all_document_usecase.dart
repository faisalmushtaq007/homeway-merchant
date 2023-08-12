part of 'package:homemakers_merchant/app/features/profile/index.dart';

class GetAllDocumentUseCase extends UseCase<DataSourceState<List<BusinessDocumentUploadedEntity>>> {
  GetAllDocumentUseCase({
    required this.userBusinessDocumentRepository,
  });
  final UserBusinessDocumentRepository userBusinessDocumentRepository;
  @override
  Future<DataSourceState<List<BusinessDocumentUploadedEntity>>> call() async {
    return userBusinessDocumentRepository.getAllBusinessDocument();
  }
}
