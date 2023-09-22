part of 'package:homemakers_merchant/app/features/analysis/index.dart';
class WeeklyOrderAgainstStoreChartWidget extends StatefulWidget {
  const WeeklyOrderAgainstStoreChartWidget({super.key});
  @override
  _WeeklyOrderAgainstStoreChartWidgetController createState() => _WeeklyOrderAgainstStoreChartWidgetController();
}
class _WeeklyOrderAgainstStoreChartWidgetController extends State<WeeklyOrderAgainstStoreChartWidget> {
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
      ChartTodayEntity('Store A', 6, 6),
      ChartTodayEntity('Store B', 8, 8),
      ChartTodayEntity('Store C', 12, 8),
      ChartTodayEntity('Store D', 15, 21),
      ChartTodayEntity('Store E', 20, 30),
      ChartTodayEntity('Store F', 44, 55),
    ];
    super.initState();
  }

  /// Returns the cartesian stacked bar 100 chart.
  SfCartesianChart _buildChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 1,
      title: ChartTitle(text: 'Order comparison of stores'),
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
  Widget build(BuildContext context) => _WeeklyOrderAgainstStoreChartWidgetView(this);
}
class _WeeklyOrderAgainstStoreChartWidgetView extends WidgetView<WeeklyOrderAgainstStoreChartWidget, _WeeklyOrderAgainstStoreChartWidgetController> {
  const _WeeklyOrderAgainstStoreChartWidgetView(super.state);
@override
  Widget build(BuildContext context) {
    return SizedBox(
    child: Column(
      children: [
        state._buildChart(),
      ],
    ),
  );
  }
}