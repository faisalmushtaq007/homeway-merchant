part of 'package:homemakers_merchant/app/features/payment/index.dart';

class IncomeTransactionWidget extends StatefulWidget {
  const IncomeTransactionWidget({super.key});
  @override
  _IncomeTransactionWidgetController createState() => _IncomeTransactionWidgetController();
}

class _IncomeTransactionWidgetController extends State<IncomeTransactionWidget> {
  @override
  Widget build(BuildContext context) => _IncomeTransactionWidgetView(this);
}

class _IncomeTransactionWidgetView extends WidgetView<IncomeTransactionWidget, _IncomeTransactionWidgetController> {
  const _IncomeTransactionWidgetView(super.state);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
