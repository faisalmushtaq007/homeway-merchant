part of 'package:homemakers_merchant/app/features/profile/index.dart';

class PaymentBankEntity with AppEquatable {
  PaymentBankEntity({
    this.paymentBankID = -1,
    this.bankHolderName = '',
    this.bankName = '',
    this.accountNumber = '',
    this.ibanNumber = '',
    this.acceptPaymentMode = AcceptPaymentMode.none,
  });

  factory PaymentBankEntity.fromMap(Map<String, dynamic> map) {
    return PaymentBankEntity(
      paymentBankID: map['paymentBankID'] ?? -1,
      bankHolderName: map['bankHolderName'] ?? '',
      bankName: map['bankName'] ?? '',
      accountNumber: map['accountNumber'] ?? '',
      ibanNumber: map['ibanNumber'] ?? '',
      acceptPaymentMode: (map['acceptPaymentMode'] != null)
          ? AcceptPaymentMode.values.byName(map['acceptPaymentMode'])
          : AcceptPaymentMode.none,
    );
  }

  final int paymentBankID;
  final String bankHolderName;
  final String bankName;
  final String accountNumber;
  final String ibanNumber;
  final AcceptPaymentMode acceptPaymentMode;

  @override
  String toString() {
    return 'PaymentBankEntity{ paymentBankID: $paymentBankID, bankHolderName: $bankHolderName, bankName: $bankName, accountNumber: $accountNumber, ibanNumber: $ibanNumber, acceptPaymentMode: $acceptPaymentMode,}';
  }

  PaymentBankEntity copyWith({
    int? paymentBankID,
    String? bankHolderName,
    String? bankName,
    String? accountNumber,
    String? ibanNumber,
    AcceptPaymentMode? acceptPaymentMode,
  }) {
    return PaymentBankEntity(
      paymentBankID: paymentBankID ?? this.paymentBankID,
      bankHolderName: bankHolderName ?? this.bankHolderName,
      bankName: bankName ?? this.bankName,
      accountNumber: accountNumber ?? this.accountNumber,
      ibanNumber: ibanNumber ?? this.ibanNumber,
      acceptPaymentMode: acceptPaymentMode ?? this.acceptPaymentMode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'paymentBankID': this.paymentBankID,
      'bankHolderName': this.bankHolderName,
      'bankName': this.bankName,
      'accountNumber': this.accountNumber,
      'ibanNumber': this.ibanNumber,
      'acceptPaymentMode': this.acceptPaymentMode.name,
    };
  }

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        paymentBankID,
        bankHolderName,
        bankName,
        accountNumber,
        ibanNumber,
        acceptPaymentMode,
      ];
}
