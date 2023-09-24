part of 'payment_bank_bloc.dart';

abstract class PaymentBankEvent extends Equatable {
  const PaymentBankEvent();
}

class SavePaymentBank extends PaymentBankEvent {
  SavePaymentBank(
      {required this.paymentBankEntity,
      this.hasEditPaymentBank = false,
      this.currentIndex = -1});
  final PaymentBankEntity paymentBankEntity;
  final bool hasEditPaymentBank;
  final int currentIndex;

  @override
  List<Object?> get props =>
      [paymentBankEntity, hasEditPaymentBank, currentIndex];
}

class DeletePaymentBank extends PaymentBankEvent {
  const DeletePaymentBank({
    required this.paymentBankID,
    this.paymentBankEntity,
    this.index = -1,
    this.paymentBankEntities = const [],
  });
  final PaymentBankEntity? paymentBankEntity;
  final int paymentBankID;
  final int index;
  final List<PaymentBankEntity> paymentBankEntities;

  @override
  List<Object?> get props => [
        paymentBankEntity,
        paymentBankID,
        index,
        paymentBankEntities,
      ];
}

class GetPaymentBank extends PaymentBankEvent {
  const GetPaymentBank({
    required this.paymentBankID,
    this.paymentBankEntity,
    this.index = -1,
  });
  final PaymentBankEntity? paymentBankEntity;
  final int paymentBankID;
  final int index;

  @override
  List<Object?> get props => [paymentBankEntity, paymentBankID];
}

class DeleteAllPaymentBank extends PaymentBankEvent {
  const DeleteAllPaymentBank({
    this.paymentBankID = -1,
    this.paymentBankEntity,
    this.paymentBankEntities = const [],
  });
  final PaymentBankEntity? paymentBankEntity;
  final int paymentBankID;
  final List<PaymentBankEntity> paymentBankEntities;

  @override
  List<Object?> get props => [paymentBankEntity, paymentBankID];
}

class GetAllPaymentBank extends PaymentBankEvent {
  const GetAllPaymentBank({
    this.paymentBankID = -1,
    this.paymentBankEntity,
    this.paymentBankEntities = const [],
    this.searchItem = '',
    this.pageSize = 10,
    this.pageKey = 1,
  });
  final PaymentBankEntity? paymentBankEntity;
  final int paymentBankID;
  final List<PaymentBankEntity> paymentBankEntities;

  final int pageKey;
  final int pageSize;
  final String searchItem;

  @override
  List<Object?> get props => [
        paymentBankEntity,
        paymentBankID,
        pageKey,
        pageSize,
        searchItem,
      ];
}

class NavigateToNextPage extends PaymentBankEvent {
  const NavigateToNextPage({
    required this.appUserEntity,
  });
  final AppUserEntity appUserEntity;
  @override
  List<Object?> get props => [appUserEntity];
}
