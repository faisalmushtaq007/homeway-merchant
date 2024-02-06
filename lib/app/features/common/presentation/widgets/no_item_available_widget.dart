part of 'package:homemakers_merchant/app/features/common/index.dart';

class NoItemAvailableWidget extends StatelessWidget {
  const NoItemAvailableWidget(
      {super.key, this.textMessage, this.textMessageStyle});
  final String? textMessage;
  final TextStyle? textMessageStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            textMessage ?? 'No items available or added by you',
            style: textMessageStyle ?? context.labelLarge,
            textDirection:
                serviceLocator<LanguageController>().targetTextDirection,
          ).translate(),
        ),
      ],
    );
  }
}
