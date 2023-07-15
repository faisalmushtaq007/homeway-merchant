import 'package:flutter/material.dart';
import 'package:homemakers_merchant/app/features/menu/domain/entities/menu_entity.dart';

class AddonsCard extends StatefulWidget {
  const AddonsCard({
    super.key,
    required this.addonsEntity,
    this.onChangedAddons,
    required this.selectedAllAddons,
    this.onSelectionChanged,
  });

  final Addons addonsEntity;
  final ValueChanged<bool?>? onChangedAddons;
  final List<Addons> selectedAllAddons;
  final Function(List<Addons>)? onSelectionChanged;

  @override
  _AddonsCardState createState() => _AddonsCardState();
}

class _AddonsCardState extends State<AddonsCard> {
  late Addons addonsEntity;

  @override
  void initState() {
    super.initState();
    addonsEntity = widget.addonsEntity;
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(addonsEntity.title),
      controlAffinity: ListTileControlAffinity.leading,
      value: widget.selectedAllAddons.contains(addonsEntity),
      onChanged: widget.onChangedAddons,
    );
  }
}
