part of 'package:homemakers_merchant/app/features/order/index.dart';

class OrderTimeLineCardWidget extends StatelessWidget {
  const OrderTimeLineCardWidget(
      {required this.orderEntity, this.activeLocale = 'en_US', super.key});
  final OrderEntity orderEntity;
  final String activeLocale;

  @override
  Widget build(BuildContext context) {
    moment.Moment.setGlobalLocalization(
        moment.MomentLocalizations.byLocale(serviceLocator<LanguageController>().targetAppLanguage.value.toString())!);
    final moment.Moment now = moment.Moment.now();
    return Card(
      margin: EdgeInsetsDirectional.zero,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 12,
          end: 12,
          top: 8,
          bottom: 8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          textDirection:
              serviceLocator<LanguageController>().targetTextDirection,
          children: [
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                textDirection:
                    serviceLocator<LanguageController>().targetTextDirection,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      textDirection: serviceLocator<LanguageController>()
                          .targetTextDirection,
                      children: [
                        Directionality(
                          textDirection: serviceLocator<LanguageController>()
                              .targetTextDirection,
                          child: Text(
                            'Received At',
                            style: context.bodyMedium!
                                .copyWith(fontWeight: FontWeight.w500),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textDirection: serviceLocator<LanguageController>()
                                .targetTextDirection,
                            softWrap: true,
                          ).translate(),
                        ),
                        Directionality(
                          textDirection: serviceLocator<LanguageController>()
                              .targetTextDirection,
                          child: Text(
                            '${now.subtract(now.difference(orderEntity.orderDateTime)).calendar()}',
                            style: context.labelMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                            textDirection: serviceLocator<LanguageController>()
                                .targetTextDirection,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ).translate(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                        children: [
                          Container(
                            height: 10,
                            width: 1,
                            color: Color.fromRGBO(165, 166, 168, 0.5),
                          ),
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.white,
                            child: Directionality(
                              textDirection:
                                  serviceLocator<LanguageController>()
                                      .targetTextDirection,
                              child: Icon(
                                Icons.arrow_forward,
                                color: context.colorScheme.primary,
                                size: 14,
                                textDirection:
                                    serviceLocator<LanguageController>()
                                        .targetTextDirection,
                              ),
                            ),
                          ),
                          Container(
                            height: 10,
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
                      textDirection: serviceLocator<LanguageController>()
                          .targetTextDirection,
                      children: [
                        Directionality(
                          textDirection: serviceLocator<LanguageController>()
                              .targetTextDirection,
                          child: Text(
                            'Delivered By',
                            style: context.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: context.colorScheme.primary,
                            ),
                            textDirection: serviceLocator<LanguageController>()
                                .targetTextDirection,
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ).translate(),
                        ),
                        Directionality(
                          textDirection: serviceLocator<LanguageController>()
                              .targetTextDirection,
                          child: Text(
                            now
                                .subtract(now.difference(
                                    orderEntity.orderDeliveryDateTime))
                                .calendar(),
                            style: context.labelMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: context.colorScheme.primary,
                            ),
                            maxLines: 1,
                            textDirection: serviceLocator<LanguageController>()
                                .targetTextDirection,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                            softWrap: true,
                          ).translate(),
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
