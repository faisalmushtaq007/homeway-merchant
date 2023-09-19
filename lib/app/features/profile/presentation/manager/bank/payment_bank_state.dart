part of 'payment_bank_bloc.dart';

abstract class PaymentBankState extends Equatable {
  const PaymentBankState();
}

class PaymentBankInitial extends PaymentBankState {
  const PaymentBankInitial();
  @override
  List<Object?> get props => [];
}

class SavePaymentBankState extends PaymentBankState {
  const SavePaymentBankState({
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
  List<Object?> get props => [paymentBankEntity, hasEditPaymentBank, currentIndex, paymentBankStatus];
}

class GetPaymentBankState extends PaymentBankState {
  const GetPaymentBankState({
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
  List<Object?> get props => [
        paymentBankEntity,
        paymentBankStatus,
        index,
        paymentBankID,
      ];
}

class SaveBusinessTypeState extends PaymentBankState {
  const SaveBusinessTypeState({
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
  List<Object?> get props => [
        businessTypeEntity,
        hasEditBusinessType,
        paymentBankStatus,
        hasEditBusinessType,
      ];
}

class DeletePaymentBankState extends PaymentBankState {
  const DeletePaymentBankState({
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
  List<Object?> get props => [
        paymentBankEntity,
        paymentBankID,
        index,
        paymentBankStatus,
        paymentBankEntities,
        hasDelete,
      ];
}

class NavigateToAddressPageState extends PaymentBankState {
  const NavigateToAddressPageState({
    this.paymentBankEntity,
    this.businessTypeEntity,
    this.paymentBankStatus = PaymentBankStatus.navigateToAddressPage,
  });

  final PaymentBankEntity? paymentBankEntity;
  final BusinessTypeEntity? businessTypeEntity;
  final PaymentBankStatus paymentBankStatus;

  @override
  List<Object?> get props => [paymentBankEntity, businessTypeEntity, paymentBankStatus];
}

class DeleteAllPaymentBankState extends PaymentBankState {
  const DeleteAllPaymentBankState({
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
  List<Object?> get props => [paymentBankEntity, paymentBankID, paymentBankStatus];
}

class GetAllPaymentBankState extends PaymentBankState {
  const GetAllPaymentBankState({
    this.paymentBankID = -1,
    this.paymentBankEntity,
    this.paymentBankEntities = const [],
    this.paymentBankStatus = PaymentBankStatus.getAllPaymentBank,
    this.searchItem = '',
    this.pageSize = 10,
    this.pageKey = 1,
  });

  final PaymentBankEntity? paymentBankEntity;
  final int paymentBankID;
  final List<PaymentBankEntity> paymentBankEntities;
  final PaymentBankStatus paymentBankStatus;
  final int pageKey;
  final int pageSize;
  final String searchItem;

  @override
  List<Object?> get props => [
        paymentBankEntity,
        paymentBankID,
        paymentBankStatus,
        pageKey,
        pageSize,
        searchItem,
      ];
}

class PaymentBankEmptyState extends PaymentBankState {
  const PaymentBankEmptyState({
    this.paymentBankEntities = const [],
    this.message = '',
    this.paymentBankStatus = PaymentBankStatus.emptyForPaymentBank,
  });

  final List<PaymentBankEntity> paymentBankEntities;
  final String message;
  final PaymentBankStatus paymentBankStatus;

  @override
  List<Object?> get props => [
        paymentBankEntities,
        message,
        paymentBankStatus,
      ];
}

class PaymentBankFailedState extends PaymentBankState {
  const PaymentBankFailedState({
    this.paymentBankStatus = PaymentBankStatus.failedForPaymentBank,
    this.message = '',
  });

  final PaymentBankStatus paymentBankStatus;
  final String message;

  @override
  List<Object?> get props => [
        paymentBankStatus,
        message,
      ];
}

class PaymentBankExceptionState extends PaymentBankState {
  const PaymentBankExceptionState({
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
  List<Object?> get props => throw UnimplementedError();
}

class PaymentBankLoadingState extends PaymentBankState {
  const PaymentBankLoadingState({this.message = '', this.paymentBankStatus = PaymentBankStatus.loadingForPaymentBank, this.isLoading = true});

  final bool isLoading;
  final PaymentBankStatus paymentBankStatus;
  final String message;

  @override
  List<Object?> get props => throw UnimplementedError();
}

class PaymentBankProcessingState extends PaymentBankState {
  const PaymentBankProcessingState({this.message = '', this.paymentBankStatus = PaymentBankStatus.loadingForPaymentBank, this.isProcessing = true});

  final bool isProcessing;
  final PaymentBankStatus paymentBankStatus;
  final String message;

  @override
  List<Object?> get props => throw UnimplementedError();
}

class NavigateToNextPageState extends PaymentBankState{
  const NavigateToNextPageState({required this.appUserEntity,});
  final  AppUserEntity appUserEntity;
  @override
  List<Object?> get props => [appUserEntity];
}

