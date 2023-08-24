part of 'package:homemakers_merchant/app/features/order/index.dart';

class AllScheduleOrderPage extends StatefulWidget {
  const AllScheduleOrderPage({super.key});
  @override
  _AllScheduleOrderPageController createState() => _AllScheduleOrderPageController();
}

class _AllScheduleOrderPageController extends State<AllScheduleOrderPage> {
  @override
  Widget build(BuildContext context) => _AllScheduleOrderPageView(this);
}

class _AllScheduleOrderPageView extends WidgetView<AllScheduleOrderPage, _AllScheduleOrderPageController> {
  const _AllScheduleOrderPageView(super.state);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
