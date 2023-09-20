part of 'package:homemakers_merchant/app/features/analysis/index.dart';

class SwitchOrderAndSalesWidget extends StatelessWidget {
  const SwitchOrderAndSalesWidget({
    super.key,
    required this.leftLabel,
    required this.rightLabel,
    this.padding = EdgeInsetsDirectional.zero,
    required this.value,
    required this.onChanged,
  });

  final String leftLabel;
  final String rightLabel;
  final EdgeInsetsGeometry padding;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
        children: <Widget>[
          Flexible(
            child: Text(
              key: const Key('switch-left-text'),
              leftLabel,
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: context.bodyMedium!.copyWith(fontWeight: FontWeight.w600,),
            ).translate(),
          ),
          Switch(
            value: value,
            onChanged: (bool newValue) {
              onChanged(newValue);
            },
          ),
          Flexible(
            child: Text(
              key: const Key('switch-right-text'),
              rightLabel,
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: context.bodyMedium!.copyWith(fontWeight: FontWeight.w600,),
            ).translate(),
          ),
        ],
      ),
    );
  }
}
