part of 'package:homemakers_merchant/app/features/payment/index.dart';

class PaymentGatewayPage extends StatefulWidget {
  const PaymentGatewayPage({super.key});

  @override
  _PaymentGatewayPageController createState() => _PaymentGatewayPageController();
}

class _PaymentGatewayPageController extends State<PaymentGatewayPage> {
  late final ScrollController scrollController;
  late final ScrollController customScrollViewScrollController;
  int currentIndex = 0;
  final PageStorageBucket _transactionBucket = PageStorageBucket();
  List<Widget> transactionWidgets = [];
  // To store payment data
  dynamic lastResult;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    customScrollViewScrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    customScrollViewScrollController.dispose();
    super.dispose();
  }

  void updateCurrentIndex(int index) {
    currentIndex = index;
    setState(() {});
  }

  Future<String> makePayment() async {

    // To store payment data
    dynamic lastResult;


    try {

      // initiate payment
      return await UrWayPayment.makepaymentService(context: context,
          country: "SA",
          action: "1",
          currency: "SAR",
          amt: "2.00",
          customerEmail: "prasant10050@gmail.com",
          trackid: "111ABC",
          udf1: "",
          udf2: "",
          udf3: "",
          udf4: "",
          udf5: "",
          cardToken: "",
          address: "ABC",
          city: "ASANSOL",
          state: "WEST BENGAL",
          tokenizationType: "1",
          zipCode: "",
          tokenOperation: "A/U/D", metadata:"" );


      print('Result in Main is $lastResult');

    } on PlatformException {
      print('Failed payment');
      return 'Failed payment';
    }
  }

  @override
  Widget build(BuildContext context) => _PaymentGatewayPageView(this);
}

class _PaymentGatewayPageView
    extends WidgetView<PaymentGatewayPage, _PaymentGatewayPageController> {
  const _PaymentGatewayPageView(super.state);
  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding =
        margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
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
            title: const Text('Transaction'),
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
                    style: context.labelSmall!
                        .copyWith(color: context.colorScheme.onPrimary),
                    //Color.fromRGBO(251, 219, 11, 1)
                  ),
                  child: Icon(Icons.notifications,
                      color: context.colorScheme.primary),
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.only(end: 8),
                child: LanguageSelectionWidget(),
              ),
            ],
          ),
          /*drawer: const PrimaryDashboardDrawer(
            key: const Key('transaction-page-drawer'),
            isMainDrawerPage: false,
          ),*/
          body: FadeInDown(
            key: const Key('transaction-page-slideinleft-widget'),
            from: context.width / 2 - 60,
            duration: const Duration(milliseconds: 500),
            child: Directionality(
              textDirection:
              serviceLocator<LanguageController>().targetTextDirection,
              child: PageBody(
                controller: state.scrollController,
                constraints: BoxConstraints(
                  minWidth: 1000,
                  minHeight: media.size.height -
                      (media.padding.top +
                          kToolbarHeight +
                          media.padding.bottom),
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
                          const AnimatedGap(6,
                              duration: Duration(milliseconds: 200)),
                          AsyncBuilder<String>(
                            future: state.makePayment(),
                            waiting: (context) => Text('Loading...'),
                            builder: (context, value) => Text('$value'),
                            error: (context, error, stackTrace) => Text('Error! $error'),
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



