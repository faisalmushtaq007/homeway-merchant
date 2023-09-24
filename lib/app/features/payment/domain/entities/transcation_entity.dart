part of 'package:homemakers_merchant/app/features/payment/index.dart';

TranscationEntity transcationEntityFromJson(String str) =>
    TranscationEntity.fromJson(json.decode(str));

String transcationEntityToJson(TranscationEntity data) =>
    json.encode(data.toJson());

class TranscationEntity {
  TranscationEntity({
    required this.summary,
    required this.transcationNumber,
    required this.transcationId,
    required this.hasIncome,
  });

  Summary summary;
  String transcationNumber;
  String transcationId;
  bool hasIncome;

  factory TranscationEntity.fromJson(Map<dynamic, dynamic> json) =>
      TranscationEntity(
        summary: Summary.fromJson(json['summary']),
        transcationNumber: json['transcation_number'],
        transcationId: json['transcation_id'],
        hasIncome: json['has_income'],
      );

  Map<dynamic, dynamic> toJson() => {
        'summary': summary.toJson(),
        'transcation_number': transcationNumber,
        'transcation_id': transcationId,
        'has_income': hasIncome,
      };
}

class Summary {
  Summary({
    required this.receive,
    required this.transfer,
  });

  Receive receive;
  Transfer transfer;

  factory Summary.fromJson(Map<dynamic, dynamic> json) => Summary(
        receive: Receive.fromJson(json['receive']),
        transfer: Transfer.fromJson(json['transfer']),
      );

  Map<dynamic, dynamic> toJson() => {
        'receive': receive.toJson(),
        'transfer': transfer.toJson(),
      };
}

class Receive {
  Receive({
    required this.paymentTransferDateTime,
    required this.hasCredit,
    required this.orderInformation,
    required this.senderAccountNumber,
    required this.transferToAccountNumber,
    required this.senderName,
    required this.senderMobileNumber,
    required this.transcationAmount,
    required this.paymentRequestDateTime,
  });

  int paymentTransferDateTime;
  bool hasCredit;
  OrderInformation orderInformation;
  String senderAccountNumber;
  String transferToAccountNumber;
  String senderName;
  String senderMobileNumber;
  int transcationAmount;
  int paymentRequestDateTime;

  factory Receive.fromJson(Map<dynamic, dynamic> json) => Receive(
        paymentTransferDateTime: json['payment_transfer_date_time'],
        hasCredit: json['hasCredit'],
        orderInformation: OrderInformation.fromJson(json['order_information']),
        senderAccountNumber: json['sender_account_number'],
        transferToAccountNumber: json['transfer_to_account_number'],
        senderName: json['sender_name'],
        senderMobileNumber: json['sender_mobile_number'],
        transcationAmount: json['transcation_amount'],
        paymentRequestDateTime: json['payment_request_date_time'],
      );

  Map<dynamic, dynamic> toJson() => {
        'payment_transfer_date_time': paymentTransferDateTime,
        'hasCredit': hasCredit,
        'order_information': orderInformation.toJson(),
        'sender_account_number': senderAccountNumber,
        'transfer_to_account_number': transferToAccountNumber,
        'sender_name': senderName,
        'sender_mobile_number': senderMobileNumber,
        'transcation_amount': transcationAmount,
        'payment_request_date_time': paymentRequestDateTime,
      };
}

class OrderInformation {
  OrderInformation({
    required this.orderId,
    required this.menuId,
    required this.menuName,
    required this.storeName,
    required this.storeId,
  });

  int orderId;
  int menuId;
  String menuName;
  String storeName;
  int storeId;

  factory OrderInformation.fromJson(Map<dynamic, dynamic> json) =>
      OrderInformation(
        orderId: json['orderID'] ?? -1,
        menuId: json['menuID'] ?? '',
        menuName: json['menuName'] ?? '',
        storeName: json['storeName'] ?? '',
        storeId: json['storeID'] ?? -1,
      );

  Map<dynamic, dynamic> toJson() => {
        'orderID': orderId,
        'menuID': menuId,
        'menuName': menuName,
        'storeName': storeName,
        'storeID': storeId,
      };
}

class Transfer {
  Transfer({
    required this.paymentTransferDateTime,
    required this.receiverAccountNumber,
    required this.hasDebit,
    required this.receiverMobileNumber,
    required this.receiverName,
    required this.transcationAmount,
    required this.paymentRequestDateTime,
    required this.transferFromAccountNumber,
  });

  int paymentTransferDateTime;
  String receiverAccountNumber;
  bool hasDebit;
  String receiverMobileNumber;
  String receiverName;
  int transcationAmount;
  int paymentRequestDateTime;
  String transferFromAccountNumber;

  factory Transfer.fromJson(Map<dynamic, dynamic> json) => Transfer(
        paymentTransferDateTime: json['payment_transfer_date_time'],
        receiverAccountNumber: json['receiver_account_number'],
        hasDebit: json['hasDebit'],
        receiverMobileNumber: json['receiver_mobile_number'],
        receiverName: json['receiver_name'],
        transcationAmount: json['transcation_amount'],
        paymentRequestDateTime: json['payment_request_date_time'],
        transferFromAccountNumber: json['transfer_from_account_number'],
      );

  Map<dynamic, dynamic> toJson() => {
        'payment_transfer_date_time': paymentTransferDateTime,
        'receiver_account_number': receiverAccountNumber,
        'hasDebit': hasDebit,
        'receiver_mobile_number': receiverMobileNumber,
        'receiver_name': receiverName,
        'transcation_amount': transcationAmount,
        'payment_request_date_time': paymentRequestDateTime,
        'transfer_from_account_number': transferFromAccountNumber,
      };
}
