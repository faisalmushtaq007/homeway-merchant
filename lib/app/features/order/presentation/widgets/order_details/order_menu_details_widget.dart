part of 'package:homemakers_merchant/app/features/order/index.dart';

class OrderMenuDetailsWidget extends StatefulWidget {
  const OrderMenuDetailsWidget({required this.orderEntity, required this.subTotalOnChange, super.key});

  final OrderEntity orderEntity;
  final ValueChanged<double> subTotalOnChange;

  @override
  State<OrderMenuDetailsWidget> createState() => _OrderMenuDetailsWidgetState();
}

class _OrderMenuDetailsWidgetState extends State<OrderMenuDetailsWidget> {
  double subTotal = 0;
  @override
  void initState() {
    super.initState();
    subTotal = 0.0;
  }

  void calculateSubTotal(double amount) {
    subTotal += amount;
    widget.subTotalOnChange(subTotal);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CustomScrollView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          GroupSliverListView(
            sectionCount: widget.orderEntity.store.menu.length,
            itemInSectionCount: (int section) {
              return widget.orderEntity.store.menu[section].addons.length;
            },
            headerForSectionBuilder: (int section) {
              final Menu menu = widget.orderEntity.store.menu[section];
              calculateSubTotal(menu.price);
              return Card(
                margin: const EdgeInsetsDirectional.only(bottom: 8),
                key: ValueKey(section),
                child: ListTile(
                  contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
                  horizontalTitleGap: 8,
                  leading: AspectRatio(
                    aspectRatio: 1 / 0.9,
                    child: Card(
                      margin: const EdgeInsetsDirectional.only(
                        start: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(10),
                      ),
                      child: ImageHelper(
                        image: (menu.menuImage.isEmptyOrNull) ? 'assets/svg/sorry-image-not-available.svg' : menu.menuImage,
                        filterQuality: FilterQuality.high,
                        borderRadius: BorderRadiusDirectional.circular(10),
                        imageType: findImageType((menu.menuImage.isEmptyOrNull) ? 'assets/svg/sorry-image-not-available.svg' : menu.menuImage),
                        imageShape: ImageShape.rectangle,
                        boxFit: BoxFit.cover,
                        defaultErrorBuilderColor: Colors.blueGrey,
                        errorBuilder: const Icon(
                          Icons.image_not_supported,
                          size: 10000,
                        ),
                        loaderBuilder: const CircularProgressIndicator(),
                        matchTextDirection: true,
                        placeholderText: menu.menuName,
                        placeholderTextStyle: context.labelLarge!.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    menu.menuName,
                    style: context.titleMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 3,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                    children: [
                      Row(
                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /*Text(
                            'Taste',
                            style: context.labelMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 1,
                          ),
                          const AnimatedGap(8, duration: Duration(milliseconds: 100)),*/
                          Text(
                            menu.tasteLevel,
                            style: context.labelMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 1,
                          ),
                          const AnimatedGap(4, duration: Duration(milliseconds: 100)),
                          Text(
                            menu.tasteType,
                            style: context.labelMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 1,
                          ),
                          const AnimatedGap(8, duration: Duration(milliseconds: 100)),
                        ],
                      ),
                      const AnimatedGap(4, duration: Duration(milliseconds: 100)),
                      Wrap(
                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Portion:',
                                style: context.labelMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                maxLines: 1,
                              ),
                              const AnimatedGap(2, duration: Duration(milliseconds: 100)),
                              Text(
                                menu.orderPortion?.portionSize.toString() ?? '',
                                style: context.labelMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                maxLines: 1,
                              ),
                              const AnimatedGap(4, duration: Duration(milliseconds: 100)),
                              Text(
                                menu.orderPortion?.portionUnit.toString() ?? '',
                                style: context.labelMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: SizedBox(
                    width: 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Wrap(
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'x',
                                  style: context.labelMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  maxLines: 1,
                                ),
                                const AnimatedGap(4, duration: Duration(milliseconds: 100)),
                                Text(
                                  menu.quantity.toString(),
                                  style: context.labelMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const AnimatedGap(2, duration: Duration(milliseconds: 100)),
                        Wrap(
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          children: [
                            Text(
                              '${menu.price} ${menu.currency}',
                              style: context.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemInSectionBuilder: (BuildContext context, IndexPath indexPath) {
              final Addon addon = widget.orderEntity.store.menu[indexPath.section].addons[indexPath.index];
              calculateSubTotal(addon.price);
              return Card(
                key: ValueKey(indexPath.index),
                margin: const EdgeInsetsDirectional.only(bottom: 8),
                child: ListTile(
                  horizontalTitleGap: 8,
                  contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
                  leading: AspectRatio(
                    aspectRatio: 1 / 0.9,
                    child: Card(
                      margin: const EdgeInsetsDirectional.only(
                        start: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(10),
                      ),
                      child: ImageHelper(
                        image: (addon.addonsImage.isEmptyOrNull) ? 'assets/svg/sorry-image-not-available.svg' : addon.addonsImage,
                        filterQuality: FilterQuality.high,
                        borderRadius: BorderRadiusDirectional.circular(10),
                        imageType: findImageType((addon.addonsImage.isEmptyOrNull) ? 'assets/svg/sorry-image-not-available.svg' : addon.addonsImage),
                        imageShape: ImageShape.rectangle,
                        boxFit: BoxFit.cover,
                        defaultErrorBuilderColor: Colors.blueGrey,
                        errorBuilder: const Icon(
                          Icons.image_not_supported,
                          size: 10000,
                        ),
                        loaderBuilder: const CircularProgressIndicator(),
                        matchTextDirection: true,
                        placeholderText: addon.addonsName,
                        placeholderTextStyle: context.labelLarge!.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    addon.addonsName,
                    style: context.titleMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 3,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                    children: [
                      Wrap(
                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Portion:',
                                style: context.labelMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                maxLines: 1,
                              ),
                              const AnimatedGap(2, duration: Duration(milliseconds: 100)),
                              Text(
                                addon.orderPortion?.portionSize.toString() ?? '',
                                style: context.labelMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                maxLines: 1,
                              ),
                              const AnimatedGap(4, duration: Duration(milliseconds: 100)),
                              Text(
                                addon.orderPortion?.portionUnit.toString() ?? '',
                                style: context.labelMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: SizedBox(
                    width: 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Wrap(
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'x',
                                  style: context.labelMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  maxLines: 1,
                                ),
                                const AnimatedGap(4, duration: Duration(milliseconds: 100)),
                                Text(
                                  addon.quantity.toString(),
                                  style: context.labelMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const AnimatedGap(2, duration: Duration(milliseconds: 100)),
                        Wrap(
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          children: [
                            Text(
                              '${addon.price} ${addon.currency}',
                              style: context.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (IndexPath indexPath) {
              return nil;
            },
          )
        ],
      ),
    );
  }
}
