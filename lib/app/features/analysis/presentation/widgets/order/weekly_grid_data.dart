part of 'package:homemakers_merchant/app/features/analysis/index.dart';

class WeeklyOverAllAnalysisGridWidget extends StatelessWidget {
  WeeklyOverAllAnalysisGridWidget({
    super.key,
    this.overAllAnalysisData,
  });

  final WeeklyAnalysisOverAllData? overAllAnalysisData;
  final TooltipBehavior _customerTooltip = TooltipBehavior(enable: true, format: 'point.x : point.y%');

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: WeeklyOverAllAnalysisTileWidget(
            index: 0,
            title: 'Net Revenue',
            subTitle: '${overAllAnalysisData?.totalEarnings ?? 0} SAR',
            gradient: linearGradient(
              Alignment.bottomCenter,
              ['#5038EA', '#C391B3'],
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: WeeklyOverAllAnalysisTileWidget(
            index: 1,
            title: 'Stores',
            subTitle: '${overAllAnalysisData?.totalStores ?? 0}',
            gradient: linearGradient(
              Alignment.bottomCenter,
              ['#4077b0', '#f9c084'],
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: WeeklyOverAllAnalysisTileWidget(
            index: 1,
            title: 'Open',
            subTitle: '${overAllAnalysisData?.totalOpenStores ?? 0}',
            gradient: linearGradient(
              Alignment.bottomCenter,
              ['#4077b0', '#f9c084'],
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: WeeklyOverAllAnalysisTileWidget(
            index: 1,
            title: 'Close',
            subTitle: '${overAllAnalysisData?.totalClosedStores ?? 0}',
            gradient: linearGradient(
              Alignment.bottomCenter,
              ['#4077b0', '#f9c084'],
            ),
          ),
        ),

        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: Builder(
            builder: (context) {
              return SfCircularChart(
                title: ChartTitle(text: 'Customers'),
                margin: const EdgeInsets.all(5),
                legend: Legend(isVisible: true, position: LegendPosition.right,isResponsive: true,itemPadding: 8,padding: 5,),
                annotations: <CircularChartAnnotation>[
                  CircularChartAnnotation(
                    widget: Container(
                      child: Text(overAllAnalysisData?.totalCustomers.toString() ?? '0'),
                    ),
                  )
                ],
                series: <DoughnutSeries<ChartSampleData, String>>[
                  DoughnutSeries<ChartSampleData, String>(
                    radius: '100%',
                    //explode: true,
                    //explodeOffset: '10%',
                    dataSource: <ChartSampleData>[
                      ChartSampleData(
                        x: 'Old',
                        y: overAllAnalysisData?.totalOldCustomers ?? 0,
                        text: overAllAnalysisData?.totalOldCustomers.toString() ?? '0',
                        pointColor: Color.fromRGBO(255, 31, 0, 1),
                      ),
                      ChartSampleData(
                        x: 'New',
                        y: overAllAnalysisData?.totalNewCustomers ?? 0,
                        text: overAllAnalysisData?.totalNewCustomers.toString() ?? '0',
                        pointColor: Color.fromRGBO(255, 189, 57, 1),
                      ),
                    ],
                    xValueMapper: (ChartSampleData data, _) => data.x as String,
                    yValueMapper: (ChartSampleData data, _) => data.y,
                    dataLabelMapper: (ChartSampleData data, _) => data.text,
                    pointColorMapper: (ChartSampleData data, _) => data.pointColor,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  )
                ],
                tooltipBehavior: _customerTooltip,
              );
            },
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: Builder(
            builder: (context) {
              return SfCartesianChart(
                title: ChartTitle(text: 'Orders'),
                margin: const EdgeInsets.all(5),
                primaryXAxis: CategoryAxis(
                  majorGridLines: const MajorGridLines(width: 0),
                  labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                ),
                primaryYAxis: NumericAxis(
                    rangePadding: ChartRangePadding.auto,
                    axisLine: const AxisLine(width: 0),
                    labelFormat: '{value}',
                    majorTickLines: const MajorTickLines(size: 0)),
                legend: Legend(isVisible: false,isResponsive: true,itemPadding: 8,padding: 5,),
                annotations: <CartesianChartAnnotation>[
                  CartesianChartAnnotation(
                    widget: Container(
                      child: Text(overAllAnalysisData?.totalOrders.total.toString() ?? '0'),
                    ),
                  )
                ],
                series: <BarSeries<ChartSampleData, String>>[
                  BarSeries<ChartSampleData, String>(
                    //radius: '130%',
                    //explode: true,
                    //explodeOffset: '10%',
                    dataSource: <ChartSampleData>[
                      ChartSampleData(
                        x: 'Instant',
                        y: overAllAnalysisData?.totalOrders.instant ?? 0,
                        text: overAllAnalysisData?.totalOrders.instant.toString() ?? '0',
                        pointColor: Color.fromRGBO(63, 136, 197, 1),
                      ),
                      ChartSampleData(
                        x: 'Schedule',
                        y: overAllAnalysisData?.totalOrders.schedule ?? 0,
                        text: overAllAnalysisData?.totalOrders.schedule.toString() ?? '0',
                        pointColor: Color.fromRGBO(255, 186, 57, 1),
                      ),
                      ChartSampleData(
                        x: 'Deliver',
                        y: overAllAnalysisData?.totalOrders.deliver ?? 0,
                        text: overAllAnalysisData?.totalOrders.deliver.toString() ?? '0',
                        pointColor: Color.fromRGBO(19, 111, 99, 1),
                      ),
                      ChartSampleData(
                        x: 'Cancel',
                        y: overAllAnalysisData?.totalOrders.cancel ?? 0,
                        text: overAllAnalysisData?.totalOrders.cancel.toString() ?? '0',
                        pointColor: Color.fromRGBO(208, 0, 0, 1),
                      ),
                    ],
                    xValueMapper: (ChartSampleData data, _) => data.x as String,
                    yValueMapper: (ChartSampleData data, _) => data.y,
                    dataLabelMapper: (ChartSampleData data, _) => data.text,
                    pointColorMapper: (ChartSampleData data, _) => data.pointColor,
                    dataLabelSettings: const DataLabelSettings(isVisible: true,),
                  )
                ],
                tooltipBehavior: _customerTooltip,
              );
            },
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: WeeklyOverAllAnalysisTileWidget(
            index: 1,
            title: 'Rush Day',
            subTitle: '${overAllAnalysisData?.rushDay ?? 0}',
            gradient: linearGradient(
              Alignment.bottomCenter,
              ['#5038EA', '#C391B3'],
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: WeeklyOverAllAnalysisTileWidget(
            index: 1,
            title: 'Rush Hours',
            subTitle: '${overAllAnalysisData?.rushHours.fromTime ?? 0} - ${overAllAnalysisData?.rushHours.toTime ?? 0}',
            gradient: linearGradient(
              Alignment.bottomCenter,
              ['#5038EA', '#C391B3'],
            ),
          ),
        ),
      ],
    );
  }
}

class WeeklyOverAllAnalysisTileWidget extends StatelessWidget {
  const WeeklyOverAllAnalysisTileWidget({
    Key? key,
    required this.index,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
    this.title = '',
    this.subTitle = '',
    this.titleBackgroundColor,
    this.titleBackgroundImage,
    this.mainAxisExtent = 4.0,
    this.gradient,
  }) : super(key: key);

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;
  final String title;
  final String subTitle;
  final Color? titleBackgroundColor;
  final Widget? titleBackgroundImage;
  final double mainAxisExtent;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    const _defaultColor = Color(0xFF34568B);
    final child = Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? _defaultColor,
        borderRadius: BorderRadiusDirectional.circular(6),
        gradient: gradient,
      ),
      height: extent,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          textDirection: serviceLocator<LanguageController>().targetTextDirection,
          children: [
            Wrap(
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: context.titleMedium!.copyWith(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                ).translate(),
              ],
            ),
            AnimatedGap(mainAxisExtent, duration: const Duration(milliseconds: 500)),
            Wrap(
              children: [
                Text(
                  subTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: context.labelLarge!.copyWith(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                ).translate(),
              ],
            ),
            /*CircleAvatar(
              minRadius: 20,
              maxRadius: 20,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              child: Text('$index', style: const TextStyle(fontSize: 20)),
            ),*/
          ],
        ),
      ),
    );

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: bottomSpace,
          color: Colors.green,
        )
      ],
    );
  }
}
