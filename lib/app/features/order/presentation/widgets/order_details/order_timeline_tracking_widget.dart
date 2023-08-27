part of 'package:homemakers_merchant/app/features/order/index.dart';

class OrderTimelineTrackingWidget extends StatefulWidget {
  const OrderTimelineTrackingWidget({required this.orderEntity, super.key});

  final OrderEntity orderEntity;

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
    trackingInfo = List<TrackingInfo>.from(widget.orderEntity.trackingInfo.toList());
  }

  @override
  Widget build(BuildContext context) => _OrderTimelineTrackingWidgetView(this);
}

class _OrderTimelineTrackingWidgetView extends WidgetView<OrderTimelineTrackingWidget, _OrderTimelineTrackingWidgetController> {
  const _OrderTimelineTrackingWidgetView(super.state);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsetsDirectional.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 12,
          end: 12,
          top: 8,
          bottom: 8,
        ),
        child: Timeline.tileBuilder(
          builder: TimelineTileBuilder.fromStyle(
            contentsAlign: ContentsAlign.alternating,
            contentsBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text('Timeline Event ${state.trackingInfo[index].tracking?.trackingTitle?.name ?? ''}'),
            ),
            itemCount: state.trackingInfo.length,
          ),
        ),
      ),
    );
  }
}
