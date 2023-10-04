part of 'package:homemakers_merchant/app/features/order/index.dart';

class OrderCardWidget extends StatefulWidget {
  const OrderCardWidget({
    super.key,
    required this.index,
    required this.orderEntity,
  });

  final int index;
  final OrderEntity orderEntity;

  @override
  _OrderCardWidgetController createState() => _OrderCardWidgetController();
}

class _OrderCardWidgetController extends State<OrderCardWidget> {
  Widget bottomWidget(int index, {required OrderEntity orderEntity}) {
    return switch (
        OrderStatus.values.byName(OrderStatus.values[index].toString())) {
      OrderStatus.newOrder => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.only(
                      bottomStart: Radius.circular(10),
                    ),
                  ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {},
                child: Text(
                  'Cancel',
                  style: const TextStyle(color: Color.fromRGBO(42, 45, 50, 1)),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                ).translate(),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorScheme.primary,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.only(
                      bottomEnd: Radius.circular(10),
                    ),
                  ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {},
                child: Text(
                  'Accept',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                ).translate(),
              ),
            ),
          ],
        ),
      OrderStatus.onProcessing || OrderStatus.preparing => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.only(
                      bottomStart: Radius.circular(10),
                    ),
                  ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {},
                child: Text(
                  'Delay',
                  style: const TextStyle(color: Color.fromRGBO(42, 45, 50, 1)),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                ).translate(),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorScheme.primary,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.only(
                      bottomEnd: Radius.circular(10),
                    ),
                  ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Move to Ready',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                ).translate(),
              ),
            ),
          ],
        ),
      OrderStatus.readyToPickup || OrderStatus.onTheWay => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          textDirection:
              serviceLocator<LanguageController>().targetTextDirection,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: DriverAssignCardWidget(
                orderEntity: widget.orderEntity,
                index: widget.index,
              ),
            ),
          ],
        ),
      _ => const Offstage(),
    };
  }

  @override
  Widget build(BuildContext context) => _OrderCardWidgetView(this);
}

class _OrderCardWidgetView
    extends WidgetView<OrderCardWidget, _OrderCardWidgetController> {
  const _OrderCardWidgetView(super.state);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: false,
      child: InkWell(
        onTap: () {},
        child: Card(
          margin: const EdgeInsetsDirectional.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            textDirection:
                serviceLocator<LanguageController>().targetTextDirection,
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsetsDirectional.only(
                    start: 12,
                    end: 12,
                  ),
                  decoration: const BoxDecoration(
                    //color: context.colorScheme.secondaryContainer,
                    color: Color.fromRGBO(238, 238, 238, 1),
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(10),
                      topEnd: Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    textDirection: serviceLocator<LanguageController>()
                        .targetTextDirection,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          textDirection: serviceLocator<LanguageController>()
                              .targetTextDirection,
                          children: [
                            const AnimatedGap(8,
                                duration: Duration(milliseconds: 100)),
                            Directionality(
                              textDirection:
                                  serviceLocator<LanguageController>()
                                      .targetTextDirection,
                              child: Text(
                                'Order ID: HMW-${widget.orderEntity.orderID} ',
                                style: context.labelLarge!
                                    .copyWith(fontWeight: FontWeight.w600,color: Colors.white.onColor,),
                                maxLines: 1,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const AnimatedGap(3,
                                duration: Duration(milliseconds: 100)),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              textDirection:
                                  serviceLocator<LanguageController>()
                                      .targetTextDirection,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 14,
                                  color: Colors.white.onColor,
                                ),
                                const AnimatedGap(3,
                                    duration: Duration(milliseconds: 100)),
                                Directionality(
                                  textDirection:
                                      serviceLocator<LanguageController>()
                                          .targetTextDirection,
                                  child: Wrap(
                                    textDirection:
                                    serviceLocator<LanguageController>()
                                        .targetTextDirection,
                                    children: [
                                      Text(
                                        dateTimeFormatToString(
                                                widget.orderEntity.orderDateTime) ??
                                            '',
                                        style: context.labelMedium!
                                            .copyWith(fontWeight: FontWeight.w500,color: Colors.white.onColor,),
                                        maxLines: 1,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                            const AnimatedGap(8,
                                duration: Duration(milliseconds: 100)),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                        children: [
                          Directionality(
                            textDirection: serviceLocator<LanguageController>()
                                .targetTextDirection,
                            child: WrapText(
                              'Instant',
                              breakWordCharacter: '-',
                              smartSizeMode: false,
                              asyncMode: true,
                              minFontSize: 13,
                              maxFontSize: 14,
                              textStyle: context.labelSmall!.copyWith(
                                  color: context.colorScheme.primary,
                                  fontWeight: FontWeight.w600),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const AnimatedGap(4, duration: Duration(milliseconds: 100)),
              Flexible(
                flex: 3,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        clipBehavior: Clip.none,
                        children: [
                          AspectRatio(
                            aspectRatio: 1 / 0.8,
                            child: Card(
                              margin: const EdgeInsetsDirectional.only(
                                start: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusDirectional.circular(10),
                              ),
                              child: ImageHelper(
                                image: (widget.orderEntity.store.menu[0]
                                        .menuImage.isEmptyOrNull)
                                    ? 'assets/svg/sorry-image-not-available.svg'
                                    : widget
                                        .orderEntity.store.menu[0].menuImage,
                                filterQuality: FilterQuality.high,
                                borderRadius:
                                    BorderRadiusDirectional.circular(10),
                                imageType: findImageType(
                                    widget.orderEntity.store.menu[0].menuImage),
                                imageShape: ImageShape.rectangle,
                                boxFit: BoxFit.cover,
                                defaultErrorBuilderColor: Colors.blueGrey,
                                errorBuilder: const Icon(
                                  Icons.image_not_supported,
                                  size: 10000,
                                ),
                                loaderBuilder:
                                    const CircularProgressIndicator(),
                                matchTextDirection: true,
                                placeholderText:
                                    widget.orderEntity.store.menu[0].menuName,
                                placeholderTextStyle:
                                    context.labelLarge!.copyWith(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 300),
                            bottom: -12,
                            left: leftPositionValue(
                                widget.orderEntity.orderStatus),
                            child: Chip(
                              labelPadding: const EdgeInsetsDirectional.all(1),
                              labelStyle: TextStyle(
                                fontSize: 13,
                                color: (OrderStatus.values.byName(OrderStatus
                                                .values[widget
                                                    .orderEntity.orderStatus]
                                                .toString()) ==
                                            OrderStatus.newOrder ||
                                        OrderStatus.values.byName(OrderStatus
                                                .values[widget
                                                    .orderEntity.orderStatus]
                                                .toString()) ==
                                            OrderStatus.readyToPickup)
                                    ? OrderStatus
                                        .values[widget.orderEntity.orderStatus]
                                        .borderColor
                                    : const Color.fromRGBO(42, 45, 50, 1)
                                        .getOnColorBy(
                                        const Color.fromRGBO(42, 45, 50, 1),
                                        OrderStatus
                                            .values[
                                                widget.orderEntity.orderStatus]
                                            .backgroundColor,
                                      ),
                              ),
                              label: Text(
                                OrderStatus
                                    .values[widget.orderEntity.orderStatus]
                                    .title,
                              ),
                              backgroundColor: OrderStatus
                                  .values[widget.orderEntity.orderStatus]
                                  .backgroundColor,
                              elevation: 0.0,
                              visualDensity: const VisualDensity(
                                  horizontal: -4, vertical: -4),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              padding: const EdgeInsetsDirectional.all(6),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusDirectional.circular(20),
                                side: BorderSide(
                                  color: OrderStatus
                                      .values[widget.orderEntity.orderStatus]
                                      .borderColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 4, end: 4, top: 4, bottom: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            textDirection: serviceLocator<LanguageController>()
                                .targetTextDirection,
                            children: [
                              //const AnimatedGap(6, duration: Duration(milliseconds: 100)),
                              Directionality(
                                textDirection:
                                    serviceLocator<LanguageController>()
                                        .targetTextDirection,
                                child: WrapText(
                                  widget.orderEntity.store.menu[0].menuName,
                                  breakWordCharacter: '-',
                                  smartSizeMode: false,
                                  asyncMode: true,
                                  minFontSize: 14,
                                  maxFontSize: 16,
                                  textStyle: context.labelMedium!
                                      .copyWith(fontWeight: FontWeight.w600),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const AnimatedGap(2,
                                  duration: Duration(milliseconds: 100)),
                              /*Directionality(
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                child: WrapText(
                                  'OrderID: HMW-${orderEntity.orderID}',
                                  breakWordCharacter: '-',
                                  smartSizeMode: false,
                                  asyncMode: true,
                                  minFontSize: 11,
                                  maxFontSize: 12,
                                  textStyle: context.labelSmall!.copyWith(fontWeight: FontWeight.w500),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const AnimatedGap(2, duration: Duration(milliseconds: 100)),*/
                              Directionality(
                                textDirection:
                                    serviceLocator<LanguageController>()
                                        .targetTextDirection,
                                child: WrapText(
                                  widget.orderEntity.store.storeName,
                                  breakWordCharacter: '-',
                                  smartSizeMode: false,
                                  asyncMode: true,
                                  minFontSize: 14,
                                  maxFontSize: 16,
                                  textStyle: context.bodySmall!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              Row(
                                mainAxisSize: MainAxisSize.min,
                                textDirection:
                                    serviceLocator<LanguageController>()
                                        .targetTextDirection,
                                children: [
                                  Directionality(
                                    textDirection:
                                        serviceLocator<LanguageController>()
                                            .targetTextDirection,
                                    child: WrapText(
                                      'Quantity: ${widget.orderEntity.store.menu[0].quantity}',
                                      breakWordCharacter: '-',
                                      smartSizeMode: false,
                                      asyncMode: true,
                                      minFontSize: 12,
                                      maxFontSize: 13,
                                      textStyle: context.bodySmall!.copyWith(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const AnimatedGap(6,
                                      duration: Duration(milliseconds: 100)),
                                  //Spacer(),
                                  Directionality(
                                    textDirection:
                                        serviceLocator<LanguageController>()
                                            .targetTextDirection,
                                    child: WrapText(
                                      '${widget.orderEntity.payment.amount} ${widget.orderEntity.payment.currency}',
                                      breakWordCharacter: '-',
                                      smartSizeMode: false,
                                      asyncMode: true,
                                      minFontSize: 12,
                                      maxFontSize: 13,
                                      textStyle: context.bodySmall!.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const Spacer(),
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(24),
                                    child: Container(
                                      padding:
                                          const EdgeInsetsDirectional.symmetric(
                                              horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            251, 219, 11, 1),
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                24),
                                        border: Border.all(
                                          color: const Color.fromRGBO(
                                              243, 188, 88, 1),
                                        ),
                                      ),
                                      child: Directionality(
                                        textDirection:
                                            serviceLocator<LanguageController>()
                                                .targetTextDirection,
                                        child: WrapText(
                                          'PAID',
                                          breakWordCharacter: '-',
                                          smartSizeMode: false,
                                          asyncMode: true,
                                          minFontSize: 12,
                                          maxFontSize: 13,
                                          textStyle:
                                              context.bodySmall!.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                textDirection:
                                    serviceLocator<LanguageController>()
                                        .targetTextDirection,
                                children: [
                                  Icon(
                                    Icons.timelapse,
                                    size: 14,
                                    color: context.colorScheme.primary,
                                  ),
                                  Directionality(
                                    textDirection:
                                        serviceLocator<LanguageController>()
                                            .targetTextDirection,
                                    child: WrapText(
                                      ' ${dateTimeFormatToString(widget.orderEntity.orderDeliveryDateTime) ?? ''}',
                                      breakWordCharacter: '-',
                                      smartSizeMode: false,
                                      asyncMode: true,
                                      minFontSize: 12,
                                      maxFontSize: 13,
                                      textStyle: context.bodySmall!.copyWith(
                                          color: context.colorScheme.primary),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  //const AnimatedGap(4, duration: Duration(milliseconds: 100)),
                                ],
                              ),
                              //const AnimatedGap(6, duration: Duration(milliseconds: 100)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const AnimatedGap(12, duration: Duration(milliseconds: 100)),
              const Divider(
                thickness: 0.75,
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsetsDirectional.only(
                    start: 12,
                    end: 12,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    textDirection: serviceLocator<LanguageController>()
                        .targetTextDirection,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          textDirection: serviceLocator<LanguageController>()
                              .targetTextDirection,
                          children: [
                            Directionality(
                              textDirection:
                                  serviceLocator<LanguageController>()
                                      .targetTextDirection,
                              child: WrapText(
                                widget.orderEntity.userInfo.userName,
                                breakWordCharacter: '-',
                                smartSizeMode: false,
                                asyncMode: true,
                                minFontSize: 14,
                                maxFontSize: 16,
                                textStyle: context.labelMedium!
                                    .copyWith(fontWeight: FontWeight.w600),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const AnimatedGap(4,
                                duration: Duration(milliseconds: 100)),
                            Directionality(
                              textDirection:
                                  serviceLocator<LanguageController>()
                                      .targetTextDirection,
                              child: WrapText(
                                'Mohammed Ali Al-Ahmed, 8228 Imam Ali Road, Riyadh 12345-6789, Kingdom Of Saudi Arabia',
                                breakWordCharacter: '-',
                                smartSizeMode: false,
                                asyncMode: true,
                                minFontSize: 13,
                                maxFontSize: 15,
                                textStyle: context.labelMedium!
                                    .copyWith(fontWeight: FontWeight.w500),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Directionality(
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                        child: WrapText(
                          '3 Km',
                          breakWordCharacter: '-',
                          smartSizeMode: false,
                          asyncMode: true,
                          minFontSize: 12,
                          maxFontSize: 14,
                          textStyle: context.labelMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const AnimatedGap(8, duration: Duration(milliseconds: 100)),
              Flexible(
                child: Container(
                  child: state.bottomWidget(widget.orderEntity.orderStatus,
                      orderEntity: widget.orderEntity),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double leftPositionValue(int index) {
    return switch (
        OrderStatus.values.byName(OrderStatus.values[index].toString())) {
      OrderStatus.newOrder => 22.0,
      OrderStatus.delivered => 26.0,
      OrderStatus.preparing => 22.0,
      OrderStatus.onTheWay => 20.0,
      OrderStatus.readyToPickup => 31.0,
      OrderStatus.cancel ||
      OrderStatus.cancelByUser ||
      OrderStatus.cancelBySystem ||
      OrderStatus.cancelByYou =>
        31.0,
      _ => 24.0,
    };
  }

  String dateTimeFormatToString(DateTime dateTime) {
    //dt
    return dateTime.toMoment().format('MMM, DD YYYY, hh:mm A').toString();
  }
}
