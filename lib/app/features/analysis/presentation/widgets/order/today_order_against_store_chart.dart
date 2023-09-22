part of 'package:homemakers_merchant/app/features/analysis/index.dart';

class TodayOrderAgainstStoreChartWidget extends StatefulWidget {
  const TodayOrderAgainstStoreChartWidget({super.key,this.listOfStoreName=const[],this.storeOrderAnalysisData=const[],this.chartData=const[]});
  final List<ChartTodayEntity> chartData;
  final List<StoreAnalysisEntity> storeOrderAnalysisData;
  final List<String> listOfStoreName;

  @override
  _TodayOrderAgainstStoreChartWidgetController createState() => _TodayOrderAgainstStoreChartWidgetController();
}

class _TodayOrderAgainstStoreChartWidgetController extends State<TodayOrderAgainstStoreChartWidget> {
  List<ChartTodayEntity> chartData=[];
  List<StoreAnalysisEntity> storeOrderAnalysisData=[];
  List<String> listOfStoreName=[];

  TooltipBehavior? _tooltipBehavior;
  TooltipBehavior? _orderStatusTooltipBehavior;
  
  @override
  void initState() {
    chartData=[];
    storeOrderAnalysisData=[];
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
      const TodayOrderAnalysisEvent(),
    );
    super.initState();
  }


  /// Returns the cartesian stacked bar 100 chart.
  SfCartesianChart _buildStackedBar100Chart() {
    return SfCartesianChart(
      key: const Key('order-stores-analysis'),
      enableAxisAnimation: true,
      plotAreaBorderWidth: 1,
      margin:  EdgeInsets.all(5),
      title: ChartTitle(text: 'Order comparison of Time Period'),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
          labelIntersectAction: AxisLabelIntersectAction.multipleRows,
        maximumLabelWidth: 80,
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
        dataLabelSettings: DataLabelSettings(isVisible: true, showCumulativeValues: false,),
      ),
      StackedBarSeries<ChartTodayEntity, String>(
        dataSource: chartData,
        xValueMapper: (ChartTodayEntity sales, _) => sales.x,
        yValueMapper: (ChartTodayEntity sales, _) => sales.yesterday,
        groupName: 'Yesterday',
        name: 'Yesterday',
        //isVisible:true,
        dataLabelSettings: DataLabelSettings(isVisible: true, showCumulativeValues: false),
      ),
    ];
  }

  SfCartesianChart _buildStackedColumnChart() {
    return SfCartesianChart(
      key: const Key('order-status-stores-analysis'),
      enableAxisAnimation: true,
      plotAreaBorderWidth: 1,
      margin:  EdgeInsets.all(5),
      title: ChartTitle(text: 'Order comparison of Order Status'),
      legend: Legend(isVisible: true, position: LegendPosition.bottom,padding: 5),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
        labelIntersectAction: AxisLabelIntersectAction.multipleRows,
        maximumLabelWidth: 80,
      ),
      primaryYAxis: NumericAxis(
        rangePadding: ChartRangePadding.auto,
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(size: 0),
      ),
      series: _getStackedColumnSeries(),
      tooltipBehavior: _orderStatusTooltipBehavior,
    );
  }

  List<ChartSeries<StoreAnalysisEntity, String>> _getStackedColumnSeries() {
    List<ChartSeries<StoreAnalysisEntity, String>> listOfSeries=[
      StackedBarSeries<StoreAnalysisEntity, String>(
      dataSource: storeOrderAnalysisData,
      xValueMapper: (StoreAnalysisEntity sales, _) => sales.storeName,
      yValueMapper: (StoreAnalysisEntity sales, _) => (sales.todayOrderStatus.instant+sales.todayOrderStatus.schedule),
      //groupName: 'New',
      name: 'New',
      //isVisible:true,
      //groupName: value.storeName,
      //name: listOfStoreName[key],
      dataLabelSettings: DataLabelSettings(isVisible: true, showCumulativeValues: false,),
    ),
      StackedBarSeries<StoreAnalysisEntity, String>(
        dataSource: storeOrderAnalysisData,
        xValueMapper: (StoreAnalysisEntity sales, _) => sales.storeName,
        yValueMapper: (StoreAnalysisEntity sales, _) => sales.todayOrderStatus.pending,
        //groupName: 'OnGoing',
        name: 'OnGoing',
        //groupName: value.storeName,
        //name: listOfStoreName[key],
        //isVisible:true,
        dataLabelSettings: DataLabelSettings(isVisible: true, showCumulativeValues: false,),
      ),

      StackedBarSeries<StoreAnalysisEntity, String>(
        dataSource: storeOrderAnalysisData,
        xValueMapper: (StoreAnalysisEntity sales, _) => sales.storeName,
        yValueMapper: (StoreAnalysisEntity sales, _) => sales.todayOrderStatus.deliver,
        //groupName: 'Delivered',
        name: 'Delivered',
        //groupName: value.storeName,
        //name: listOfStoreName[key],
        //isVisible:true,
        dataLabelSettings: DataLabelSettings(isVisible: true, showCumulativeValues: false,),
      ),
      StackedBarSeries<StoreAnalysisEntity, String>(
        dataSource: storeOrderAnalysisData,
        xValueMapper: (StoreAnalysisEntity sales, _) => sales.storeName,
        yValueMapper: (StoreAnalysisEntity sales, _) => sales.todayOrderStatus.cancel,
        //groupName: 'Cancel',
        name: 'Cancel',
        //groupName: value.storeName,
        //name: listOfStoreName[key],
        //isVisible:true,
        dataLabelSettings: DataLabelSettings(isVisible: true, showCumulativeValues: false,),
      ),
      StackedBarSeries<StoreAnalysisEntity, String>(
        dataSource: storeOrderAnalysisData,
        xValueMapper: (StoreAnalysisEntity sales, _) => sales.storeName,
        yValueMapper: (StoreAnalysisEntity sales, _) => sales.todayOrderStatus.delay,
        //groupName: 'Delay',
        name: 'Delay',
        //groupName: value.storeName,
        //name: listOfStoreName[key],
        //isVisible:true,
        dataLabelSettings: DataLabelSettings(isVisible: true, showCumulativeValues: false,),
      ),
    ];
    return listOfSeries.toList();
  }

  @override
  void dispose() {
    listOfStoreName.clear();
    storeOrderAnalysisData.clear();
    chartData.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<OrderAnalysisBloc, OrderAnalysisState>(
    bloc: context.read<OrderAnalysisBloc>(),
  builder: (context, orderAnalysisState) {
    switch(orderAnalysisState){
      case TodayOrderByStoreAnalysisState():{
        chartData=List<ChartTodayEntity>.from(orderAnalysisState.chartData.toList());
        storeOrderAnalysisData=List<StoreAnalysisEntity>.from(orderAnalysisState.storeOrderAnalysisData.toList());
        listOfStoreName=List<String>.from(orderAnalysisState.listOfStoreName.toList());
      }
    }
    return _TodayOrderAgainstStoreChartWidgetView(this);
  },
);
}

class _TodayOrderAgainstStoreChartWidgetView
    extends WidgetView<TodayOrderAgainstStoreChartWidget, _TodayOrderAgainstStoreChartWidgetController> {
  const _TodayOrderAgainstStoreChartWidgetView(super.state);

  @override
  Widget build(BuildContext context) {
    //return getSampleWidget()['stacked_bar_100_chart']!(Key('bar-chart')) as Widget;
    return SizedBox(
      child: Column(
        children: [
          state._buildStackedBar100Chart(),
          state._buildStackedColumnChart(),
        ],
      ),
    );
  }
}
