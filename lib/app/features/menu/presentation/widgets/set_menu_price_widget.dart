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
  TextEditingController maximumRetailPriceOfMenuTextEditingController = TextEditingController(text: '00.00');
  TextEditingController discountPriceOfMenuTextEditingController = TextEditingController(text: '00.00');
  String portionName = '';
  String sellingMaxRetailPrice = '00.00';
  String sellingDiscountPrice = '00.00';
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.hasCustomPortion && widget.customPortion != null) {
      portionName = '${widget.customPortion?.title ?? ''} ${widget.customPortion?.unit ?? ''}';
      maximumRetailPriceOfMenuTextEditingController.text = widget.customPortion?.defaultPrice.toString() ?? '00.00';
      discountPriceOfMenuTextEditingController.text = widget.customPortion?.discountedPrice.toString() ?? '00.00';
      sellingMaxRetailPrice = maximumRetailPriceOfMenuTextEditingController.value.text.trim();
      sellingDiscountPrice = discountPriceOfMenuTextEditingController.value.text.trim();
    } else {
      if (widget.menuPortion != null) {
        portionName = '${widget.menuPortion?.title ?? ''} ${widget.menuPortion?.unit ?? ''}';
        maximumRetailPriceOfMenuTextEditingController.text = widget.menuPortion?.defaultPrice.toString() ?? '00.00';
        discountPriceOfMenuTextEditingController.text = widget.menuPortion?.discountedPrice.toString() ?? '00.00';
        sellingMaxRetailPrice = maximumRetailPriceOfMenuTextEditingController.value.text.trim();
        sellingDiscountPrice = discountPriceOfMenuTextEditingController.value.text.trim();
      }
    }
  }

  @override
  void dispose() {
    maximumRetailPriceOfMenuTextEditingController.text = '';
    discountPriceOfMenuTextEditingController.text = '';
    maximumRetailPriceOfMenuTextEditingController.dispose();
    discountPriceOfMenuTextEditingController.dispose();
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
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
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
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
                        '$portionName',
                        style: context.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(42, 45, 50, 1.0),
                        ),
                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                      ).translate(),
                    ),
                  ),
                  Directionality(
                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                    child: RichText(
                      text: TextSpan(
                        style: context.bodyMedium!.copyWith(),
                        children: <TextSpan>[
                          /*TextSpan(
                            text: 'Selling price ',
                            style: context.labelMedium!.copyWith(),
                          ),*/
                          TextSpan(
                            text: 'SAR ${sellingMaxRetailPrice}',
                            style: context.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Base Price',
                  hintText: '00.00',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  isDense: true,
                  suffixText: 'SAR',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter menu base price';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  sellingMaxRetailPrice = value;
                  setMaxRetailPriceFunction(context, value);
                  setState(() {});
                },
                onSaved: (newValue) {
                  setMaxRetailPriceFunction(context, maximumRetailPriceOfMenuTextEditingController.value.text.trim());
                  return;
                },
              ),
              const AnimatedGap(12, duration: Duration(milliseconds: 500)),
              AppTextFieldWidget(
                controller: discountPriceOfMenuTextEditingController,
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^(\d+)?\.?\d{0,2}'),
                  ),
                ],
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Discount Price',
                  hintText: '00.00',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  isDense: true,
                  suffixText: 'SAR',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter menu discount price';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  sellingDiscountPrice = value;
                  setDiscountPriceFunction(context, value);
                  setState(() {});
                },
                onSaved: (newValue) {
                  setDiscountPriceFunction(context, discountPriceOfMenuTextEditingController.value.text.trim());
                  return;
                },
              ),
              //const AnimatedGap(8, duration: Duration(milliseconds: 500)),
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

  void setMaxRetailPriceFunction(BuildContext context, String newValue) {
    if (widget.hasCustomPortion) {
      final cacheCustomPortion = serviceLocator<MenuEntity>().customPortion;
      if (cacheCustomPortion != null) {
        // copy value
        serviceLocator<MenuEntity>().customPortion?.copyWith(
              defaultPrice: double.tryParse(newValue) ?? 0.0,
            );
        context.read<MenuBloc>().add(
              PushMenuEntityData(
                menuEntity: serviceLocator<MenuEntity>(),
                menuFormStage: MenuFormStage.form4,
                menuEntityStatus: MenuEntityStatus.push,
              ),
            );
      } else {
        // new value
        serviceLocator<MenuEntity>().customPortion?.defaultPrice = double.tryParse(newValue) ?? 0.0;
        context.read<MenuBloc>().add(
              PushMenuEntityData(
                menuEntity: serviceLocator<MenuEntity>(),
                menuFormStage: MenuFormStage.form4,
                menuEntityStatus: MenuEntityStatus.push,
              ),
            );
      }
    } else {
      final cacheMenuPortion = serviceLocator<MenuEntity>().menuPortions;
      widget.menuPortion?.defaultPrice = double.tryParse(newValue) ?? 0.0;
      if (widget.currentIndex != null) {
        widget.listOfMenuPortions[widget.currentIndex!].defaultPrice = double.tryParse(newValue) ?? 0.0;
        serviceLocator<MenuEntity>().menuPortions[widget.currentIndex!].defaultPrice =
            double.tryParse(maximumRetailPriceOfMenuTextEditingController.value.text.trim()) ?? 0.0;
        context.read<MenuBloc>().add(
              PushMenuEntityData(
                menuEntity: serviceLocator<MenuEntity>(),
                menuFormStage: MenuFormStage.form4,
                menuEntityStatus: MenuEntityStatus.push,
              ),
            );
      }
    }
    return;
  }

  void setDiscountPriceFunction(BuildContext context, String newValue) {
    if (widget.hasCustomPortion) {
      final cacheCustomPortion = serviceLocator<MenuEntity>().customPortion;
      if (cacheCustomPortion != null) {
        // copy value
        serviceLocator<MenuEntity>().customPortion?.copyWith(
              discountedPrice: double.tryParse(newValue) ?? 0.0,
            );
        context.read<MenuBloc>().add(
              PushMenuEntityData(
                menuEntity: serviceLocator<MenuEntity>(),
                menuFormStage: MenuFormStage.form4,
                menuEntityStatus: MenuEntityStatus.push,
              ),
            );
      } else {
        // new value
        serviceLocator<MenuEntity>().customPortion?.discountedPrice = double.tryParse(newValue) ?? 0.0;
        context.read<MenuBloc>().add(
              PushMenuEntityData(
                menuEntity: serviceLocator<MenuEntity>(),
                menuFormStage: MenuFormStage.form4,
                menuEntityStatus: MenuEntityStatus.push,
              ),
            );
      }
    } else {
      final cacheMenuPortion = serviceLocator<MenuEntity>().menuPortions;
      widget.menuPortion?.discountedPrice = double.tryParse(newValue) ?? 0.0;
      if (widget.currentIndex != null) {
        widget.listOfMenuPortions[widget.currentIndex!].discountedPrice = double.tryParse(newValue) ?? 0.0;
        serviceLocator<MenuEntity>().menuPortions[widget.currentIndex!].discountedPrice =
            double.tryParse(maximumRetailPriceOfMenuTextEditingController.value.text.trim()) ?? 0.0;
        context.read<MenuBloc>().add(
              PushMenuEntityData(
                menuEntity: serviceLocator<MenuEntity>(),
                menuFormStage: MenuFormStage.form4,
                menuEntityStatus: MenuEntityStatus.push,
              ),
            );
      }
    }
    return;
  }
}
