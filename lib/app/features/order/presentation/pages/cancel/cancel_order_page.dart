part of 'package:homemakers_merchant/app/features/order/index.dart';

class AllCancelOrderPage extends StatefulWidget {
  const AllCancelOrderPage({super.key});
  @override
  _AllCancelOrderPageController createState() =>
      _AllCancelOrderPageController();
}

class _AllCancelOrderPageController extends State<AllCancelOrderPage> {
  @override
  Widget build(BuildContext context) => _AllCancelOrderPageView(this);
}

class _AllCancelOrderPageView
    extends WidgetView<AllCancelOrderPage, _AllCancelOrderPageController> {
  const _AllCancelOrderPageView(super.state);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
