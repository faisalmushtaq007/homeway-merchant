part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MultiSelectAddonsFormField extends FormField<List<Addons>> {
  MultiSelectAddonsFormField({
    FormFieldSetter<List<Addons>>? onSaved,
    FormFieldValidator<List<Addons>>? validator,
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
    required this.availableAddonsList,
    this.onMaxSelected,
    this.maxSelection,
    this.initialSelectedAddonsList = const [],
    super.key,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialSelectedAddonsList.toList(),
          autovalidateMode: autovalidate,
          builder: (FormFieldState<List<Addons>> state) {
            // String selectedChoice = "";
            List<Addons> selectedChoices = [];
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
              child: MultiSelectMenuAddons(
                onSelectionChanged: (List<Addons> selectedItems) {
                  selectedChoices = selectedItems.toList();
                  onSelectionChanged?.call(selectedChoices);
                  state.didChange(selectedChoices);
                  if (onChanged != null) {
                    onChanged(selectedChoices);
                  }
                  state.save();
                },
                availableAddonss: availableAddonsList.toList(),
                initialSelectedAddonsList: initialSelectedAddonsList.toList(),
                maxSelection: maxSelection,
                onMaxSelected: onMaxSelected,
              ),
            );
          },
        );
  final Widget title;
  final Widget hintWidget;
  final bool required;
  final String errorText;

  //final List? dataSource;
  final List<Addons> availableAddonsList;
  final List<Addons> initialSelectedAddonsList;
  final Function(List<Addons>) onSelectionChanged;
  final Function(List<Addons>)? onMaxSelected;
  final int? maxSelection;
  final String? textField;
  final String? valueField;
  final ValueChanged<List<Addons>>? onChanged;
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
}

class MultiSelectMenuAddons extends StatefulWidget {
  const MultiSelectMenuAddons({
    required this.onSelectionChanged,
    required this.availableAddonss,
    this.onMaxSelected,
    this.maxSelection,
    super.key,
    this.initialSelectedAddonsList = const [],
  });

  final List<Addons> availableAddonss;
  final Function(List<Addons>) onSelectionChanged;
  final Function(List<Addons>)? onMaxSelected;
  final List<Addons> initialSelectedAddonsList;
  final int? maxSelection;

  @override
  _MultiSelectAddonsChipState createState() => _MultiSelectAddonsChipState();
}

class _MultiSelectAddonsChipState extends State<MultiSelectMenuAddons> {
  // String selectedChoice = "";
  List<Addons> selectedChoices = [];

  List<Widget> _buildChoiceList() {
    return List<Widget>.generate(widget.availableAddonss.length, (int index) {
      return Chip(
        label: Text(
          widget.availableAddonss[index].title,
          textDirection: serviceLocator<LanguageController>().targetTextDirection,
        ),
        onDeleted: () {
          setState(() {
            widget.availableAddonss.removeAt(index);
            widget.onSelectionChanged?.call(widget.availableAddonss);
          });
        },
      );
    });
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
