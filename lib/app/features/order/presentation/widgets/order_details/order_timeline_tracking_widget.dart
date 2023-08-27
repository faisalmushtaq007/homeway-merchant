part of 'package:homemakers_merchant/app/features/order/index.dart';

class OrderTimelineTrackingWidget extends StatefulWidget {
  const OrderTimelineTrackingWidget({required this.orderEntity, this.activeLocale = 'en_US', super.key});

  final OrderEntity orderEntity;
  final String activeLocale;

  @override
  _OrderTimelineTrackingWidgetController createState() => _OrderTimelineTrackingWidgetController();
}

class _OrderTimelineTrackingWidgetController extends State<OrderTimelineTrackingWidget> {
  List<TrackingInfo> trackingInfo = [];

  @override
  void initState() {
    super.initState();
    trackingInfo = [];
    trackingInfo.clear();
    readAndWriteTracking();
  }

  Future<void> readAndWriteTracking() async {
    final data = await readTrackingData();
    trackingInfo = data.toList();
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => _OrderTimelineTrackingWidgetView(this);
}

class _OrderTimelineTrackingWidgetView extends WidgetView<OrderTimelineTrackingWidget, _OrderTimelineTrackingWidgetController> {
  const _OrderTimelineTrackingWidgetView(super.state);

  @override
  Widget build(BuildContext context) {
    moment.Moment.setGlobalLocalization(moment.MomentLocalizations.byLocale(widget.activeLocale)!);
    final moment.Moment now = moment.Moment.now();
    return Card(
      margin: const EdgeInsetsDirectional.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 12,
          end: 12,
          top: 8,
          bottom: 8,
        ),
        child: SizedBox(
          child: CustomScrollView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: FixedTimeline.tileBuilder(
                  builder: TimelineTileBuilder.fromStyle(
                    contentsAlign: ContentsAlign.alternating,
                    contentsBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsetsDirectional.all(4),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Text(
                                  state.trackingInfo[0].tracking!.eventHistory![index].eventCode?.groupTitle ?? '',
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  style: context.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ).translate(),
                              ],
                            ),
                            Wrap(
                              children: [
                                Text(
                                  now
                                      .subtract(now.difference(
                                          moment.Moment.fromMillisecondsSinceEpoch(state.trackingInfo[0].tracking!.eventHistory![index].eventTime ?? 0)))
                                      .calendar(customFormat: "llll" /*"LLLL"*/),
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  style: context.labelMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ).translate(),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: (state.trackingInfo.isNotNullOrEmpty &&
                            state.trackingInfo[0].isNotNull &&
                            state.trackingInfo[0].tracking!.eventHistory.isNotNullOrEmpty)
                        ? state.trackingInfo[0].tracking!.eventHistory!.length
                        : 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
