part of 'package:homemakers_merchant/app/features/order/index.dart';

class OrderTimeLineCardWidget extends StatelessWidget {
  const OrderTimeLineCardWidget({required this.orderEntity, this.activeLocale = 'en_US', super.key});
  final OrderEntity orderEntity;
  final String activeLocale;

  @override
  Widget build(BuildContext context) {
    moment.Moment.setGlobalLocalization(moment.MomentLocalizations.byLocale(activeLocale)!);
    final moment.Moment now = moment.Moment.now();
    return Card(
      margin: EdgeInsetsDirectional.zero,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 12,
          end: 12,
          top: 12,
          bottom: 12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          textDirection: serviceLocator<LanguageController>().targetTextDirection,
          children: [
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                      children: [
                        Directionality(
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          child: WrapText(
                            'Received At',
                            breakWordCharacter: '-',
                            smartSizeMode: false,
                            asyncMode: true,
                            minFontSize: 12,
                            maxFontSize: 14,
                            textStyle: context.labelMedium!.copyWith(fontWeight: FontWeight.w500),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Directionality(
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          child: WrapText(
                            '${now.subtract(now.difference(orderEntity.orderDateTime)).calendar()}',
                            breakWordCharacter: '-',
                            smartSizeMode: false,
                            asyncMode: true,
                            minFontSize: 12,
                            maxFontSize: 14,
                            textStyle: context.bodySmall!.copyWith(fontWeight: FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 60,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                        children: [
                          Container(
                            height: 15,
                            width: 1,
                            color: Color.fromRGBO(165, 166, 168, 0.5),
                          ),
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.arrow_forward,
                              color: context.colorScheme.primary,
                              size: 16,
                            ),
                          ),
                          Container(
                            height: 15,
                            width: 1,
                            color: Color.fromRGBO(165, 166, 168, 0.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                      children: [
                        Directionality(
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          child: WrapText(
                            'Delivered By',
                            breakWordCharacter: '-',
                            smartSizeMode: false,
                            asyncMode: true,
                            minFontSize: 12,
                            maxFontSize: 14,
                            textStyle: context.labelMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: context.colorScheme.primary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Directionality(
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          child: WrapText(
                            '${now.subtract(now.difference(orderEntity.orderDeliveryDateTime)).calendar()}',
                            breakWordCharacter: '-',
                            smartSizeMode: false,
                            asyncMode: true,
                            minFontSize: 12,
                            maxFontSize: 14,
                            textStyle: context.bodySmall!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: context.colorScheme.primary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
