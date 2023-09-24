part of 'package:homemakers_merchant/app/features/profile/index.dart';

class GetAllPaymentBankPaginationUseCase
    extends PaginationQueryAllUseCaseIORecord<
        PaymentBankEntity,
        int,
        int,
        String?,
        String?,
        String?,
        Timestamp?,
        Timestamp?,
        DataSourceState<List<PaymentBankEntity>>> {
  GetAllPaymentBankPaginationUseCase({
    required this.userPaymentBankRepository,
  });

  final UserPaymentBankRepository userPaymentBankRepository;

  @override
  Future<DataSourceState<List<PaymentBankEntity>>> call({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    PaymentBankEntity? entity,
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  }) async {
    return await userPaymentBankRepository.getAllPaymentBanksPagination(
      pageKey: pageKey,
      pageSize: pageSize,
      searchText: searchText,
      extras: (entity.isNotNull) ? entity!.toMap() : const <String, dynamic>{},
      filtering: filtering,
      sorting: sorting,
      startTime: startTime,
      endTime: endTime,
    );
  }
}
