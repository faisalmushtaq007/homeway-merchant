part of 'package:homemakers_merchant/app/features/payment/index.dart';

class WithdrawalSaveInfoWidget extends StatefulWidget {
  const WithdrawalSaveInfoWidget({super.key});
  @override
  _WithdrawalSaveInfoWidgetController createState() =>
      _WithdrawalSaveInfoWidgetController();
}

class _WithdrawalSaveInfoWidgetController
    extends State<WithdrawalSaveInfoWidget> {
  @override
  Widget build(BuildContext context) => _WithdrawalSaveInfoWidgetView(this);
}

class _WithdrawalSaveInfoWidgetView extends WidgetView<WithdrawalSaveInfoWidget,
    _WithdrawalSaveInfoWidgetController> {
  const _WithdrawalSaveInfoWidgetView(super.state);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
