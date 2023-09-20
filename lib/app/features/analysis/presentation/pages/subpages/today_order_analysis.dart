part of 'package:homemakers_merchant/app/features/analysis/index.dart';

class TodayOrderAnalysis extends StatefulWidget {
  const TodayOrderAnalysis({super.key});

  @override
  _TodayOrderAnalysisController createState() => _TodayOrderAnalysisController();
}

class _TodayOrderAnalysisController extends State<TodayOrderAnalysis> {
  bool _isSelected = false;
  List<Widget> listOfWidgets = [
    TodayOrderAgainstStoreChartWidget(key: const Key('today-order-against-store-widget')),
    TodaySalesAgainstStoreChartWidget(
      key: const Key('today-sales-against-store-widget'),
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onChangedSwitch(bool isSelected) {
    _isSelected = isSelected;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => _TodayOrderAnalysisView(this);
}

class _TodayOrderAnalysisView extends WidgetView<TodayOrderAnalysis, _TodayOrderAnalysisController> {
  const _TodayOrderAnalysisView(super.state);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      children: [
        Flexible(
          child: OrderAnalysisGridWidget(
            key: const Key('today-order-widget'),
          ),
        ),
        const AnimatedGap(6, duration: Duration(milliseconds: 500)),
        SwitchOrderAndSalesWidget(
          key: const Key('today-switch-order-sales-widget'),
          onChanged: state.onChangedSwitch,
          leftLabel: 'Orders',
          rightLabel: 'Sales',
          value: state._isSelected,
        ),
        const AnimatedGap(2, duration: Duration(milliseconds: 500)),
        Flexible(
          flex: 3,
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: state._isSelected?state.listOfWidgets[1]:state.listOfWidgets[0],
          ),
        ),
        const AnimatedGap(12, duration: Duration(milliseconds: 500)),
      ],
    );
  }
}
