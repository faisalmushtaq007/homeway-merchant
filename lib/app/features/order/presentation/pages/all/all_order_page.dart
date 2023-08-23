part of 'package:homemakers_merchant/app/features/order/index.dart';

class AllOrderPages extends StatefulWidget {
  const AllOrderPages({super.key});
  @override
  _AllOrderPagesController createState() => _AllOrderPagesController();
}

class _AllOrderPagesController extends State<AllOrderPages> {
  @override
  Widget build(BuildContext context) => _AllOrderPagesView(this);
}

class _AllOrderPagesView extends WidgetView<AllOrderPages, _AllOrderPagesController> {
  const _AllOrderPagesView(super.state);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
