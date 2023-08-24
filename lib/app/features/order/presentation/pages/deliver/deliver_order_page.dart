part of 'package:homemakers_merchant/app/features/order/index.dart';

class AllDeliverOrderPage extends StatefulWidget {
  const AllDeliverOrderPage({super.key});
  @override
  _AllDeliverOrderPageController createState() => _AllDeliverOrderPageController();
}

class _AllDeliverOrderPageController extends State<AllDeliverOrderPage> {
  @override
  Widget build(BuildContext context) => _AllDeliverOrderPageView(this);
}

class _AllDeliverOrderPageView extends WidgetView<AllDeliverOrderPage, _AllDeliverOrderPageController> {
  const _AllDeliverOrderPageView(super.state);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
