part of 'package:homemakers_merchant/app/features/menu/index.dart';

class SetAddonsPriceWidget extends StatefulWidget {
  const SetAddonsPriceWidget({
    super.key,
    required this.addons,
    required this.currentIndex,
    required this.listOfAddons,
  });

  final Addons addons;
  final int currentIndex;
  final List<Addons> listOfAddons;

  @override
  _SetAddonsPriceWidgetState createState() => _SetAddonsPriceWidgetState();
}

class _SetAddonsPriceWidgetState extends State<SetAddonsPriceWidget> {
  final TextEditingController maximumRetailPriceOfMenuTextEditingController =
      TextEditingController(text: '00.00');
  String portionName = '';
  String sellingMaxRetailPrice = '00.00';
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    portionName = '${widget.addons.title ?? ''} ${widget.addons.unit ?? ''}';
    maximumRetailPriceOfMenuTextEditingController.text =
        widget.addons.defaultPrice.toString() ?? '00.00';
    sellingMaxRetailPrice =
        maximumRetailPriceOfMenuTextEditingController.value.text.trim();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
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
            textDirection:
                serviceLocator<LanguageController>().targetTextDirection,
            children: [
              Wrap(
                textDirection:
                    serviceLocator<LanguageController>().targetTextDirection,
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    '$portionName',
                    style: context.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(42, 45, 50, 1.0),
                    ),
                    textDirection: serviceLocator<LanguageController>()
                        .targetTextDirection,
                  ).translate(),
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
                textDirection:
                    serviceLocator<LanguageController>().targetTextDirection,
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^(\d+)?\.?\d{0,2}'),
                  ),
                ],
                keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                  setAddonsMaxRetailPriceFunction(context, value);
                  setState(() {});
                },
                onSaved: (newValue) {
                  setAddonsMaxRetailPriceFunction(
                      context,
                      maximumRetailPriceOfMenuTextEditingController.value.text
                          .trim());
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
    widget.listOfAddons[widget.currentIndex].defaultPrice =
        double.tryParse(newValue) ?? 0.0;
    serviceLocator<MenuEntity>()
        .addons[widget.currentIndex]
        .defaultPrice = double.tryParse(
            maximumRetailPriceOfMenuTextEditingController.value.text.trim()) ??
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
