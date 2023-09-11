part of 'package:homemakers_merchant/app/features/order/index.dart';

class OrderDeliveryInfoWidget extends StatelessWidget {
  const OrderDeliveryInfoWidget({required this.orderEntity, super.key});

  final OrderEntity orderEntity;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsetsDirectional.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
        children: [
          Container(
            padding: const EdgeInsetsDirectional.only(
              start: 12,
              end: 12,
              top: 12,
              bottom: 12,
            ),
            decoration: const BoxDecoration(
              //color: context.colorScheme.secondaryContainer,
              color: Color.fromRGBO(238, 238, 238, 1),
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),
              ),
            ),
            child: Directionality(
              textDirection:
                  serviceLocator<LanguageController>().targetTextDirection,
              child: WrapText(
                'Customer Details',
                breakWordCharacter: '-',
                smartSizeMode: false,
                asyncMode: true,
                minFontSize: 13,
                maxFontSize: 14,
                textStyle: context.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  //color: context.colorScheme.primary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 12,
              end: 12,
              top: 12,
              bottom: 8,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              textDirection:
                  serviceLocator<LanguageController>().targetTextDirection,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Directionality(
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                        child: WrapText(
                          'Name',
                          breakWordCharacter: '-',
                          smartSizeMode: false,
                          asyncMode: true,
                          minFontSize: 12,
                          maxFontSize: 13,
                          textStyle: context.labelMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: context.colorScheme.inverseSurface,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const AnimatedGap(
                      8,
                      duration: Duration(milliseconds: 100),
                    ),
                    Expanded(
                      flex: 2,
                      child: Wrap(
                        children: [
                          Directionality(
                            textDirection: serviceLocator<LanguageController>()
                                .targetTextDirection,
                            child: WrapText(
                              '${orderEntity.userInfo.deliveryAddress.contactPerson}',
                              breakWordCharacter: '-',
                              smartSizeMode: false,
                              asyncMode: true,
                              minFontSize: 12,
                              maxFontSize: 13,
                              textStyle: context.bodySmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: context.colorScheme.inverseSurface,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                /*const AnimatedGap(
                  12,
                  duration: Duration(milliseconds: 100),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Directionality(
                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                        child: WrapText(
                          'Mobile',
                          breakWordCharacter: '-',
                          smartSizeMode: false,
                          asyncMode: true,
                          minFontSize: 12,
                          maxFontSize: 13,
                          textStyle: context.labelMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: context.colorScheme.inverseSurface,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const AnimatedGap(
                      8,
                      duration: Duration(milliseconds: 100),
                    ),
                    Expanded(
                      flex: 2,
                      child: Wrap(
                        children: [
                          Directionality(
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            child: WrapText(
                              '${orderEntity.userInfo.deliveryAddress.contactNumber}',
                              breakWordCharacter: '-',
                              smartSizeMode: false,
                              asyncMode: true,
                              minFontSize: 12,
                              maxFontSize: 13,
                              textStyle: context.bodySmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: context.colorScheme.inverseSurface,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),*/
                const AnimatedGap(
                  12,
                  duration: Duration(milliseconds: 100),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Directionality(
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                        child: WrapText(
                          'Address',
                          breakWordCharacter: '-',
                          smartSizeMode: false,
                          asyncMode: true,
                          minFontSize: 12,
                          maxFontSize: 13,
                          textStyle: context.labelMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: context.colorScheme.inverseSurface,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const AnimatedGap(
                      8,
                      duration: Duration(milliseconds: 100),
                    ),
                    Expanded(
                      flex: 2,
                      child: Wrap(
                        children: [
                          Directionality(
                            textDirection: serviceLocator<LanguageController>()
                                .targetTextDirection,
                            child: WrapText(
                              '${orderEntity.userInfo.deliveryAddress.completeAddress}',
                              breakWordCharacter: '-',
                              smartSizeMode: false,
                              asyncMode: true,
                              minFontSize: 12,
                              maxFontSize: 13,
                              textStyle: context.bodySmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: context.colorScheme.inverseSurface,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const AnimatedGap(
                  12,
                  duration: Duration(milliseconds: 100),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Directionality(
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                        child: WrapText(
                          'Distance',
                          breakWordCharacter: '-',
                          smartSizeMode: false,
                          asyncMode: true,
                          minFontSize: 12,
                          maxFontSize: 13,
                          textStyle: context.labelMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: context.colorScheme.inverseSurface,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const AnimatedGap(
                      8,
                      duration: Duration(milliseconds: 100),
                    ),
                    Expanded(
                      flex: 2,
                      child: Wrap(
                        children: [
                          Directionality(
                            textDirection: serviceLocator<LanguageController>()
                                .targetTextDirection,
                            child: WrapText(
                              '6.5 Km from ${orderEntity.store.storeName}',
                              breakWordCharacter: '-',
                              smartSizeMode: false,
                              asyncMode: true,
                              minFontSize: 12,
                              maxFontSize: 13,
                              textStyle: context.bodySmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: context.colorScheme.primary,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const AnimatedGap(
                  8,
                  duration: Duration(milliseconds: 100),
                ),
                Divider(
                  thickness: 0.75,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Directionality(
                      textDirection: serviceLocator<LanguageController>()
                          .targetTextDirection,
                      child: WrapText(
                        'Communication:',
                        breakWordCharacter: '-',
                        smartSizeMode: false,
                        asyncMode: true,
                        minFontSize: 12,
                        maxFontSize: 13,
                        textStyle: context.labelMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: context.colorScheme.inverseSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                        icon: Icon(
                          Icons.map,
                          color: context.colorScheme.primary,
                        ),
                        onPressed: () {},
                        style: IconButton.styleFrom(
                          shape: CircleBorder(),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        )),
                    IconButton(
                        icon: Icon(
                          Icons.chat,
                          color: context.colorScheme.primary,
                        ),
                        onPressed: () {},
                        style: IconButton.styleFrom(
                          shape: CircleBorder(),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        )),
                    /*IconButton(
                      icon: Icon(
                        Icons.phone_in_talk,
                        color: context.colorScheme.primary,
                      ),
                      onPressed: () {},
                      style: IconButton.styleFrom(
                        shape: CircleBorder(),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),*/
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
