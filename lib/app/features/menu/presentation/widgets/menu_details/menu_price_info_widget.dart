part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuPriceInfoWidget extends StatefulWidget {
  const MenuPriceInfoWidget({
    super.key,
    required this.menuEntity,
    this.title = '',
    this.value = 0.0,
    this.currency = 'SAR',
    this.hasAddons = false,
  });

  final MenuEntity menuEntity;
  final String title;
  final double value;
  final String currency;
  final bool hasAddons;

  @override
  State<MenuPriceInfoWidget> createState() => _MenuPriceInfoWidgetState();
}

class _MenuPriceInfoWidgetState extends State<MenuPriceInfoWidget> {
  List<MenuPriceInfo> listOfMenuPriceInfo = [];
  @override
  void initState() {
    super.initState();
    listOfMenuPriceInfo = [];
    listOfMenuPriceInfo.clear();
    if (widget.hasAddons) {
      widget.menuEntity.addons.asMap().forEach((key, value) {
        listOfMenuPriceInfo.add(MenuPriceInfo(
          title: value.title,
          defaultPrice: value.defaultPrice,
          currency: value.currency,
        ));
      });
    } else {
      if (widget.menuEntity.hasCustomPortion &&
          widget.menuEntity.customPortion != null) {
        final CustomPortion? customPortion = widget.menuEntity.customPortion;
        listOfMenuPriceInfo.add(MenuPriceInfo(
          title: customPortion?.title ?? '',
          defaultPrice: customPortion?.defaultPrice ?? 0.0,
          currency: customPortion?.currency ?? 'SAR',
        ));
      } else {
        widget.menuEntity.menuPortions.asMap().forEach((key, value) {
          listOfMenuPriceInfo.add(MenuPriceInfo(
            title: value.title,
            defaultPrice: value.defaultPrice,
            currency: value.currency,
          ));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: ListView.builder(
        itemCount: listOfMenuPriceInfo.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            key: ValueKey(index),
            child: ListTile(
              title: Text(
                listOfMenuPriceInfo[index].title,
                style: context.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.primary,
                ),
                textDirection:
                    serviceLocator<LanguageController>().targetTextDirection,
              ),
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                textDirection:
                    serviceLocator<LanguageController>().targetTextDirection,
                children: [
                  Text(
                    listOfMenuPriceInfo[index].currency,
                    textDirection: serviceLocator<LanguageController>()
                        .targetTextDirection,
                    style: context.titleMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const AnimatedGap(6, duration: Duration(milliseconds: 100)),
                  Text(
                    listOfMenuPriceInfo[index].defaultPrice.toString(),
                    textDirection: serviceLocator<LanguageController>()
                        .targetTextDirection,
                    style: context.titleMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class MenuPriceInfo {
  const MenuPriceInfo({
    required this.title,
    this.currency = 'SAR',
    this.defaultPrice = 0.0,
    this.discountPrice = 0.0,
    this.finalPrice = 0.0,
  });
  final String title;
  final String currency;
  final double defaultPrice;
  final double discountPrice;
  final double finalPrice;
}
