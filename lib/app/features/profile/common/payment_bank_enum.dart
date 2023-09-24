part of 'package:homemakers_merchant/app/features/profile/index.dart';

enum AcceptPaymentMode {
  cash(
    acceptPaymentModeID: 0,
    acceptPaymentModeName: 'Cash',
  ),
  card(
    acceptPaymentModeID: 1,
    acceptPaymentModeName: 'Card',
  ),
  netBankin(
    acceptPaymentModeID: 2,
    acceptPaymentModeName: 'Net Banking',
  ),
  wallet(
    acceptPaymentModeID: 3,
    acceptPaymentModeName: 'Wallet',
  ),
  other(
    acceptPaymentModeID: 4,
    acceptPaymentModeName: 'Other',
  ),
  none(
    acceptPaymentModeID: 5,
    acceptPaymentModeName: '-',
  ),
  ;

  const AcceptPaymentMode(
      {required this.acceptPaymentModeName, required this.acceptPaymentModeID});

  final int acceptPaymentModeID;
  final String acceptPaymentModeName;

  @override
  String toString() {
    return '$name:($acceptPaymentModeID)';
  }
}
