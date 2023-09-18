part of 'package:homemakers_merchant/app/features/payment/index.dart';

class WalletAccountSummaryWidget extends StatefulWidget {
  const WalletAccountSummaryWidget({super.key});

  @override
  _WalletAccountSummaryWidgetController createState() => _WalletAccountSummaryWidgetController();
}

class _WalletAccountSummaryWidgetController extends State<WalletAccountSummaryWidget> {
  @override
  Widget build(BuildContext context) => _WalletAccountSummaryWidgetView(this);
}

class _WalletAccountSummaryWidgetView extends WidgetView<WalletAccountSummaryWidget, _WalletAccountSummaryWidgetController> {
  const _WalletAccountSummaryWidgetView(super.state);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      margin: EdgeInsetsDirectional.zero,
      child: DecoratedBox(
        decoration: MatrixDecoration(radius: Radius.circular(10), backgroundColor: '#ffc300'.toColor),
        child: Padding(
          padding: const EdgeInsetsDirectional.only(top: 12, bottom: 12, start: 12, end: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            textDirection: serviceLocator<LanguageController>().targetTextDirection,
            children: [
              Row(
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    size: 20,
                    color: '#004e89'.toColor,
                  ),
                  const AnimatedGap(6, duration: Duration(milliseconds: 200)),
                  Text(
                    'Total Balance',
                    style: context.headlineSmall!.copyWith(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: '#004e89'.toColor,
                    ),
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                  ).translate(),
                ],
              ),
              const AnimatedGap(2, duration: Duration(milliseconds: 200)),
              Text(
                '${1900} SAR',
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                style: context.headlineSmall!.copyWith(fontSize: 17, fontWeight: FontWeight.w500),
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ).translate(),
              const AnimatedGap(16, duration: Duration(milliseconds: 200)),
              Row(
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    key: const Key('wallet-summary-income-widget'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                      children: [
                        Row(
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.arrow_upward,
                              size: 22,
                              color: '#38b000'.toColor,
                            ),
                            const AnimatedGap(6, duration: Duration(milliseconds: 200)),
                            Text(
                              'Income',
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                              style: context.headlineSmall!.copyWith(
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                                color: '#38b000'.toColor,
                              ),
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ).translate()
                          ],
                        ),
                        const AnimatedGap(2, duration: Duration(milliseconds: 200)),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            start: 4,
                            end: 4,
                          ),
                          child: Text(
                            '${1700} SAR',
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            style: context.headlineSmall!.copyWith(fontSize: 17, fontWeight: FontWeight.w500),
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ).translate(),
                        )
                      ],
                    ),
                  ),
                  //const AnimatedGap(12, duration: Duration(milliseconds: 200)),
                  Expanded(
                    key: const Key('wallet-summary-withdrawl-widget'),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: 4,
                        end: 4,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                        children: [
                          Row(
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.arrow_downward,
                                size: 22,
                                color: '#f95738'.toColor,
                              ),
                              const AnimatedGap(6, duration: Duration(milliseconds: 200)),
                              Text(
                                'Transfer',
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                style: context.headlineSmall!.copyWith(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                  color: '#f95738'.toColor,
                                ),
                                maxLines: 1,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ).translate()
                            ],
                          ),
                          const AnimatedGap(2, duration: Duration(milliseconds: 200)),
                          Text(
                            '${200} SAR',
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            style: context.headlineSmall!.copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              //color: '#f95738'.toColor,
                            ),
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ).translate()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
