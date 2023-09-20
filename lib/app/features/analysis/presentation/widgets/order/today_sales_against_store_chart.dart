part of 'package:homemakers_merchant/app/features/analysis/index.dart';
class TodaySalesAgainstStoreChartWidget extends StatefulWidget {
  const TodaySalesAgainstStoreChartWidget({super.key});
  @override
  _TodaySalesAgainstStoreChartWidgetController createState() => _TodaySalesAgainstStoreChartWidgetController();
}
class _TodaySalesAgainstStoreChartWidgetController extends State<TodaySalesAgainstStoreChartWidget> {
  List<ChartTodayEntity>? chartData;

  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      header: '',
      canShowMarker: false,
    );
    chartData = <ChartTodayEntity>[
      ChartTodayEntity('Store A', 60, 44),
      ChartTodayEntity('Store B', 30, 23),
      ChartTodayEntity('Store C', 12, 32),
      ChartTodayEntity('Store D', 6, 12),
      ChartTodayEntity('Store E', 4, 30),
      ChartTodayEntity('Store F', 48, 60),
    ];
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
        dataSource: chartData!,
        xValueMapper: (ChartTodayEntity sales, _) => sales.x,
        yValueMapper: (ChartTodayEntity sales, _) => sales.today,
        groupName: 'Today',
        name: 'Today',
        //isVisible:true,
        dataLabelSettings: DataLabelSettings(isVisible: true, showCumulativeValues: true),
      ),
      StackedBarSeries<ChartTodayEntity, String>(
        dataSource: chartData!,
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
    chartData!.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) => _TodaySalesAgainstStoreChartWidgetView(this);
}
class _TodaySalesAgainstStoreChartWidgetView extends WidgetView<TodaySalesAgainstStoreChartWidget, _TodaySalesAgainstStoreChartWidgetController> {
  const _TodaySalesAgainstStoreChartWidgetView(super.state);
@override
  Widget build(BuildContext context) {
  return Container(
      child: Column(
        children: [
          state._buildStackedBar100Chart(),
        ],
      ));
  }
}