part of 'package:homemakers_merchant/app/features/analysis/index.dart';
class TodaySalesAgainstStoreChartWidget extends StatefulWidget {
  const TodaySalesAgainstStoreChartWidget({super.key});
  @override
  _TodaySalesAgainstStoreChartWidgetController createState() => _TodaySalesAgainstStoreChartWidgetController();
}
class _TodaySalesAgainstStoreChartWidgetController extends State<TodaySalesAgainstStoreChartWidget> {
  List<ChartTodayEntity> chartData=[];
  TooltipBehavior? _salesOrderTooltipBehavior;

  List<StoreSalesAnalysisEntity> storeSalesAnalysisData=[];
  List<String> listOfStoreName=[];
  TooltipBehavior? _salesStatusTooltipBehavior;

  @override
  void initState() {
    chartData=[];
    storeSalesAnalysisData=[];
    listOfStoreName=[];
    _salesOrderTooltipBehavior = TooltipBehavior(
      enable: true,
      header: '',
      canShowMarker: false,
    );
    _salesStatusTooltipBehavior= TooltipBehavior(
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
      key: const Key('sales-status-stores-analysis'),
      plotAreaBorderWidth: 1,
      title: ChartTitle(text: 'Sales comparison of Period'),
      legend: const Legend(isVisible: true, position: LegendPosition.bottom),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        rangePadding: ChartRangePadding.auto,
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(size: 0),
      ),
      series: _getStackedBarSeries(),
      tooltipBehavior: _salesOrderTooltipBehavior,
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
        dataLabelSettings: const DataLabelSettings(isVisible: true, showCumulativeValues: true),
      ),
      StackedBarSeries<ChartTodayEntity, String>(
        dataSource: chartData,
        xValueMapper: (ChartTodayEntity sales, _) => sales.x,
        yValueMapper: (ChartTodayEntity sales, _) => sales.yesterday,
        groupName: 'Yesterday',
        name: 'Yesterday',
        //isVisible:true,
        dataLabelSettings: const DataLabelSettings(isVisible: true, showCumulativeValues: true),
      ),
    ];
  }

  SfCartesianChart _buildStackedColumnChart() {
    return SfCartesianChart(
      key: const Key('sales-status-status-analysis'),
      enableAxisAnimation: true,
      plotAreaBorderWidth: 1,
      margin:  const EdgeInsets.all(5),
      title: ChartTitle(text: 'Sales comparison of Status'),
      legend: const Legend(isVisible: true, position: LegendPosition.bottom,padding: 5,itemPadding: 8),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
        labelIntersectAction: AxisLabelIntersectAction.multipleRows,
        maximumLabelWidth: 80,
          //labelRotation: 90
      ),
      primaryYAxis: NumericAxis(
        rangePadding: ChartRangePadding.auto,
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(size: 0),
      ),
      series: _getStackedColumnSeries(),
      tooltipBehavior: _salesStatusTooltipBehavior,
    );
  }

  List<ChartSeries<StoreSalesAnalysisEntity, String>> _getStackedColumnSeries() {
    List<ChartSeries<StoreSalesAnalysisEntity, String>> listOfSeries=[
      StackedColumnSeries<StoreSalesAnalysisEntity, String>(
        dataSource: storeSalesAnalysisData,
        xValueMapper: (StoreSalesAnalysisEntity sales, _) => sales.storeName,
        yValueMapper: (StoreSalesAnalysisEntity sales, _) => sales.todaySalesStatus.netEarning,
        groupName: 'Total',
        name: 'Total',
        dataLabelSettings: const DataLabelSettings(isVisible: true, showCumulativeValues: false,),
      ),
      StackedColumnSeries<StoreSalesAnalysisEntity, String>(
        dataSource: storeSalesAnalysisData,
        xValueMapper: (StoreSalesAnalysisEntity sales, _) => sales.storeName,
        yValueMapper: (StoreSalesAnalysisEntity sales, _) => sales.todaySalesStatus.deliverOrderAmount,
        groupName: 'Delivered',
        name: 'Delivered',
        dataLabelSettings: const DataLabelSettings(isVisible: true, showCumulativeValues: false,),
      ),

      StackedColumnSeries<StoreSalesAnalysisEntity, String>(
        dataSource: storeSalesAnalysisData,
        xValueMapper: (StoreSalesAnalysisEntity sales, _) => sales.storeName,
        yValueMapper: (StoreSalesAnalysisEntity sales, _) => sales.todaySalesStatus.penaltyAmountBySystem,
        groupName: 'Penalty',
        name: 'Penalty',
        dataLabelSettings: const DataLabelSettings(isVisible: true, showCumulativeValues: false,),
      ),
      StackedColumnSeries<StoreSalesAnalysisEntity, String>(
        dataSource: storeSalesAnalysisData,
        xValueMapper: (StoreSalesAnalysisEntity sales, _) => sales.storeName,
        yValueMapper: (StoreSalesAnalysisEntity sales, _) => sales.todaySalesStatus.cancelOrderAmount,
        groupName: 'Cancel',
        name: 'Cancel',
        dataLabelSettings: const DataLabelSettings(isVisible: true, showCumulativeValues: false,),
      ),
      StackedColumnSeries<StoreSalesAnalysisEntity, String>(
        dataSource: storeSalesAnalysisData,
        xValueMapper: (StoreSalesAnalysisEntity sales, _) => sales.storeName,
        yValueMapper: (StoreSalesAnalysisEntity sales, _) => sales.todaySalesStatus.refundAmount,
        groupName: 'Refund',
        name: 'Refund',
        dataLabelSettings: const DataLabelSettings(isVisible: true, showCumulativeValues: false,),
      ),
    ];
    return listOfSeries.toList();
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
          state._buildStackedColumnChart(),
        ],
      ));
  }
}