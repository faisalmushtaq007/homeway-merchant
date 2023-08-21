part of 'package:homemakers_merchant/app/features/dashboard/index.dart';

class AllOrderWidget extends StatefulWidget {
  const AllOrderWidget({super.key});
  @override
  _AllOrderWidgetController createState() => _AllOrderWidgetController();
}

class _AllOrderWidgetController extends State<AllOrderWidget> {
  List<StoreOrderInfo> listOfStoreOrderInfo = [];
  @override
  void initState() {
    super.initState();
    listOfStoreOrderInfo = [];
    listOfStoreOrderInfo.clear();
  }

  @override
  void dispose() {
    listOfStoreOrderInfo = [];
    listOfStoreOrderInfo.clear();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    listOfStoreOrderInfo = [
      StoreOrderInfo(
        title: 'New',
        subTitle: '5',
        titleTextColor: context.colorScheme.primary,
        subTitleTextColor: context.colorScheme.primary,
        hasOpenUrl: true,
      ),
      const StoreOrderInfo(
        title: 'Schedule',
        subTitle: '4',
        titleTextColor: Color.fromRGBO(42, 45, 50, 1),
        subTitleTextColor: Color.fromRGBO(42, 45, 50, 1),
        hasOpenUrl: true,
      ),
      const StoreOrderInfo(
        title: 'Ongoing',
        subTitle: '2',
        titleTextColor: Color.fromRGBO(255, 90, 39, 1),
        subTitleTextColor: Color.fromRGBO(255, 90, 39, 1),
        hasOpenUrl: true,
      ),
      const StoreOrderInfo(
        title: 'Delivered',
        subTitle: '75',
        titleTextColor: Color.fromRGBO(69, 201, 125, 1),
        subTitleTextColor: Color.fromRGBO(69, 201, 125, 1),
        hasOpenUrl: true,
      ),
      StoreOrderInfo(
        title: 'Cancel',
        subTitle: '4',
        titleTextColor: context.colorScheme.outlineVariant,
        subTitleTextColor: context.colorScheme.outlineVariant,
        hasOpenUrl: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) => _AllOrderWidgetView(this);
}

class _AllOrderWidgetView extends WidgetView<AllOrderWidget, _AllOrderWidgetController> {
  const _AllOrderWidgetView(super.state);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromRGBO(238, 238, 238, 1),
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AnimatedGap(
              16,
              duration: Duration(milliseconds: 100),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'All Orders',
                  style: context.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Text(
                  'All Stores',
                  style: context.labelMedium!.copyWith(
                    color: Color.fromRGBO(127, 129, 132, 1),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Icon(
                  Icons.arrow_drop_up,
                  color: Color.fromRGBO(127, 129, 132, 1),
                )
              ],
            ),
            Divider(
              thickness: 0.75,
            ),
            Container(
              height: 60,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    StoreOrderCardWidget(
                      storeOrderInfo: StoreOrderInfo(
                        title: 'Total',
                        subTitle: '90',
                        titleTextColor: context.colorScheme.onPrimaryContainer,
                        subTitleTextColor: context.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const AnimatedGap(8, duration: Duration(milliseconds: 200)),
                    const VerticalDivider(
                      thickness: 0.75,
                      indent: 6,
                      endIndent: 6,
                    ),
                    const AnimatedGap(8, duration: Duration(milliseconds: 200)),
                    Expanded(
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return const Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AnimatedGap(8, duration: Duration(milliseconds: 200)),
                              VerticalDivider(
                                thickness: 0.75,
                                indent: 6,
                                endIndent: 6,
                              ),
                              AnimatedGap(8, duration: Duration(milliseconds: 200)),
                            ],
                          );
                        },
                        itemCount: state.listOfStoreOrderInfo.length,
                        itemBuilder: (context, index) {
                          return StoreOrderCardWidget(
                            key: ValueKey(index),
                            storeOrderInfo: state.listOfStoreOrderInfo[index],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const AnimatedGap(12, duration: Duration(milliseconds: 200)),
          ],
        ),
      ),
    );
  }
}
