part of 'package:homemakers_merchant/app/features/order/index.dart';

class AllNewOrderPage extends StatefulWidget {
  const AllNewOrderPage({super.key});
  @override
  _AllNewOrderPageController createState() => _AllNewOrderPageController();
}

class _AllNewOrderPageController extends State<AllNewOrderPage> {
  @override
  Widget build(BuildContext context) => _AllNewOrderPageView(this);
}

class _AllNewOrderPageView extends WidgetView<AllNewOrderPage, _AllNewOrderPageController> {
  const _AllNewOrderPageView(super.state);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
