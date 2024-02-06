part of 'package:homemakers_merchant/app/features/menu/index.dart';

class SetMenuPriceWidget extends StatefulWidget {
  const SetMenuPriceWidget({
    this.currentIndex = -1,
    super.key,
    this.customPortion,
    this.menuPortion,
    this.hasCustomPortion = false,
    this.listOfMenuPortions = const [],
    this.basePriceValueChanged,
    this.discountPriceValueChanged,
    this.hasGlobalMenuEntity = true,
    required this.menuEntity,
    this.menuEntityChanged,
  });

  final MenuPortion? menuPortion;
  final CustomPortion? customPortion;
  final bool hasCustomPortion;
  final int? currentIndex;
  final List<MenuPortion> listOfMenuPortions;
  final ValueChanged<double>? basePriceValueChanged;
  final ValueChanged<double>? discountPriceValueChanged;
  final bool hasGlobalMenuEntity;
  final MenuEntity menuEntity;
  final ValueChanged<MenuEntity>? menuEntityChanged;

  @override
  _SetMenuPriceWidgetState createState() => _SetMenuPriceWidgetState();
}

class _SetMenuPriceWidgetState extends State<SetMenuPriceWidget> {
  TextEditingController maximumRetailPriceOfMenuTextEditingController =
      TextEditingController(text: '00.00');
  TextEditingController discountPriceOfMenuTextEditingController =
      TextEditingController(text: '00.00');
  String portionName = '';
  String customPortionName = '';
  String sellingMaxRetailPrice = '00.00';
  String sellingDiscountPrice = '00.00';
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    portionName = '';
    customPortionName = '';
    sellingMaxRetailPrice = '00.00';
    sellingDiscountPrice = '00.00';
    maximumRetailPriceOfMenuTextEditingController.text = '';
    discountPriceOfMenuTextEditingController.text = '';
    super.initState();
    if (widget.hasCustomPortion && widget.customPortion != null) {
      portionName =
          '${widget.customPortion?.quantity ?? ''} ${widget.customPortion?.unit ?? ''}';
      customPortionName = widget.customPortion?.title ?? '';
      maximumRetailPriceOfMenuTextEditingController.text =
          widget.customPortion?.defaultPrice.toString() ?? '00.00';
      discountPriceOfMenuTextEditingController.text =
          widget.customPortion?.discountedPrice.toString() ?? '00.00';
      sellingMaxRetailPrice =
          maximumRetailPriceOfMenuTextEditingController.value.text.trim();
      sellingDiscountPrice =
          discountPriceOfMenuTextEditingController.value.text.trim();
    } else {
      if (widget.menuPortion != null) {
        portionName = widget.menuPortion?.title ?? '';
        maximumRetailPriceOfMenuTextEditingController.text =
            widget.menuPortion?.defaultPrice.toString() ?? '00.00';
        discountPriceOfMenuTextEditingController.text =
            widget.menuPortion?.discountedPrice.toString() ?? '00.00';
        sellingMaxRetailPrice =
            maximumRetailPriceOfMenuTextEditingController.value.text.trim();
        sellingDiscountPrice =
            discountPriceOfMenuTextEditingController.value.text.trim();
      }
    }
  }

  @override
  void dispose() {
    portionName = '';
    customPortionName = '';
    sellingMaxRetailPrice = '00.00';
    sellingDiscountPrice = '00.00';
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
            textDirection:
                serviceLocator<LanguageController>().targetTextDirection,
            children: [
              Wrap(
                textDirection:
                    serviceLocator<LanguageController>().targetTextDirection,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 5,
                spacing: 5,
                children: [
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 300),
                    crossFadeState: (widget.hasCustomPortion &&
                            widget.customPortion != null)
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: Row(
                      children: [
                        Text(
                          customPortionName,
                          style: context.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: const Color.fromRGBO(42, 45, 50, 1),
                          ),
                          textDirection: serviceLocator<LanguageController>()
                              .targetTextDirection,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ).translate(),
                        Card(
                          //key: const Key('custom-menu-portion-card'),
                          color: const Color.fromRGBO(188, 235, 208, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(20),
                            side: const BorderSide(
                              color: Color.fromRGBO(69, 201, 125, 1),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(
                              top: 8,
                              bottom: 8,
                              start: 16,
                              end: 16,
                            ),
                            child: Text(
                              portionName,
                              style: context.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: const Color.fromRGBO(42, 45, 50, 1),
                              ),
                              textDirection:
                                  serviceLocator<LanguageController>()
                                      .targetTextDirection,
                            ).translate(),
                          ),
                        ),
                      ],
                    ),
                    secondChild: Card(
                      //key: const Key('menu-portion-card'),
                      color: const Color.fromRGBO(188, 235, 208, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(20),
                        side: const BorderSide(
                          color: Color.fromRGBO(69, 201, 125, 1),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(
                          top: 8,
                          bottom: 8,
                          start: 16,
                          end: 16,
                        ),
                        child: Text(
                          portionName,
                          style: context.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: const Color.fromRGBO(42, 45, 50, 1),
                          ),
                          textDirection: serviceLocator<LanguageController>()
                              .targetTextDirection,
                        ).translate(),
                      ),
                    ),
                  ),
                ],
              ),
              const AnimatedGap(12, duration: Duration(milliseconds: 500)),
              AppTextFieldWidget(
                controller: maximumRetailPriceOfMenuTextEditingController,
                textDirection:
                    serviceLocator<LanguageController>().targetTextDirection,
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^(\d+)?\.?\d{0,2}'),
                  ),
                ],
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
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
                  if (widget.hasGlobalMenuEntity) {
                    setMaxRetailPriceFunction(context, value);
                  } else {
                    setCacheMenuEntityMaxRetailPriceFunction(context, value);
                  }
                  widget.basePriceValueChanged!(double.parse(value));
                  setState(() {});
                },
                onSaved: (newValue) {
                  setMaxRetailPriceFunction(
                      context,
                      maximumRetailPriceOfMenuTextEditingController.value.text
                          .trim());
                  return;
                },
              ),
              const AnimatedGap(12, duration: Duration(milliseconds: 500)),
              AppTextFieldWidget(
                controller: discountPriceOfMenuTextEditingController,
                textDirection:
                    serviceLocator<LanguageController>().targetTextDirection,
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^(\d+)?\.?\d{0,2}'),
                  ),
                ],
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
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
                  if (widget.hasGlobalMenuEntity) {
                    setDiscountPriceFunction(context, value);
                  } else {
                    setCacheMenuEntityDiscountPriceFunction(context, value);
                  }
                  widget.discountPriceValueChanged!(double.parse(value));
                  //setState(() {});
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
        serviceLocator<MenuEntity>().customPortion?.defaultPrice =
            double.tryParse(newValue) ?? 0.0;
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
        widget.listOfMenuPortions[widget.currentIndex!].defaultPrice =
            double.tryParse(newValue) ?? 0.0;
        serviceLocator<MenuEntity>()
            .menuPortions[widget.currentIndex!]
            .defaultPrice = double.tryParse(
                maximumRetailPriceOfMenuTextEditingController.value.text
                    .trim()) ??
            0.0;
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
        serviceLocator<MenuEntity>().customPortion?.discountedPrice =
            double.tryParse(newValue) ?? 0.0;
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
        widget.listOfMenuPortions[widget.currentIndex!].discountedPrice =
            double.tryParse(newValue) ?? 0.0;
        serviceLocator<MenuEntity>()
            .menuPortions[widget.currentIndex!]
            .discountedPrice = double.tryParse(
                maximumRetailPriceOfMenuTextEditingController.value.text
                    .trim()) ??
            0.0;
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

  void setCacheMenuEntityMaxRetailPriceFunction(
      BuildContext context, String newValue) {
    if (widget.hasCustomPortion) {
      final cacheCustomPortion = widget.menuEntity.customPortion;
      if (cacheCustomPortion != null) {
        // copy value
        widget.menuEntity.customPortion?.copyWith(
          defaultPrice: double.tryParse(newValue) ?? 0.0,
        );
        widget.menuEntityChanged!(widget.menuEntity.copyWith());
      } else {
        // new value
        widget.menuEntity.customPortion?.defaultPrice =
            double.tryParse(newValue) ?? 0.0;
        widget.menuEntityChanged!(widget.menuEntity.copyWith());
      }
    } else {
      final cacheMenuPortion = widget.menuEntity.menuPortions;
      widget.menuPortion?.defaultPrice = double.tryParse(newValue) ?? 0.0;
      if (widget.currentIndex != null) {
        widget.listOfMenuPortions[widget.currentIndex!].defaultPrice =
            double.tryParse(newValue) ?? 0.0;
        widget.menuEntity.menuPortions[widget.currentIndex!].defaultPrice =
            double.tryParse(maximumRetailPriceOfMenuTextEditingController
                    .value.text
                    .trim()) ??
                0.0;
        widget.menuEntityChanged!(widget.menuEntity.copyWith());
      }
    }
    //setState(() { });
    return;
  }

  void setCacheMenuEntityDiscountPriceFunction(
      BuildContext context, String newValue) {
    if (widget.hasCustomPortion) {
      final cacheCustomPortion = widget.menuEntity.customPortion;
      if (cacheCustomPortion != null) {
        // copy value
        widget.menuEntity.customPortion?.copyWith(
          discountedPrice: double.tryParse(newValue) ?? 0.0,
        );
        widget.menuEntityChanged!(widget.menuEntity.copyWith());
      } else {
        // new value
        widget.menuEntity.customPortion?.discountedPrice =
            double.tryParse(newValue) ?? 0.0;
        widget.menuEntityChanged!(widget.menuEntity.copyWith());
      }
    } else {
      final cacheMenuPortion = widget.menuEntity.menuPortions;
      widget.menuPortion?.discountedPrice = double.tryParse(newValue) ?? 0.0;
      if (widget.currentIndex != null) {
        widget.listOfMenuPortions[widget.currentIndex!].discountedPrice =
            double.tryParse(newValue) ?? 0.0;
        widget.menuEntity.menuPortions[widget.currentIndex!].discountedPrice =
            double.tryParse(maximumRetailPriceOfMenuTextEditingController
                    .value.text
                    .trim()) ??
                0.0;
        widget.menuEntityChanged!(widget.menuEntity.copyWith());
      }
    }
    //setState(() { });
    return;
  }
}
