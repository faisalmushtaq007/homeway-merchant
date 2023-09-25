part of 'package:homemakers_merchant/app/features/menu/index.dart';

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
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: CheckboxListTile(
        title: Wrap(
          children: [
            Text(addonsEntity.title,maxLines: 2,overflow: TextOverflow.ellipsis,softWrap: true,style: context.titleMedium!.copyWith(),).translate(),
          ],
        ),
        subtitle: Wrap(
          children: [
            Text('${addonsEntity.quantity} ${addonsEntity.unit} | ${addonsEntity.defaultPrice} ${addonsEntity.currency}',maxLines: 2,overflow: TextOverflow.ellipsis,softWrap: true,style: context.labelMedium!.copyWith(),),
          ],
        ),
        controlAffinity: ListTileControlAffinity.leading,
        value: widget.selectedAllAddons.contains(addonsEntity),
        onChanged: widget.onChangedAddons,
      ),
    );
  }
}
