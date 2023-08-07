part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuPriceInfoWidget extends StatelessWidget {
  const MenuPriceInfoWidget({
    super.key,
    required this.menuEntity,
    this.title = '',
    this.value = 0.0,
    this.currency = 'SAR',
  });
  final MenuEntity menuEntity;
  final String title;
  final double value;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: Card(
        child: ListTile(
          title: Text(title),
          trailing: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            textDirection: serviceLocator<LanguageController>().targetTextDirection,
            children: [
              Text(
                currency,
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
              ),
              Text(
                value.toString(),
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
