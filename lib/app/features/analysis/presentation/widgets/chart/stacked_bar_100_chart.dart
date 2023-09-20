/// Package import
import 'package:flutter/material.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

/// Local imports
import 'package:homemakers_merchant/app/features/analysis/presentation/pages/model/sample_view.dart';

/// Renders the stacked bar 100 chart sample.
class StackedBar100Chart extends SampleView {
  /// Creates the stacked bar 100 chart sample.
  const StackedBar100Chart(Key key) : super(key: key);

  @override
  _StackedBar100ChartState createState() => _StackedBar100ChartState();
}

/// State class of the stacked bar 100 chart.
class _StackedBar100ChartState extends SampleViewState {
  _StackedBar100ChartState();

  List<_ChartData>? chartData;

  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      header: '',
      canShowMarker: false,
    );
    chartData = <_ChartData>[
      _ChartData('Store A', 6, 6),
      _ChartData('Store B', 8, 8),
      _ChartData('Store C', 12, 11),
      _ChartData('Store D', 15.5, 16),
      _ChartData('Store E', 20, 21),
      _ChartData('Store F', 44, 55),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildStackedBar100Chart();
  }

  /// Returns the cartesian stacked bar 100 chart.
  SfCartesianChart _buildStackedBar100Chart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 1,
      title: ChartTitle(text: isCardView ? '' : 'Order comparison of stores'),
      legend: Legend(isVisible: !isCardView),
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
  List<ChartSeries<_ChartData, String>> _getStackedBarSeries() {
    return <ChartSeries<_ChartData, String>>[
      StackedColumnSeries<_ChartData, String>(
        dataSource: chartData!,
        xValueMapper: (_ChartData sales, _) => sales.x,
        yValueMapper: (_ChartData sales, _) => sales.today,
        name: 'Today',
      ),
      StackedColumnSeries<_ChartData, String>(
        dataSource: chartData!,
        xValueMapper: (_ChartData sales, _) => sales.x,
        yValueMapper: (_ChartData sales, _) => sales.yesterday,
        name: 'Yesterday',
      ),
    ];
  }

  @override
  void dispose() {
    chartData!.clear();
    super.dispose();
  }
}

/// Private class for storing the stacked bar 100 series data points.
class _ChartData {
  _ChartData(
      this.x,
      this.today,
      this.yesterday,
      );

  final String x;
  final num today;
  final num yesterday;
}
