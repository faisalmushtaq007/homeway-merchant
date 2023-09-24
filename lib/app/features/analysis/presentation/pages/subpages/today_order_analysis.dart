part of 'package:homemakers_merchant/app/features/analysis/index.dart';

class TodayOrderAnalysis extends StatefulWidget {
  const TodayOrderAnalysis({super.key});

  @override
  _TodayOrderAnalysisController createState() =>
      _TodayOrderAnalysisController();
}

class _TodayOrderAnalysisController extends State<TodayOrderAnalysis> {
  bool _isSelected = false;
  List<Widget> listOfWidgets = [];
  OverAllAnalysisData overAllAnalysisData = OverAllAnalysisData(
    totalEarnings: 0,
    totalCustomers: 0,
    totalOrders: TotalOrders(totalOrdersNew: 0, deliver: 0),
    totalStores: 0,
  );

  @override
  void initState() {
    listOfWidgets = [];
    listOfWidgets = [
      TodayOrderAgainstStoreChartWidget(
        key: const Key('today-order-against-store-widget'),
      ),
      TodaySalesAgainstStoreChartWidget(
        key: const Key('today-sales-against-store-widget'),
      ),
    ];
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
          const TodayOrderAnalysisEvent(analysisBy: AnalysisBy.todaySales));
    } else {
      context.read<OrderAnalysisBloc>().add(const TodayOrderAnalysisEvent());
    }
    setState(() {});
  }

  void updateOverAllData(OverAllAnalysisData overAllData) {
    overAllAnalysisData = overAllData;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<OrderAnalysisBloc, OrderAnalysisState>(
        builder: (context, state) {
          if (state is TodayOverAllOrderAnalysisState &&
              state.overAllAnalysisData.isNotNull) {
            overAllAnalysisData = state.overAllAnalysisData!;
          }
          return _TodayOrderAnalysisView(this);
        },
      );
}

class _TodayOrderAnalysisView
    extends WidgetView<TodayOrderAnalysis, _TodayOrderAnalysisController> {
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
            overAllAnalysisData: state.overAllAnalysisData,
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
