part of 'package:homemakers_merchant/app/features/analysis/index.dart';
class TodaySalesAgainstStoreChartWidget extends StatefulWidget {
  const TodaySalesAgainstStoreChartWidget({super.key});
  @override
  _TodaySalesAgainstStoreChartWidgetController createState() => _TodaySalesAgainstStoreChartWidgetController();
}
class _TodaySalesAgainstStoreChartWidgetController extends State<TodaySalesAgainstStoreChartWidget> {
  List<ChartTodayEntity> chartData=[];
  TooltipBehavior? _tooltipBehavior;

  List<StoreSalesAnalysisEntity> storeSalesAnalysisData=[];
  List<String> listOfStoreName=[];
  TooltipBehavior? _orderStatusTooltipBehavior;

  @override
  void initState() {
    chartData=[];
    storeSalesAnalysisData=[];
    listOfStoreName=[];
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      header: '',
      canShowMarker: false,
    );
    _orderStatusTooltipBehavior= TooltipBehavior(
      enable: true,
      header: '',
      canShowMarker: false,
    );
    context.read<OrderAnalysisBloc>().add(
      const TodayOrderAnalysisEvent(analysisBy: AnalysisBy.todaySales),
    );
    super.initState();
  }

  /// Returns the cartesian stacked bar 100 chart.
  SfCartesianChart _buildStackedBar100Chart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 1,
      title: ChartTitle(text: 'Sales comparison of stores'),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        rangePadding: ChartRangePadding.auto,
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(size: 0),
      ),
      series: _getStackedBarSeries(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  /// Returns the list of chart series
  /// which need to render on the stacked bar 100 chart.
  List<ChartSeries<ChartTodayEntity, String>> _getStackedBarSeries() {
    return <ChartSeries<ChartTodayEntity, String>>[
      StackedBarSeries<ChartTodayEntity, String>(
        dataSource: chartData,
        xValueMapper: (ChartTodayEntity sales, _) => sales.x,
        yValueMapper: (ChartTodayEntity sales, _) => sales.today,
        groupName: 'Today',
        name: 'Today',
        //isVisible:true,
        dataLabelSettings: DataLabelSettings(isVisible: true, showCumulativeValues: true),
      ),
      StackedBarSeries<ChartTodayEntity, String>(
        dataSource: chartData,
        xValueMapper: (ChartTodayEntity sales, _) => sales.x,
        yValueMapper: (ChartTodayEntity sales, _) => sales.yesterday,
        groupName: 'Yesterday',
        name: 'Yesterday',
        //isVisible:true,
        dataLabelSettings: DataLabelSettings(isVisible: true, showCumulativeValues: true),
      ),
    ];
  }

  @override
  void dispose() {
    listOfStoreName.clear();
    storeSalesAnalysisData.clear();
    chartData.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) => BlocBuilder<OrderAnalysisBloc, OrderAnalysisState>(
    bloc: context.read<OrderAnalysisBloc>(),
    builder: (context, orderAnalysisState) {
      switch(orderAnalysisState){
        case TodaySalesByStoreAnalysisState():{
          chartData=List<ChartTodayEntity>.from(orderAnalysisState.chartData.toList());
          storeSalesAnalysisData=List<StoreSalesAnalysisEntity>.from(orderAnalysisState.storeSalesAnalysisData.toList());
          listOfStoreName=List<String>.from(orderAnalysisState.listOfStoreName.toList());
        }
      }
    return _TodaySalesAgainstStoreChartWidgetView(this);
  },
);
}
class _TodaySalesAgainstStoreChartWidgetView extends WidgetView<TodaySalesAgainstStoreChartWidget, _TodaySalesAgainstStoreChartWidgetController> {
  const _TodaySalesAgainstStoreChartWidgetView(super.state);
@override
  Widget build(BuildContext context) {
  return SizedBox(
      child: Column(
        children: [
          state._buildStackedBar100Chart(),
        ],
      ));
  }
}