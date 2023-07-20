part of 'package:homemakers_merchant/app/features/menu/index.dart';

class SetAddonsPriceWidget extends StatefulWidget {
  const SetAddonsPriceWidget({
    super.key,
    required this.addons,
    required this.currentIndex,
  });
  final Addons addons;
  final int currentIndex;

  @override
  _SetAddonsPriceWidgetState createState() => _SetAddonsPriceWidgetState();
}

class _SetAddonsPriceWidgetState extends State<SetAddonsPriceWidget> {
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: Card(),
    );
  }
}
