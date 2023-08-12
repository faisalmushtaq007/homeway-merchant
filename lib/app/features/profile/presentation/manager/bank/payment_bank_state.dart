part of 'payment_bank_bloc.dart';

abstract class PaymentBankState with AppEquatable {}

class PaymentBankInitial extends PaymentBankState {
  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [];
}

class SavePaymentBankState extends PaymentBankState {
  SavePaymentBankState({
    required this.paymentBankEntity,
    this.hasEditPaymentBank = false,
    this.currentIndex = -1,
    this.paymentBankStatus = PaymentBankStatus.savePaymentBank,
  });

  final PaymentBankEntity paymentBankEntity;
  final bool hasEditPaymentBank;
  final int currentIndex;
  final PaymentBankStatus paymentBankStatus;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [paymentBankEntity, hasEditPaymentBank, currentIndex, paymentBankStatus];
}

class GetPaymentBankState extends PaymentBankState {
  GetPaymentBankState({
    this.paymentBankEntity,
    this.paymentBankStatus = PaymentBankStatus.getAllPaymentBank,
    this.index = -1,
    this.paymentBankID = -1,
  });

  final PaymentBankEntity? paymentBankEntity;
  final int index;
  final PaymentBankStatus paymentBankStatus;
  final int paymentBankID;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        paymentBankEntity,
        paymentBankStatus,
        index,
        paymentBankID,
      ];
}

class SaveBusinessTypeState extends PaymentBankState {
  SaveBusinessTypeState({
    required this.businessTypeEntity,
    this.hasEditBusinessType = false,
    this.paymentBankEntity,
    this.paymentBankStatus = PaymentBankStatus.savePaymentBank,
  });

  final BusinessTypeEntity businessTypeEntity;
  final bool hasEditBusinessType;
  final PaymentBankEntity? paymentBankEntity;
  final PaymentBankStatus paymentBankStatus;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        businessTypeEntity,
        hasEditBusinessType,
        paymentBankStatus,
        hasEditBusinessType,
      ];
}

class DeletePaymentBankState extends PaymentBankState {
  DeletePaymentBankState({
    required this.paymentBankID,
    this.paymentBankEntity,
    this.paymentBankStatus = PaymentBankStatus.deletePaymentBank,
    this.index = -1,
    this.paymentBankEntities = const [],
    this.hasDelete = false,
  });

  final PaymentBankEntity? paymentBankEntity;
  final int paymentBankID;
  final PaymentBankStatus paymentBankStatus;
  final int index;
  final List<PaymentBankEntity> paymentBankEntities;
  final bool hasDelete;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        paymentBankEntity,
        paymentBankID,
        index,
        paymentBankStatus,
        paymentBankEntities,
        hasDelete,
      ];
}

class NavigateToAddressPageState extends PaymentBankState {
  NavigateToAddressPageState({
    this.paymentBankEntity,
    this.businessTypeEntity,
    this.paymentBankStatus = PaymentBankStatus.navigateToAddressPage,
  });

  final PaymentBankEntity? paymentBankEntity;
  final BusinessTypeEntity? businessTypeEntity;
  final PaymentBankStatus paymentBankStatus;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [paymentBankEntity, businessTypeEntity, paymentBankStatus];
}

class DeleteAllPaymentBankState extends PaymentBankState {
  DeleteAllPaymentBankState({
    this.paymentBankID = -1,
    this.paymentBankEntity,
    this.hasDeleteAll = false,
    this.paymentBankEntities = const [],
    this.paymentBankStatus = PaymentBankStatus.deleteAllPaymentBank,
  });

  final PaymentBankEntity? paymentBankEntity;
  final int paymentBankID;
  final bool hasDeleteAll;
  final List<PaymentBankEntity> paymentBankEntities;
  final PaymentBankStatus paymentBankStatus;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [paymentBankEntity, paymentBankID, paymentBankStatus];
}

class GetAllPaymentBankState extends PaymentBankState {
  GetAllPaymentBankState({
    this.paymentBankID = -1,
    this.paymentBankEntity,
    this.paymentBankEntities = const [],
    this.paymentBankStatus = PaymentBankStatus.getAllPaymentBank,
  });

  final PaymentBankEntity? paymentBankEntity;
  final int paymentBankID;
  final List<PaymentBankEntity> paymentBankEntities;
  final PaymentBankStatus paymentBankStatus;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [paymentBankEntity, paymentBankID, paymentBankStatus];
}

class PaymentBankEmptyState extends PaymentBankState {
  PaymentBankEmptyState({
    this.paymentBankEntities = const [],
    this.message = '',
    this.paymentBankStatus = PaymentBankStatus.emptyForPaymentBank,
  });

  final List<PaymentBankEntity> paymentBankEntities;
  final String message;
  final PaymentBankStatus paymentBankStatus;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        paymentBankEntities,
        message,
        paymentBankStatus,
      ];
}

class PaymentBankFailedState extends PaymentBankState {
  PaymentBankFailedState({
    this.paymentBankStatus = PaymentBankStatus.failedForPaymentBank,
    this.message = '',
  });

  final PaymentBankStatus paymentBankStatus;
  final String message;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        paymentBankStatus,
        message,
      ];
}

class PaymentBankExceptionState extends PaymentBankState {
  PaymentBankExceptionState({
    this.paymentBankStatus = PaymentBankStatus.exceptionForPaymentBank,
    this.message = '',
    this.stackTrace,
    this.exception,
  });

  final PaymentBankStatus paymentBankStatus;
  final String message;
  final StackTrace? stackTrace;
  final Exception? exception;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => throw UnimplementedError();
}

class PaymentBankLoadingState extends PaymentBankState {
  PaymentBankLoadingState({this.message = '', this.paymentBankStatus = PaymentBankStatus.loadingForPaymentBank, this.isLoading = true});

  final bool isLoading;
  final PaymentBankStatus paymentBankStatus;
  final String message;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => throw UnimplementedError();
}

class PaymentBankProcessingState extends PaymentBankState {
  PaymentBankProcessingState({this.message = '', this.paymentBankStatus = PaymentBankStatus.loadingForPaymentBank, this.isProcessing = true});

  final bool isProcessing;
  final PaymentBankStatus paymentBankStatus;
  final String message;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => throw UnimplementedError();
}
