part of 'package:homemakers_merchant/app/features/order/index.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({
    super.key,
    required this.index,
    required this.orderEntity,
  });

  final int index;
  final OrderEntity orderEntity;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 1 / 0.8,
              child: Card(
                margin: EdgeInsetsDirectional.only(
                  start: 12,
                  top: 0,
                  bottom: 0,
                  end: 0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(10),
                ),
                child: ImageHelper(
                  image: (orderEntity.store.menu[0].menuImage.isEmptyOrNull) ? 'assets/svg/sorry-image-not-available.svg' : orderEntity.store.menu[0].menuImage,
                  scale: 1.0,
                  filterQuality: FilterQuality.high,
                  borderRadius: BorderRadiusDirectional.circular(10),
                  imageType: findImageType(orderEntity.store.menu[0].menuImage),
                  imageShape: ImageShape.rectangle,
                  boxFit: BoxFit.cover,
                  defaultErrorBuilderColor: Colors.blueGrey,
                  errorBuilder: const Icon(
                    Icons.image_not_supported,
                    size: 10000,
                  ),
                  loaderBuilder: const CircularProgressIndicator(),
                  matchTextDirection: true,
                  placeholderText: orderEntity.store.menu[0].menuName,
                  placeholderTextStyle: context.labelLarge!.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 4, end: 4, top: 4, bottom: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                  children: [
                    //const AnimatedGap(6, duration: Duration(milliseconds: 100)),
                    Directionality(
                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                      child: WrapText(
                        orderEntity.store.menu[0].menuName,
                        breakWordCharacter: '-',
                        smartSizeMode: false,
                        asyncMode: true,
                        minFontSize: 16,
                        maxFontSize: 18,
                        textStyle: context.labelLarge!.copyWith(fontWeight: FontWeight.w600),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const AnimatedGap(2, duration: Duration(milliseconds: 100)),
                    Directionality(
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
                    const AnimatedGap(2, duration: Duration(milliseconds: 100)),
                    Directionality(
                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                      child: WrapText(
                        orderEntity.store.storeName,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                      children: [
                        Icon(
                          Icons.timelapse,
                          size: 14,
                          color: context.colorScheme.primary,
                        ),
                        Directionality(
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          child: WrapText(
                            'Instant by 1:30 PM',
                            breakWordCharacter: '-',
                            smartSizeMode: false,
                            asyncMode: true,
                            minFontSize: 12,
                            maxFontSize: 14,
                            textStyle: context.bodySmall!.copyWith(color: context.colorScheme.primary),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const AnimatedGap(4, duration: Duration(milliseconds: 100)),
                        Spacer(),
                        ClipRRect(
                          borderRadius: BorderRadiusDirectional.circular(24),
                          child: Container(
                            padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(251, 219, 11, 1),
                              borderRadius: BorderRadiusDirectional.circular(24),
                              border: Border.all(
                                color: Color.fromRGBO(243, 188, 88, 1),
                              ),
                            ),
                            child: Directionality(
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                              child: WrapText(
                                'COD',
                                breakWordCharacter: '-',
                                smartSizeMode: false,
                                asyncMode: true,
                                minFontSize: 12,
                                maxFontSize: 14,
                                textStyle: context.bodySmall!.copyWith(
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                      children: [
                        Directionality(
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          child: WrapText(
                            'Quantity: ${orderEntity.store.menu[0].quantity}',
                            breakWordCharacter: '-',
                            smartSizeMode: false,
                            asyncMode: true,
                            minFontSize: 12,
                            maxFontSize: 14,
                            textStyle: context.bodySmall!.copyWith(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const AnimatedGap(8, duration: Duration(milliseconds: 100)),
                        //Spacer(),
                        Directionality(
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          child: WrapText(
                            '${orderEntity.payment.amount} ${orderEntity.payment.currency}',
                            breakWordCharacter: '-',
                            smartSizeMode: false,
                            asyncMode: true,
                            minFontSize: 12,
                            maxFontSize: 14,
                            textStyle: context.bodySmall!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
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
    );
  }
}
