import 'package:flutter/material.dart';
import 'package:homemakers_merchant/app/features/menu/domain/entities/menu_entity.dart';
import 'package:homemakers_merchant/app/features/store/domain/entities/store_entity.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';

class MultiSelectTasteLevelFormField extends FormField<List<TasteLevel>> {
  final Widget title;
  final Widget hintWidget;
  final bool required;
  final String errorText;

  //final List? dataSource;
  final List<TasteLevel> availableTasteLevelList;
  final List<TasteLevel> initialSelectedTasteLevelList;
  final Function(List<TasteLevel>) onSelectionChanged;
  final Function(List<TasteLevel>)? onMaxSelected;
  final int? maxSelection;
  final String? textField;
  final String? valueField;
  final ValueChanged<List<TasteLevel>>? onChanged;
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

  MultiSelectTasteLevelFormField({
    FormFieldSetter<List<TasteLevel>>? onSaved,
    FormFieldValidator<List<TasteLevel>>? validator,
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
    required this.availableTasteLevelList,
    this.onMaxSelected,
    this.maxSelection,
    this.initialSelectedTasteLevelList = const [],
    super.key,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialSelectedTasteLevelList.toList(),
          autovalidateMode: autovalidate,
          builder: (FormFieldState<List<TasteLevel>> state) {
            // String selectedChoice = "";
            List<TasteLevel> selectedChoices = [];
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
              child: MultiSelectMenuTasteLevel(
                onSelectionChanged: (List<TasteLevel> selectedItems) {
                  selectedChoices = selectedItems.toList();
                  onSelectionChanged?.call(selectedChoices);
                  state.didChange(selectedChoices);
                  if (onChanged != null) {
                    onChanged(selectedChoices);
                  }
                  state.save();
                },
                availableTasteLevels: availableTasteLevelList.toList(),
                initialSelectedTasteLevelList: initialSelectedTasteLevelList.toList(),
              ),
            );
          },
        );
}

class MultiSelectMenuTasteLevel extends StatefulWidget {
  const MultiSelectMenuTasteLevel({
    required this.onSelectionChanged,
    required this.availableTasteLevels,
    this.onMaxSelected,
    this.maxSelection,
    super.key,
    this.initialSelectedTasteLevelList = const [],
  });

  final List<TasteLevel> availableTasteLevels;
  final Function(List<TasteLevel>) onSelectionChanged;
  final Function(List<TasteLevel>)? onMaxSelected;
  final List<TasteLevel> initialSelectedTasteLevelList;
  final int? maxSelection;

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectMenuTasteLevel> {
  // String selectedChoice = "";
  List<TasteLevel> selectedChoices = [];

  List<Widget> _buildChoiceList() {
    List<Widget> choices = [];

    for (var item in widget.availableTasteLevels) {
      choices.add(ChoiceChip(
        label: Text(
          item.title,
          textDirection: serviceLocator<LanguageController>().targetTextDirection,
        ),
        selected: selectedChoices.contains(item),
        onSelected: (selected) {
          if (selectedChoices.length == (widget.maxSelection ?? -1) && !selectedChoices.contains(item)) {
            widget.onMaxSelected?.call(selectedChoices);
          } else {
            setState(() {
              selectedChoices.contains(item) ? selectedChoices.remove(item) : selectedChoices.add(item);
              widget.onSelectionChanged?.call(selectedChoices);
            });
          }
          /*setState(() {
            selectedChoices.contains(item) ? selectedChoices.remove(item) : selectedChoices.add(item);
            widget.onSelectionChanged(selectedChoices);
          });*/
        },
      ));
    }

    return choices;
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
