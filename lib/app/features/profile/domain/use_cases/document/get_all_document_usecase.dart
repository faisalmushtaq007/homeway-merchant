part of 'package:homemakers_merchant/app/features/profile/index.dart';

class GetAllDocumentUseCase extends UseCase<DataSourceState<List<NewBusinessDocumentEntity>>> {
  GetAllDocumentUseCase({
    required this.userBusinessDocumentRepository,
  });
  final UserBusinessDocumentRepository userBusinessDocumentRepository;
  @override
  Future<DataSourceState<List<NewBusinessDocumentEntity>>> call() async {
    return userBusinessDocumentRepository.getAllBusinessDocument();
  }
}
