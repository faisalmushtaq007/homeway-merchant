import 'package:flutter/material.dart';
import 'package:homemakers_merchant/app/features/store/domain/entities/store_entity.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';

class MultiSelectAvailableFoodTypeFormField extends FormField<List<StoreAvailableFoodTypes>> {
  final Widget title;
  final Widget hintWidget;
  final bool required;
  final String errorText;

  //final List? dataSource;
  final List<StoreAvailableFoodTypes> availableFoodTypesList;
  final List<StoreAvailableFoodTypes> initialSelectedAvailableFoodTypesList;
  final Function(List<StoreAvailableFoodTypes>) onSelectionChanged;
  final Function(List<StoreAvailableFoodTypes>)? onMaxSelected;
  final int? maxSelection;
  final String? textField;
  final String? valueField;
  final ValueChanged<List<StoreAvailableFoodTypes>>? onChanged;
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

  MultiSelectAvailableFoodTypeFormField({
    FormFieldSetter<List<StoreAvailableFoodTypes>>? onSaved,
    FormFieldValidator<List<StoreAvailableFoodTypes>>? validator,
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
    required this.availableFoodTypesList,
    this.onMaxSelected,
    this.maxSelection,
    this.initialSelectedAvailableFoodTypesList = const [],
    this.isSingleSelect = false,
    super.key,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialSelectedAvailableFoodTypesList.toList(),
          autovalidateMode: autovalidate,
          builder: (FormFieldState<List<StoreAvailableFoodTypes>> state) {
            // String selectedChoice = "";
            List<StoreAvailableFoodTypes> selectedChoices = [];
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
              child: MultiSelectStoreAvailableFoodTypes(
                onSelectionChanged: (List<StoreAvailableFoodTypes> selectedItems) {
                  selectedChoices = selectedItems.toList();
                  onSelectionChanged?.call(selectedChoices);
                  state.didChange(selectedChoices);
                  if (onChanged != null) {
                    onChanged(selectedChoices);
                  }
                  state.save();
                },
                availableFoodTypesList: availableFoodTypesList.toList(),
                initialSelectedAvailableFoodTypesList: initialSelectedAvailableFoodTypesList.toList(),
                maxSelection: maxSelection,
                onMaxSelected: onMaxSelected,
                isSingleSelect: isSingleSelect,
              ),
            );
          },
        );
}

class MultiSelectStoreAvailableFoodTypes extends StatefulWidget {
  const MultiSelectStoreAvailableFoodTypes({
    required this.onSelectionChanged,
    required this.availableFoodTypesList,
    this.onMaxSelected,
    this.maxSelection,
    super.key,
    this.initialSelectedAvailableFoodTypesList = const [],
    this.isSingleSelect = false,
  });

  final List<StoreAvailableFoodTypes> availableFoodTypesList;
  final List<StoreAvailableFoodTypes> initialSelectedAvailableFoodTypesList;
  final Function(List<StoreAvailableFoodTypes>) onSelectionChanged;
  final Function(List<StoreAvailableFoodTypes>)? onMaxSelected;
  final int? maxSelection;

  /// Enable single choice
  final bool isSingleSelect;

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectStoreAvailableFoodTypes> {
  // String selectedChoice = "";
  List<StoreAvailableFoodTypes> selectedChoices = [];

  List<Widget> _buildChoiceList() {
    List<Widget> choices = [];

    for (var item in widget.availableFoodTypesList) {
      choices.add(ChoiceChip(
        label: Text(
          item.title,
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
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 0,
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      children: _buildChoiceList(),
    );
  }
}
