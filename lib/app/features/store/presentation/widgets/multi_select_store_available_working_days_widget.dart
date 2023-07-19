import 'package:flutter/material.dart';
import 'package:homemakers_merchant/app/features/store/domain/entities/store_entity.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';

class MultiSelectAvailableWorkingDaysFormField extends FormField<List<StoreWorkingDayAndTime>> {
  final Widget title;
  final Widget hintWidget;
  final bool required;
  final String errorText;

  //final List? dataSource;
  final List<StoreWorkingDayAndTime> availableWorkingDaysList;
  final List<StoreWorkingDayAndTime> initialSelectedAvailableWorkingDaysList;
  final Function(List<StoreWorkingDayAndTime>) onSelectionChanged;
  final Function(List<StoreWorkingDayAndTime>)? onMaxSelected;
  final int? maxSelection;
  final String? textField;
  final String? valueField;
  final ValueChanged<List<StoreWorkingDayAndTime>>? onChanged;
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

  MultiSelectAvailableWorkingDaysFormField({
    FormFieldSetter<List<StoreWorkingDayAndTime>>? onSaved,
    FormFieldValidator<List<StoreWorkingDayAndTime>>? validator,
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
    required this.availableWorkingDaysList,
    this.onMaxSelected,
    this.maxSelection,
    this.initialSelectedAvailableWorkingDaysList = const [],
    this.isSingleSelect = false,
    super.key,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialSelectedAvailableWorkingDaysList.toList(),
          autovalidateMode: autovalidate,
          builder: (FormFieldState<List<StoreWorkingDayAndTime>> state) {
            // String selectedChoice = "";
            List<StoreWorkingDayAndTime> selectedChoices = [];
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
              child: MultiSelectStoreAvailableWorkingDays(
                onSelectionChanged: (List<StoreWorkingDayAndTime> selectedItems) {
                  selectedChoices = selectedItems.toList();
                  onSelectionChanged?.call(selectedChoices);
                  state.didChange(selectedChoices);
                  if (onChanged != null) {
                    onChanged(selectedChoices);
                  }
                  state.save();
                },
                availableWorkingDayList: availableWorkingDaysList.toList(),
                initialSelectedAvailableWorkingDayList: initialSelectedAvailableWorkingDaysList.toList(),
                maxSelection: maxSelection,
                onMaxSelected: onMaxSelected,
                isSingleSelect: isSingleSelect,
              ),
            );
          },
        );
}

class MultiSelectStoreAvailableWorkingDays extends StatefulWidget {
  const MultiSelectStoreAvailableWorkingDays({
    required this.onSelectionChanged,
    required this.availableWorkingDayList,
    this.onMaxSelected,
    this.maxSelection,
    this.initialSelectedAvailableWorkingDayList = const [],
    super.key,
    this.isSingleSelect = false,
  });

  final List<StoreWorkingDayAndTime> availableWorkingDayList;
  final Function(List<StoreWorkingDayAndTime>) onSelectionChanged;
  final Function(List<StoreWorkingDayAndTime>)? onMaxSelected;
  final List<StoreWorkingDayAndTime> initialSelectedAvailableWorkingDayList;
  final int? maxSelection;

  /// Enable single choice
  final bool isSingleSelect;

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectStoreAvailableWorkingDays> {
  // String selectedChoice = "";
  List<StoreWorkingDayAndTime> selectedChoices = [];
  bool? _hasStoreOpenAllDays;

  void selectAllDays() {
    if (_hasStoreOpenAllDays != null && _hasStoreOpenAllDays == true) {
      selectedChoices = [];
      selectedChoices.clear();
      widget.availableWorkingDayList.asMap().forEach((key, value) {
        selectedChoices.add(value);
      });
    } else if (_hasStoreOpenAllDays == null || _hasStoreOpenAllDays == false) {
      selectedChoices = [];
      selectedChoices.clear();
    }
    widget.onSelectionChanged?.call(selectedChoices);
    setState(() {});
  }

  List<Widget> _buildChoiceList() {
    List<Widget> choices = [];

    for (var item in widget.availableWorkingDayList) {
      choices.add(ChoiceChip(
        label: Text(
          item.shortName,
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 0,
          textDirection: serviceLocator<LanguageController>().targetTextDirection,
          children: _buildChoiceList(),
        ),
        CheckboxListTile(
          value: _hasStoreOpenAllDays,
          controlAffinity: ListTileControlAffinity.leading,
          dense: true,
          contentPadding: EdgeInsetsDirectional.zero,
          visualDensity: VisualDensity(vertical: -4, horizontal: -4),
          isThreeLine: false,
          onChanged: (value) {
            _hasStoreOpenAllDays = value;
            selectAllDays();
            setState(() {});
          },
          tristate: true,
          title: Text(
            'All days',
            textDirection: serviceLocator<LanguageController>().targetTextDirection,
            style: context.titleSmall,
          ),
        ),
      ],
    );
  }
}
