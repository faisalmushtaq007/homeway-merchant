part of 'package:homemakers_merchant/app/features/store/index.dart';

class StoreOwnPartnerVehicleTypeFormField extends FormField<List<VehicleInfo>> {
  final Widget title;
  final Widget hintWidget;
  final bool required;
  final String errorText;

  //final List? dataSource;
  final List<VehicleInfo> availableVehicleInfoList;
  final List<VehicleInfo> initialVehicleInfoList;
  final Function(List<VehicleInfo>) onSelectionChanged;
  final Function(List<VehicleInfo>)? onMaxSelected;
  final int? maxSelection;
  final String? textField;
  final String? valueField;
  final ValueChanged<List<VehicleInfo>>? onChanged;
  final Function? open;
  final Function? close;
  final Widget? leading;
  final Widget? trailing;
  final String okButtonLabel;
  final String cancelButtonLabel;
  final Color? fillColor;
  final InputBorder? border;
  final TextStyle? chipLabelStyle;
  final Color? chipBackGroundColor;
  final TextStyle dialogTextStyle;
  final ShapeBorder dialogShapeBorder;
  final Color? checkBoxCheckColor;
  final Color? checkBoxActiveColor;
  final bool enabled;

  /// Enable single choice
  final bool isSingleSelect;

  StoreOwnPartnerVehicleTypeFormField({
    FormFieldSetter<List<VehicleInfo>>? onSaved,
    FormFieldValidator<List<VehicleInfo>>? validator,
    dynamic initialValue,
    AutovalidateMode autovalidate = AutovalidateMode.disabled,
    this.title = const Text('Title'),
    this.hintWidget = const Text('Tap to select one or more'),
    this.required = false,
    this.errorText = 'Please select one or more options',
    this.leading,
    //this.dataSource,
    this.textField,
    this.valueField,
    this.onChanged,
    this.open,
    this.close,
    this.okButtonLabel = 'OK',
    this.cancelButtonLabel = 'CANCEL',
    this.fillColor,
    this.border,
    this.trailing,
    this.chipLabelStyle,
    this.enabled = true,
    this.chipBackGroundColor,
    this.dialogTextStyle = const TextStyle(),
    this.dialogShapeBorder = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(0.0)),
    ),
    this.checkBoxActiveColor,
    this.checkBoxCheckColor,
    required this.onSelectionChanged,
    required this.availableVehicleInfoList,
    this.onMaxSelected,
    this.maxSelection,
    this.initialVehicleInfoList = const [],
    this.isSingleSelect = false,
    super.key,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialVehicleInfoList.toList(),
          autovalidateMode: autovalidate,
          builder: (FormFieldState<List<VehicleInfo>> state) {
            // String selectedChoice = "";
            List<VehicleInfo> selectedChoices = [];
            return InputDecorator(
              decoration: InputDecoration(
                //filled: true,
                errorText: state.hasError ? state.errorText : null,
                errorMaxLines: 1,
                fillColor: fillColor ?? Theme.of(state.context).canvasColor,
                border: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsetsDirectional.zero,
                errorBorder: InputBorder.none,
              ),
              isEmpty: state.value == null || state.value!.isEmpty,
              child: StoreOwnPartnerVehicleType(
                onSelectionChanged: (List<VehicleInfo> selectedItems) {
                  selectedChoices = selectedItems.toList();
                  onSelectionChanged?.call(selectedChoices);
                  state.didChange(selectedChoices);
                  if (onChanged != null) {
                    onChanged(selectedChoices);
                  }
                  state.save();
                },
                availableVehicleInfoList: availableVehicleInfoList.toList(),
                initialSelectedAvailableVehicleInfoList: initialVehicleInfoList.toList(),
                maxSelection: maxSelection,
                onMaxSelected: onMaxSelected,
                isSingleSelect: isSingleSelect,
              ),
            );
          },
        );
}

class StoreOwnPartnerVehicleType extends StatefulWidget {
  const StoreOwnPartnerVehicleType({
    required this.onSelectionChanged,
    required this.availableVehicleInfoList,
    this.onMaxSelected,
    this.maxSelection,
    this.initialSelectedAvailableVehicleInfoList = const [],
    super.key,
    this.isSingleSelect = false,
  });

  final List<VehicleInfo> availableVehicleInfoList;
  final Function(List<VehicleInfo>) onSelectionChanged;
  final Function(List<VehicleInfo>)? onMaxSelected;
  final List<VehicleInfo> initialSelectedAvailableVehicleInfoList;
  final int? maxSelection;

  /// Enable single choice
  final bool isSingleSelect;

  @override
  _StoreOwnPartnerVehicleTypeState createState() => _StoreOwnPartnerVehicleTypeState();
}

class _StoreOwnPartnerVehicleTypeState extends State<StoreOwnPartnerVehicleType> {
  // String selectedChoice = "";
  List<VehicleInfo> selectedChoices = [];

  List<Widget> _buildChoiceList() {
    List<Widget> choices = [];

    for (var item in widget.availableVehicleInfoList) {
      choices.add(ChoiceChip(
        avatar: ImageHelper(
          image: item.vehicleIconPath,
          filterQuality: FilterQuality.high,
          borderRadius: BorderRadiusDirectional.circular(4),
          imageType: findImageType(item.vehicleIconPath),
          imageShape: ImageShape.rectangle,
          boxFit: BoxFit.cover,
          defaultErrorBuilderColor: Colors.blueGrey,
          errorBuilder: const Icon(
            Icons.image_not_supported,
            size: 10000,
          ),
          loaderBuilder: const CircularProgressIndicator(),
          matchTextDirection: true,
        ),
        label: Text(
          item.vehicleType,
          textDirection: serviceLocator<LanguageController>().targetTextDirection,
        ),
        selected: selectedChoices.contains(item),
        onSelected: (selected) {
          if (widget.isSingleSelect) {
            setState(() {
              selectedChoices.clear();
              selectedChoices = [];
              selectedChoices.add(item);
              widget.onSelectionChanged?.call(selectedChoices);
            });
          } else {
            if (selectedChoices.length == (widget.maxSelection ?? -1) && !selectedChoices.contains(item)) {
              widget.onMaxSelected?.call(selectedChoices);
            } else {
              setState(() {
                selectedChoices.contains(item) ? selectedChoices.remove(item) : selectedChoices.add(item);
                widget.onSelectionChanged?.call(selectedChoices);
              });
            }
          }
        },
      ));
    }

    return choices;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 0,
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      children: _buildChoiceList(),
    );
  }
}
