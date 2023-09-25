part of 'package:homemakers_merchant/app/features/common/index.dart';
class DataLoadingWidget extends StatelessWidget {
  const DataLoadingWidget({super.key,this.textMessage,this.textMessageStyle});
  final String? textMessage;
  final TextStyle? textMessageStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: CircularProgressIndicator(),
        ),
        const AnimatedGap(6, duration: Duration(milliseconds: 300)),
        Center(
          child: Text(
            textMessage??'Please wait while fetching result...',
            style: textMessageStyle??context.labelLarge,
            textDirection: serviceLocator<
                LanguageController>()
                .targetTextDirection,
          ).translate(),
        ),
      ],
    );
  }
}
