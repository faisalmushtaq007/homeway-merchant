part of 'package:homemakers_merchant/app/features/payment/index.dart';

class WithdrawalPage extends StatefulWidget {
  const WithdrawalPage({super.key});

  @override
  _WithdrawalPageController createState() => _WithdrawalPageController();
}

class _WithdrawalPageController extends State<WithdrawalPage> {
  late final ScrollController scrollController;
  late final ScrollController customScrollViewScrollController;
  int withdrawalAmount = 10;
  final kAmounts = <String>['50', '100', '250', '500'];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    customScrollViewScrollController = ScrollController();
  }

  void updateWithdrawalAmount(int amount) {
    withdrawalAmount = amount;
    setState(() {});
  }

  @override
  void dispose() {
    scrollController.dispose();
    customScrollViewScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _WithdrawalPageView(this);
}

class _WithdrawalPageView extends WidgetView<WithdrawalPage, _WithdrawalPageController> {
  const _WithdrawalPageView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        useDivider: false,
        opacity: 0.60,
        noAppBar: true,
      ),
      child: Directionality(
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Withdrawal'),
            centerTitle: false,
            titleSpacing: 0,
            actions: [
              IconButton(
                onPressed: () async {
                  final notification = await context.push(Routes.NOTIFICATIONS);
                  return;
                },
                icon: Badge(
                  alignment: AlignmentDirectional.topEnd,
                  //padding: EdgeInsets.all(4),
                  backgroundColor: context.colorScheme.secondary,
                  isLabelVisible: true,
                  largeSize: 16,
                  textStyle: const TextStyle(fontSize: 14),
                  textColor: Colors.yellow,
                  label: Text(
                    '10',
                    style: context.labelSmall!.copyWith(color: context.colorScheme.onPrimary),
                    //Color.fromRGBO(251, 219, 11, 1)
                  ),
                  child: Icon(Icons.notifications, color: context.colorScheme.primary),
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.only(end: 8),
                child: LanguageSelectionWidget(),
              ),
            ],
          ),
          /*drawer: const PrimaryDashboardDrawer(
            key: const Key('withdrawal-page-drawer'),
            isMainDrawerPage: false,
          ),*/
          body: FadeInDown(
            key: const Key('withdrawal-page-slideinleft-widget'),
            from: context.width / 2 - 60,
            duration: const Duration(milliseconds: 500),
            child: Directionality(
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
              child: PageBody(
                controller: state.scrollController,
                constraints: BoxConstraints(
                  minWidth: 1000,
                  minHeight: media.size.height - (media.padding.top + kToolbarHeight + media.padding.bottom),
                ),
                padding: EdgeInsetsDirectional.only(
                  top: topPadding,
                  //bottom: bottomPadding,
                  start: margins * 2.5,
                  end: margins * 2.5,
                ),
                child: CustomScrollView(
                  controller: state.customScrollViewScrollController,
                  shrinkWrap: true,
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          const AnimatedGap(6, duration: Duration(milliseconds: 200)),
                          WalletAccountSummaryWidget(
                            key: const Key('withdrawal-account-summary-widget'),
                          ),
                          const AnimatedGap(16, duration: Duration(milliseconds: 200)),
                          Wrap(
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 12,
                                ),
                                child: Text(
                                  'How much would you like to withdrawal',
                                  style: context.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                  softWrap: true,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                ),
                              ),
                            ],
                          ),
                          const AnimatedGap(8, duration: Duration(milliseconds: 200)),
                          StatefulBuilder(
                            builder: (context, setState) {
                              return _buildAmountSection(context);
                            },
                          ),
                          const AnimatedGap(16, duration: Duration(milliseconds: 200)),
                        ],
                      ),
                    ),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        children: [
                          Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    side: const BorderSide(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                    ),
                                  ),
                                  onPressed: () async {},
                                  child: Text(
                                    'Cancel',
                                    style: const TextStyle(color: Color.fromRGBO(42, 45, 50, 1)),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  ).translate(),
                                ),
                              ),
                              const AnimatedGap(
                                8,
                                duration: Duration(milliseconds: 100),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: context.colorScheme.primary,
                                  ),
                                  onPressed: () async {
                                    final result = await confirmWithdrawal(
                                      context,
                                      state.withdrawalAmount,
                                      1900,
                                    );
                                    if (result != null) {
                                      if (result == true) {
                                        const snackBar = SnackBar(
                                          content: Text('Your withdrawal request is 20001728. This is already shared in your phone and email.'),
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        await Future.delayed(const Duration(seconds: 5), () {});
                                        final confirmation = await confirmationForInitiateWithdrawal(
                                          context,
                                          state.withdrawalAmount,
                                          1900,
                                        );
                                      } else {}
                                    }
                                  },
                                  child: Text(
                                    'Withdrawal',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  ).translate(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAmountSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 16, end: 16, top: 12, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  state.updateWithdrawalAmount(--state.withdrawalAmount);
                },
                icon: CircleAvatar(
                  child: Icon(FontAwesomeIcons.minus),
                  backgroundColor: '#D4E5ED'.toColor,
                ),
              ),
              Text(
                '${state.withdrawalAmount} SAR',
                style: context.headlineMedium!.copyWith(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                onPressed: () {
                  state.updateWithdrawalAmount(++state.withdrawalAmount);
                  return;
                },
                icon: CircleAvatar(
                  child: Icon(FontAwesomeIcons.plus),
                  backgroundColor: '#D4E5ED'.toColor,
                ),
              ),
            ],
          ),
          const AnimatedGap(12, duration: Duration(milliseconds: 200)),
          Slider(
            value: state.withdrawalAmount.toDouble(),
            onChanged: (newValue) {
              state.updateWithdrawalAmount(newValue.toInt());
              return;
            },
            min: 10,
            max: 5000,
          ),
          const AnimatedGap(12, duration: Duration(milliseconds: 200)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: state.kAmounts.map((amount) {
              return OutlinedButton(
                child: Text(amount),
                onPressed: () {
                  state.updateWithdrawalAmount(int.parse(amount));
                  //state.updateWithdrawalAmount((state.withdrawalAmount + int.parse(amount)));
                  return;
                },
              );
            }).toList(),
          ),
          Divider(),
        ],
      ),
    );
  }

  Future<bool?> confirmWithdrawal(BuildContext context, int amount, int mainBalance) async {
    final bool? status = await showConfirmationDialog<bool>(
      context: context,
      barrierDismissible: true,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 700),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return ResponsiveDialog(
              context: context,
              hideButtons: false,
              maxLongSide: context.height / 2.5,
              maxShortSide: context.width,
              key: const Key('withdrawal-request-dialog'),
              title: 'Confirm Withdrawal?',
              confirmText: 'Confirm',
              cancelText: 'Cancel',
              okPressed: () async {
                debugPrint('Dialog confirmed');
                Navigator.of(context).pop(true);
              },
              cancelPressed: () {
                debugPrint('Dialog cancelled');
                Navigator.of(context).pop(false);
              },
              child: SingleChildScrollView(
                child: Column(
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: '',
                        style: context.labelMedium,
                        children: <TextSpan>[
                          TextSpan(
                            text: '\nPlease review your withdraw amount and details.\n',
                            style: context.labelMedium,
                          ),
                        ],
                      ),
                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                    ),
                    Card(
                      margin: EdgeInsetsDirectional.only(top: 6, bottom: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(2),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            //crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RowItem.text(
                                'Balance',
                                '${mainBalance} SAR',
                                titleStyle: TextStyle(color: '#004e89'.toColor),
                                descriptionStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const AnimatedGap(12, duration: Duration(milliseconds: 200)),
                              RowItem.text(
                                'Withdrawal',
                                '${amount} SAR',
                                titleStyle: TextStyle(color: '#f95738'.toColor),
                                descriptionStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]),
                      ),
                    ),
                    const AnimatedGap(18, duration: Duration(milliseconds: 200)),
                    Wrap(
                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                      children: [
                        Text(
                          'Please note the withdrawal process is not initiated now, it may take time to upto 3 to 4 hours working business day and time to transfer to amount to your bank or payment.',
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          style: context.bodySmall!.copyWith(
                            fontSize: 11,
                          ),
                        )
                      ],
                    )
                    //textDirection: serviceLocator<LanguageController>().targetTextDirection,
                  ],
                ),
              ),
            );
          },
        );
      },
    );
    if (status != null) {
      return status;
    }
    return false;
  }

  Future<bool?> confirmationForInitiateWithdrawal(BuildContext context, int amount, int mainBalance) async {
    final bool? status = await showConfirmationDialog<bool>(
      context: context,
      barrierDismissible: true,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 700),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return ResponsiveDialog(
              context: context,
              hideButtons: false,
              maxLongSide: context.height / 2.9,
              maxShortSide: context.width,
              key: const Key('withdrawal-confirmation-dialog'),
              title: 'Withdrawal Processed',
              confirmText: 'OK',
              cancelText: 'Cancel',
              okPressed: () async {
                debugPrint('Dialog confirmed');
                Navigator.of(context).pop(true);
              },
              cancelPressed: () {
                debugPrint('Dialog cancelled');
                Navigator.of(context).pop(false);
              },
              child: SingleChildScrollView(
                child: Column(
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: '',
                        style: context.labelMedium,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Hi,\n\n',
                            style: context.labelMedium!.copyWith(fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: 'Your withdrawal request 20001728 has been successfully processed and a total amount of ',
                            style: context.labelMedium,
                          ),
                          TextSpan(
                            text: '${amount} SAR',
                            style: context.labelMedium!.copyWith(fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text:
                                ' has been withdrawal from your HomeMakers open account. Your funds will be delivered as indicated on your withdrawal request.',
                            style: context.labelMedium,
                          ),
                        ],
                      ),
                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                    ),
                    //textDirection: serviceLocator<LanguageController>().targetTextDirection,
                  ],
                ),
              ),
            );
          },
        );
      },
    );
    if (status != null) {
      return status;
    }
    return false;
  }
}
