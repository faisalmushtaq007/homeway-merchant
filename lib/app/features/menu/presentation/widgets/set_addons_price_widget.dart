part of 'package:homemakers_merchant/app/features/menu/index.dart';

class SetAddonsPriceWidget extends StatefulWidget {
  const SetAddonsPriceWidget({
    super.key,
    required this.addons,
    required this.currentIndex,
    required this.listOfAddons,
    this.basePriceValueChanged,
    this.discountPriceValueChanged,
    this.hasGlobalMenuEntity = true,
    required this.menuEntity,
    this.menuEntityChanged,
  });

  final Addons addons;
  final int currentIndex;
  final List<Addons> listOfAddons;
  final ValueChanged<double>? basePriceValueChanged;
  final ValueChanged<double>? discountPriceValueChanged;
  final bool hasGlobalMenuEntity;
  final MenuEntity menuEntity;
  final ValueChanged<MenuEntity>? menuEntityChanged;

  @override
  _SetAddonsPriceWidgetState createState() => _SetAddonsPriceWidgetState();
}

class _SetAddonsPriceWidgetState extends State<SetAddonsPriceWidget> {
  final TextEditingController maximumRetailPriceOfMenuTextEditingController = TextEditingController(text: '00.00');
  String portionName = '';
  String addonsQuantityAndUnit = '';
  String sellingMaxRetailPrice = '00.00';
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    maximumRetailPriceOfMenuTextEditingController.text = '';
    portionName = '';
    addonsQuantityAndUnit = '';
    sellingMaxRetailPrice = '00.00';
    super.initState();
    portionName = widget.addons.title ?? '';
    addonsQuantityAndUnit = '${widget.addons.quantity ?? ''} ${widget.addons.unit ?? ''}';
    maximumRetailPriceOfMenuTextEditingController.text = widget.addons.defaultPrice.toString() ?? '00.00';
    sellingMaxRetailPrice = maximumRetailPriceOfMenuTextEditingController.value.text.trim();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    portionName = '';
    sellingMaxRetailPrice = '00.00';
    addonsQuantityAndUnit = '';
    maximumRetailPriceOfMenuTextEditingController.text = '';
    maximumRetailPriceOfMenuTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: SizedBox(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            textDirection: serviceLocator<LanguageController>().targetTextDirection,
            children: [
              Wrap(
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 5,
                spacing: 5,
                children: [
                  Text(
                    portionName,
                    style: context.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color.fromRGBO(42, 45, 50, 1),
                    ),
                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                  ).translate(),
                  Card(
                    color: const Color.fromRGBO(188, 235, 208, 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(20),
                      side: const BorderSide(
                        color: Color.fromRGBO(69, 201, 125, 1.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                        top: 8.0,
                        bottom: 8,
                        start: 16,
                        end: 16,
                      ),
                      child: Text(
                        addonsQuantityAndUnit,
                        style: context.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(42, 45, 50, 1.0),
                        ),
                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                      ).translate(),
                    ),
                  ),

                  /*Directionality(
                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                    child: RichText(
                      text: TextSpan(
                        style: context.bodyMedium!.copyWith(),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'SAR ${sellingMaxRetailPrice}',
                            style: context.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),*/
                ],
              ),
              const AnimatedGap(12, duration: Duration(milliseconds: 500)),
              AppTextFieldWidget(
                controller: maximumRetailPriceOfMenuTextEditingController,
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^(\d+)?\.?\d{0,2}'),
                  ),
                ],
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Price',
                  hintText: '00.00',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  isDense: true,
                  suffixText: 'SAR',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Price is required';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  sellingMaxRetailPrice = value;
                  if (widget.hasGlobalMenuEntity) {
                    setAddonsMaxRetailPriceFunction(context, value);
                  } else {
                    setCacheMenuAddonsMaxRetailPriceFunction(context, value);
                  }
                  widget.basePriceValueChanged!(double.parse(value));
                  setState(() {});
                },
                onSaved: (newValue) {
                  if (widget.hasGlobalMenuEntity) {
                    setAddonsMaxRetailPriceFunction(
                      context,
                      maximumRetailPriceOfMenuTextEditingController.value.text.trim(),
                    );
                  } else {
                    setCacheMenuAddonsMaxRetailPriceFunction(
                      context,
                      maximumRetailPriceOfMenuTextEditingController.value.text.trim(),
                    );
                  }
                  return;
                },
              ),
              const Divider(
                height: 26,
                thickness: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setAddonsMaxRetailPriceFunction(BuildContext context, String newValue) {
    debugPrint('Addons setMaxRetailPriceFunction ${newValue}');
    widget.addons.defaultPrice = double.tryParse(newValue) ?? 0.0;
    widget.listOfAddons[widget.currentIndex].defaultPrice = double.tryParse(newValue) ?? 0.0;
    serviceLocator<MenuEntity>().addons[widget.currentIndex].defaultPrice = double.tryParse(
          maximumRetailPriceOfMenuTextEditingController.value.text.trim(),
        ) ??
        0.0;
    context.read<MenuBloc>().add(
          PushMenuEntityData(
            menuEntity: serviceLocator<MenuEntity>(),
            menuFormStage: MenuFormStage.form4,
            menuEntityStatus: MenuEntityStatus.push,
          ),
        );
  }

  void setCacheMenuAddonsMaxRetailPriceFunction(BuildContext context, String newValue) {
    debugPrint('Addons setMaxRetailPriceFunction ${newValue}');
    widget.addons.defaultPrice = double.tryParse(newValue) ?? 0.0;
    widget.listOfAddons[widget.currentIndex].defaultPrice = double.tryParse(newValue) ?? 0.0;
    widget.menuEntity.addons[widget.currentIndex].defaultPrice = double.tryParse(
          maximumRetailPriceOfMenuTextEditingController.value.text.trim(),
        ) ??
        0.0;
    widget.menuEntityChanged!(widget.menuEntity.copyWith());
    //setState(() { });
  }
}
