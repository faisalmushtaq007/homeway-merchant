part of 'package:homemakers_merchant/app/features/menu/index.dart';

class SetMenuPriceWidget extends StatefulWidget {
  const SetMenuPriceWidget({
    this.currentIndex = -1,
    super.key,
    this.customPortion,
    this.menuPortion,
    this.hasCustomPortion = false,
    this.listOfMenuPortions = const [],
  });
  final MenuPortion? menuPortion;
  final CustomPortion? customPortion;
  final bool hasCustomPortion;
  final int? currentIndex;
  final List<MenuPortion> listOfMenuPortions;

  @override
  _SetMenuPriceWidgetState createState() => _SetMenuPriceWidgetState();
}

class _SetMenuPriceWidgetState extends State<SetMenuPriceWidget> {
  final TextEditingController maximumRetailPriceOfMenuTextEditingController = TextEditingController();
  final TextEditingController discountPriceOfMenuTextEditingController = TextEditingController();
  String portionName = '';

  @override
  void initState() {
    super.initState();
    if (widget.hasCustomPortion && widget.customPortion != null) {
      portionName = widget.customPortion?.title ?? '';
    } else {
      if (widget.menuPortion != null) {
        portionName = widget.menuPortion?.title ?? '';
      }
    }
  }

  @override
  void dispose() {
    maximumRetailPriceOfMenuTextEditingController.dispose();
    discountPriceOfMenuTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          textDirection: serviceLocator<LanguageController>().targetTextDirection,
          children: [
            Wrap(
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
              alignment: WrapAlignment.spaceAround,
              children: [
                Text(
                  '$portionName',
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                ).translate(),
                Text(
                  'Selling price SAR ${maximumRetailPriceOfMenuTextEditingController.value.text.trim()}',
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                ).translate(),
              ],
            ),
            const AnimatedGap(6, duration: Duration(milliseconds: 500)),
            AppTextFieldWidget(
              controller: maximumRetailPriceOfMenuTextEditingController,
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Base Price',
                hintText: 'Enter menu base price',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                isDense: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter menu base price';
                } else {
                  return null;
                }
              },
              onSaved: (newValue) {
                if (widget.hasCustomPortion) {
                  final cacheCustomPortion = serviceLocator<MenuEntity>().customPortion;
                  if (cacheCustomPortion != null) {}
                } else {
                  final cacheMenuPortion = serviceLocator<MenuEntity>().menuPortions;
                }
                final cacheMenuEntity = serviceLocator<MenuEntity>().copyWith();
              },
            ),
            const AnimatedGap(4, duration: Duration(milliseconds: 500)),
            AppTextFieldWidget(
              controller: discountPriceOfMenuTextEditingController,
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Discount Price',
                hintText: 'Enter menu discount price',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                isDense: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter menu discount price';
                } else {
                  return null;
                }
              },
              onSaved: (newValue) {
                if (widget.hasCustomPortion) {
                  final cacheCustomPortion = serviceLocator<MenuEntity>().customPortion;
                  if (cacheCustomPortion != null) {}
                } else {
                  final cacheMenuPortion = serviceLocator<MenuEntity>().menuPortions;
                }
                final cacheMenuEntity = serviceLocator<MenuEntity>().copyWith();
              },
            ),
            const AnimatedGap(4, duration: Duration(milliseconds: 500)),
            Divider(),
          ],
        ),
      ),
    );
  }
}
