import 'package:flutter/material.dart';
import 'package:homemakers_merchant/app/features/store/domain/entities/store_entity.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';

class MultiSelectStoreAvailableFoodPreparationTypes extends StatefulWidget {
  const MultiSelectStoreAvailableFoodPreparationTypes({
    required this.onSelectionChanged,
    required this.availableFoodPreparationTypesList,
    this.onMaxSelected,
    this.maxSelection,
    super.key,
  });

  final List<StoreAvailableFoodPreparationType> availableFoodPreparationTypesList;
  final Function(List<StoreAvailableFoodPreparationType>) onSelectionChanged;
  final Function(List<StoreAvailableFoodPreparationType>)? onMaxSelected;
  final int? maxSelection;

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectStoreAvailableFoodPreparationTypes> {
  // String selectedChoice = "";
  List<StoreAvailableFoodPreparationType> selectedChoices = [];

  List<Widget> _buildChoiceList() {
    List<Widget> choices = [];

    for (var item in widget.availableFoodPreparationTypesList) {
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
