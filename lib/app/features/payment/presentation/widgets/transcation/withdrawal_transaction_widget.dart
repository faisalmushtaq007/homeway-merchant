part of 'package:homemakers_merchant/app/features/payment/index.dart';

class WithdrawalTransactionWidget extends StatefulWidget {
  const WithdrawalTransactionWidget({super.key});
  @override
  _WithdrawalTransactionWidgetController createState() =>
      _WithdrawalTransactionWidgetController();
}

class _WithdrawalTransactionWidgetController
    extends State<WithdrawalTransactionWidget> {
  @override
  Widget build(BuildContext context) => _WithdrawalTransactionWidgetView(this);
}

class _WithdrawalTransactionWidgetView extends WidgetView<
    WithdrawalTransactionWidget, _WithdrawalTransactionWidgetController> {
  const _WithdrawalTransactionWidgetView(super.state);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
