part of 'package:homemakers_merchant/app/features/analysis/index.dart';

class OrderAnalysisGridWidget extends StatelessWidget {
  const OrderAnalysisGridWidget({
    super.key,
    this.overAllAnalysisData,
  });
  final OverAllAnalysisData? overAllAnalysisData;

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
          child: Tile(
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
          mainAxisCellCount: 2,
          child: Tile(
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
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: Tile(
            index: 2,
            title: 'Customers',
            subTitle: '${overAllAnalysisData?.totalCustomers ?? 0}',
            gradient: linearGradient(
              Alignment.bottomCenter,
              ['#4077b0', '#f9c084'],
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: Tile(
            index: 3,
            title: 'Total Orders',
            subTitle:
                '${overAllAnalysisData?.totalOrders.countTotalOrders ?? 0}',
            gradient: linearGradient(
              Alignment.bottomCenter,
              ['#5038EA', '#C391B3'],
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Tile(
            index: 4,
            title: 'New',
            subTitle: '${overAllAnalysisData?.totalOrders.totalOrdersNew ?? 0}',
            gradient: linearGradient(
              Alignment.bottomCenter,
              ['#A89198', '#B385CA'],
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Tile(
            index: 5,
            title: 'Delivered',
            subTitle: '${overAllAnalysisData?.totalOrders.deliver ?? 0}',
            gradient: linearGradient(
              Alignment.bottomCenter,
              ['#6C83CA', '#B98178'],
            ),
          ),
        ),
      ],
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
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
          textDirection:
              serviceLocator<LanguageController>().targetTextDirection,
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
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                ).translate(),
              ],
            ),
            AnimatedGap(mainAxisExtent,
                duration: const Duration(milliseconds: 500)),
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
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
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
