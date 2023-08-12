part of 'payment_bank_bloc.dart';

abstract class PaymentBankEvent with AppEquatable {}

class SavePaymentBank extends PaymentBankEvent {
  SavePaymentBank({required this.paymentBankEntity, this.hasEditPaymentBank = false, this.currentIndex = -1});
  final PaymentBankEntity paymentBankEntity;
  final bool hasEditPaymentBank;
  final int currentIndex;
  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [paymentBankEntity, hasEditPaymentBank, currentIndex];
}

class DeletePaymentBank extends PaymentBankEvent {
  DeletePaymentBank({
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
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        paymentBankEntity,
        paymentBankID,
        index,
        paymentBankEntities,
      ];
}

class GetPaymentBank extends PaymentBankEvent {
  GetPaymentBank({
    required this.paymentBankID,
    this.paymentBankEntity,
    this.index = -1,
  });
  final PaymentBankEntity? paymentBankEntity;
  final int paymentBankID;
  final int index;
  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [paymentBankEntity, paymentBankID];
}

class DeleteAllPaymentBank extends PaymentBankEvent {
  DeleteAllPaymentBank({
    this.paymentBankID = -1,
    this.paymentBankEntity,
    this.paymentBankEntities = const [],
  });
  final PaymentBankEntity? paymentBankEntity;
  final int paymentBankID;
  final List<PaymentBankEntity> paymentBankEntities;
  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [paymentBankEntity, paymentBankID];
}

class GetAllPaymentBank extends PaymentBankEvent {
  GetAllPaymentBank({
    this.paymentBankID = -1,
    this.paymentBankEntity,
    this.paymentBankEntities = const [],
  });
  final PaymentBankEntity? paymentBankEntity;
  final int paymentBankID;
  final List<PaymentBankEntity> paymentBankEntities;
  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [paymentBankEntity, paymentBankID];
}
