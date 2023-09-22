part of 'package:homemakers_merchant/app/features/analysis/index.dart';
class WeeklySalesAgainstStoreChartWidget extends StatefulWidget {
  const WeeklySalesAgainstStoreChartWidget({super.key});
  @override
  _WeeklySalesAgainstStoreChartWidgetController createState() => _WeeklySalesAgainstStoreChartWidgetController();
}
class _WeeklySalesAgainstStoreChartWidgetController extends State<WeeklySalesAgainstStoreChartWidget> {
  List<ChartSampleData>? chartData;

  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      header: '',
      canShowMarker: false,
    );
    chartData = <ChartSampleData>[
      ChartSampleData(
          x: DateTime.monday,
          y: 50,
          yValue: 55,
          secondSeriesYValue: 72,
          thirdSeriesYValue: 65),
      ChartSampleData(
          x: DateTime.tuesday,
          y: 80,
          yValue: 75,
          secondSeriesYValue: 70,
          thirdSeriesYValue: 60),
      ChartSampleData(
          x: DateTime.wednesday,
          y: 35,
          yValue: 45,
          secondSeriesYValue: 55,
          thirdSeriesYValue: 52),
      ChartSampleData(
        x: DateTime.thursday,
        y: 65,
        yValue: 50,
        secondSeriesYValue: 70,
        thirdSeriesYValue: 65,),
      ChartSampleData(
        x: DateTime.friday,
        y: 65,
        yValue: 50,
        secondSeriesYValue: 70,
        thirdSeriesYValue: 65,),
      ChartSampleData(
        x: DateTime.saturday,
        y: 65,
        yValue: 50,
        secondSeriesYValue: 70,
        thirdSeriesYValue: 65,),
      ChartSampleData(
        x: DateTime.sunday,
        y: 65,
        yValue: 50,
        secondSeriesYValue: 70,
        thirdSeriesYValue: 65,),
    ];
    super.initState();
  }

  /// Returns the cartesian stacked bar 100 chart.
  SfCartesianChart _buildChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 1,
      title: ChartTitle(text: 'Sales comparison of stores'),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
        //intervalType: DateTimeIntervalType.days,
      ),
      primaryYAxis: NumericAxis(
        rangePadding: ChartRangePadding.auto,
        axisLine: const AxisLine(width: 0),
        //labelFormat: '{value}K',
        //maximum: 300,
        majorTickLines: const MajorTickLines(size: 0),
      ),
      series: _getStackedBarSeries(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  /// Returns the list of chart series
  /// which need to render on the stacked bar 100 chart.
  List<StackedColumnSeries<ChartSampleData, String>> _getStackedBarSeries() {
    return <StackedColumnSeries<ChartSampleData, String>>[
      StackedColumnSeries<ChartSampleData, String>(
        dataSource: chartData!,
        xValueMapper: (ChartSampleData sales, _) => getWeekdayName(sales.x) as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        /*groupName: 'Product A',*/name: 'Store A',dataLabelSettings: DataLabelSettings(isVisible: true, showCumulativeValues: true),),
      StackedColumnSeries<ChartSampleData, String>(
        dataSource: chartData!,
        xValueMapper: (ChartSampleData sales, _) => getWeekdayName(sales.x) ,
        yValueMapper: (ChartSampleData sales, _) => sales.yValue,
        /*groupName: 'Product B',*/name: 'Store B',dataLabelSettings: DataLabelSettings(isVisible: true, showCumulativeValues: true),),
      StackedColumnSeries<ChartSampleData, String>(
        dataSource: chartData!,
        xValueMapper: (ChartSampleData sales, _) => getWeekdayName(sales.x) as String,
        yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
        /*groupName: 'Product C',*/name: 'Store C',dataLabelSettings: DataLabelSettings(isVisible: true, showCumulativeValues: true),),
      StackedColumnSeries<ChartSampleData, String>(
        dataSource: chartData!,
        xValueMapper: (ChartSampleData sales, _) => getWeekdayName(sales.x) as String,
        yValueMapper: (ChartSampleData sales, _) => sales.thirdSeriesYValue,
        /*groupName: 'Product D',*/name: 'Store D',dataLabelSettings: DataLabelSettings(isVisible: true, showCumulativeValues: true),)
    ];
  }

  @override
  void dispose() {
    chartData!.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) => _WeeklySalesAgainstStoreChartWidgetView(this);
}
class _WeeklySalesAgainstStoreChartWidgetView extends WidgetView<WeeklySalesAgainstStoreChartWidget, _WeeklySalesAgainstStoreChartWidgetController> {
  const _WeeklySalesAgainstStoreChartWidgetView(super.state);
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