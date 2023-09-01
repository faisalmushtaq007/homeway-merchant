part of 'package:homemakers_merchant/app/features/common/index.dart';

class DeleteAllFromLocalDBUseCase extends UseCase<bool> {
  DeleteAllFromLocalDBUseCase({
    required this.commonRepository,
  });
  final CommonRepository commonRepository;

  @override
  Future<bool> call() async {
    return await commonRepository.deleteAllFromLocalDB();
  }
}
