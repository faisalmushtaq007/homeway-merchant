part of 'package:homemakers_merchant/app/features/profile/index.dart';

class DeleteAllDocumentUseCase extends UseCase<DataSourceState<bool>> {
  DeleteAllDocumentUseCase({
    required this.userBusinessDocumentRepository,
  });
  final UserBusinessDocumentRepository userBusinessDocumentRepository;
  @override
  Future<DataSourceState<bool>> call() async {
    return userBusinessDocumentRepository.deleteAllBusinessDocument();
  }
}
