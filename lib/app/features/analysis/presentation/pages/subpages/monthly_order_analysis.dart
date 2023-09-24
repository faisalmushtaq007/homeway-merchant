part of 'package:homemakers_merchant/app/features/analysis/index.dart';

class MonthlyOrderAnalysis extends StatefulWidget {
  const MonthlyOrderAnalysis({super.key});

  @override
  _MonthlyOrderAnalysisController createState() =>
      _MonthlyOrderAnalysisController();
}

class _MonthlyOrderAnalysisController extends State<MonthlyOrderAnalysis> {
  bool _isSelected = false;
  List<Widget> listOfWidgets = [
    MonthlyOrderAgainstStoreChartWidget(
        key: const Key('monthly-order-against-store-widget')),
    MonthlySalesAgainstStoreChartWidget(
      key: const Key('monthly-sales-against-store-widget'),
    ),
  ];
  OverAllAnalysisData overAllAnalysisData = OverAllAnalysisData(
    totalEarnings: 0,
    totalCustomers: 0,
    totalOrders: TotalOrders(totalOrdersNew: 0, deliver: 0),
    totalStores: 0,
  );

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
  Widget build(BuildContext context) => _MonthlyOrderAnalysisView(this);
}

class _MonthlyOrderAnalysisView
    extends WidgetView<MonthlyOrderAnalysis, _MonthlyOrderAnalysisController> {
  const _MonthlyOrderAnalysisView(super.state);

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
            key: const Key('monthly-order-widget'),
            overAllAnalysisData: state.overAllAnalysisData,
          ),
        ),
        const AnimatedGap(6, duration: Duration(milliseconds: 500)),
        SwitchOrderAndSalesWidget(
          key: const Key('monthly-switch-order-sales-widget'),
          onChanged: state.onChangedSwitch,
          leftLabel: 'Orders',
          rightLabel: 'Sales',
          value: state._isSelected,
        ),
        const AnimatedGap(2, duration: Duration(milliseconds: 500)),
        Flexible(
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: state._isSelected
                ? state.listOfWidgets[1]
                : state.listOfWidgets[0],
          ),
        ),
        const AnimatedGap(12, duration: Duration(milliseconds: 500)),
      ],
    );
  }
}
