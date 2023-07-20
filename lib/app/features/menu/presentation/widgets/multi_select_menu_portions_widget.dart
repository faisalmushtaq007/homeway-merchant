part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MultiSelectMenuPortionFormField extends FormField<List<MenuPortion>> {
  final Widget title;
  final Widget hintWidget;
  final bool required;
  final String errorText;

  //final List? dataSource;
  final List<MenuPortion> availableMenuPortionList;
  final List<MenuPortion> initialSelectedMenuPortionList;
  final Function(List<MenuPortion>) onSelectionChanged;
  final Function(List<MenuPortion>)? onMaxSelected;
  final int? maxSelection;
  final String? textField;
  final String? valueField;
  final ValueChanged<List<MenuPortion>>? onChanged;
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

  MultiSelectMenuPortionFormField({
    FormFieldSetter<List<MenuPortion>>? onSaved,
    FormFieldValidator<List<MenuPortion>>? validator,
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
    required this.availableMenuPortionList,
    this.onMaxSelected,
    this.maxSelection,
    this.initialSelectedMenuPortionList = const [],
    this.isSingleSelect = false,
    super.key,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialSelectedMenuPortionList.toList(),
          autovalidateMode: autovalidate,
          builder: (FormFieldState<List<MenuPortion>> state) {
            // String selectedChoice = "";
            List<MenuPortion> selectedChoices = [];
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
              child: MultiSelectMenuMenuPortion(
                onSelectionChanged: (List<MenuPortion> selectedItems) {
                  selectedChoices = selectedItems.toList();
                  onSelectionChanged?.call(selectedChoices);
                  state.didChange(selectedChoices);
                  if (onChanged != null) {
                    onChanged(selectedChoices);
                  }
                  state.save();
                },
                availableMenuPortions: availableMenuPortionList.toList(),
                initialSelectedMenuPortionList: initialSelectedMenuPortionList.toList(),
                isSingleSelect: isSingleSelect,
                onMaxSelected: onMaxSelected,
                maxSelection: maxSelection,
              ),
            );
          },
        );
}

class MultiSelectMenuMenuPortion extends StatefulWidget {
  const MultiSelectMenuMenuPortion({
    required this.onSelectionChanged,
    required this.availableMenuPortions,
    this.onMaxSelected,
    this.maxSelection,
    super.key,
    this.initialSelectedMenuPortionList = const [],
    this.isSingleSelect = false,
  });

  final List<MenuPortion> availableMenuPortions;
  final Function(List<MenuPortion>) onSelectionChanged;
  final Function(List<MenuPortion>)? onMaxSelected;
  final List<MenuPortion> initialSelectedMenuPortionList;
  final int? maxSelection;

  /// Enable single choice
  final bool isSingleSelect;

  @override
  _MultiSelectPortionsChipState createState() => _MultiSelectPortionsChipState();
}

class _MultiSelectPortionsChipState extends State<MultiSelectMenuMenuPortion> {
  // String selectedChoice = "";
  List<MenuPortion> selectedChoices = [];

  List<Widget> _buildChoiceList() {
    List<Widget> choices = [];

    for (var item in widget.availableMenuPortions) {
      choices.add(
        ChoiceChip(
          label: Text(
            '${item.title} ${item.unit}',
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
                setState(() {
                  widget.onMaxSelected?.call(selectedChoices);
                });
              } else {
                setState(() {
                  selectedChoices.contains(item) ? selectedChoices.remove(item) : selectedChoices.add(item);
                  widget.onSelectionChanged?.call(selectedChoices);
                });
              }
            }
          },
        ),
      );
    }

    return choices;
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 0,
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      children: _buildChoiceList(),
    );
  }
}
