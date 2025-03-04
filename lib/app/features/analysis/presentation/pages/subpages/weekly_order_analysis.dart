part of 'package:homemakers_merchant/app/features/analysis/index.dart';

class WeeklyOrderAnalysis extends StatefulWidget {
  const WeeklyOrderAnalysis({super.key});

  @override
  _WeeklyOrderAnalysisController createState() =>
      _WeeklyOrderAnalysisController();
}

class _WeeklyOrderAnalysisController extends State<WeeklyOrderAnalysis> {
  bool _isSelected = false;
  List<Widget> listOfWidgets = [
    WeeklyOrderAgainstStoreChartWidget(
        key: const Key('weekly-order-against-store-widget')),
    WeeklySalesAgainstStoreChartWidget(
      key: const Key('weekly-sales-against-store-widget'),
    ),
  ];
  WeeklyAnalysisOverAllData overAllAnalysisData = WeeklyAnalysisOverAllData();

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
    if (isSelected) {
      context.read<OrderAnalysisBloc>().add(
          const WeeklyOrderAnalysisEvent(analysisBy: AnalysisBy.weeklySales));
    } else {
      context.read<OrderAnalysisBloc>().add(const WeeklyOrderAnalysisEvent());
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<OrderAnalysisBloc, OrderAnalysisState>(
        builder: (context, orderAnalysisState) {
          if (orderAnalysisState is WeeklyOverAllOrderAnalysisState) {
            overAllAnalysisData = orderAnalysisState.overAllAnalysisData;
          }
          return _WeeklyOrderAnalysisView(this);
        },
      );
}

class _WeeklyOrderAnalysisView
    extends WidgetView<WeeklyOrderAnalysis, _WeeklyOrderAnalysisController> {
  const _WeeklyOrderAnalysisView(super.state);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      children: [
        Flexible(
          child: WeeklyOverAllAnalysisGridWidget(
            key: const Key('weekly-order-widget'),
            overAllAnalysisData: state.overAllAnalysisData,
          ),
        ),
        const AnimatedGap(6, duration: Duration(milliseconds: 500)),
        SwitchOrderAndSalesWidget(
          key: const Key('weekly-switch-order-sales-widget'),
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
