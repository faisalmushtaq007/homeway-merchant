part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MultiSelectTasteTypeFormField extends FormField<List<TasteType>> {
  MultiSelectTasteTypeFormField({
    FormFieldSetter<List<TasteType>>? onSaved,
    FormFieldValidator<List<TasteType>>? validator,
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
    required this.availableTasteTypeList,
    this.onMaxSelected,
    this.maxSelection,
    this.initialSelectedTasteTypeList = const [],
    this.isSingleSelect = false,
    super.key,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialSelectedTasteTypeList.toList(),
          autovalidateMode: autovalidate,
          builder: (FormFieldState<List<TasteType>> state) {
            // String selectedChoice = "";
            List<TasteType> selectedChoices = [];
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
              child: MultiSelectMenuTasteType(
                onSelectionChanged: (List<TasteType> selectedItems) {
                  selectedChoices = selectedItems.toList();
                  onSelectionChanged?.call(selectedChoices);
                  state.didChange(selectedChoices);
                  if (onChanged != null) {
                    onChanged(selectedChoices);
                  }
                  state.save();
                },
                availableTasteTypes: availableTasteTypeList.toList(),
                initialSelectedTasteTypeList:
                    initialSelectedTasteTypeList.toList(),
                maxSelection: maxSelection,
                onMaxSelected: onMaxSelected,
                isSingleSelect: isSingleSelect,
              ),
            );
          },
        );
  final Widget title;
  final Widget hintWidget;
  final bool required;
  final String errorText;

  //final List? dataSource;
  final List<TasteType> availableTasteTypeList;
  final List<TasteType> initialSelectedTasteTypeList;
  final Function(List<TasteType>) onSelectionChanged;
  final Function(List<TasteType>)? onMaxSelected;
  final int? maxSelection;
  final String? textField;
  final String? valueField;
  final ValueChanged<List<TasteType>>? onChanged;
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
}

class MultiSelectMenuTasteType extends StatefulWidget {
  const MultiSelectMenuTasteType({
    required this.onSelectionChanged,
    required this.availableTasteTypes,
    this.onMaxSelected,
    this.maxSelection,
    super.key,
    this.initialSelectedTasteTypeList = const [],
    this.isSingleSelect = false,
  });

  final List<TasteType> availableTasteTypes;
  final Function(List<TasteType>) onSelectionChanged;
  final Function(List<TasteType>)? onMaxSelected;
  final List<TasteType> initialSelectedTasteTypeList;
  final int? maxSelection;

  /// Enable single choice
  final bool isSingleSelect;

  @override
  _MultiSelectTasteTypeChipState createState() =>
      _MultiSelectTasteTypeChipState();
}

class _MultiSelectTasteTypeChipState extends State<MultiSelectMenuTasteType> {
  // String selectedChoice = "";
  List<TasteType> selectedChoices = [];

  List<Widget> _buildChoiceList() {
    List<Widget> choices = [];

    for (var item in widget.availableTasteTypes) {
      choices.add(ChoiceChip(
        label: Text(
          item.title,
          textDirection:
              serviceLocator<LanguageController>().targetTextDirection,
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
            if (selectedChoices.length == (widget.maxSelection ?? -1) &&
                !selectedChoices.contains(item)) {
              widget.onMaxSelected?.call(selectedChoices);
            } else {
              setState(() {
                selectedChoices.contains(item)
                    ? selectedChoices.remove(item)
                    : selectedChoices.add(item);
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
    selectedChoices =
        List<TasteType>.from(widget.initialSelectedTasteTypeList.toList());
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
