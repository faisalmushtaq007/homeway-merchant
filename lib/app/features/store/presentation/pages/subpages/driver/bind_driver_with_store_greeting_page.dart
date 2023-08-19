part of 'package:homemakers_merchant/app/features/store/index.dart';

class BindDriverWithStoreGreetingPage extends StatefulWidget {
  const BindDriverWithStoreGreetingPage({
    super.key,
    this.storeEntities = const [],
    this.storeOwnDeliveryPartnersEntities = const [],
    this.message = '',
    this.isRemoved = false,
  });
  final List<StoreOwnDeliveryPartnersInfo> storeOwnDeliveryPartnersEntities;
  final List<StoreEntity> storeEntities;
  final String message;
  final bool isRemoved;
  @override
  _BindDriverWithStoreGreetingPageController createState() => _BindDriverWithStoreGreetingPageController();
}

class _BindDriverWithStoreGreetingPageController extends State<BindDriverWithStoreGreetingPage> {
  late final ScrollController scrollController;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _BindDriverWithStoreGreetingPageView(this);
}

class _BindDriverWithStoreGreetingPageView extends WidgetView<BindDriverWithStoreGreetingPage, _BindDriverWithStoreGreetingPageController> {
  const _BindDriverWithStoreGreetingPageView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    final double bottomPadding = media.padding.bottom + margins;
    final double width = media.size.width;
    final ThemeData theme = Theme.of(context);
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
            actions: const [
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 14),
                child: LanguageSelectionWidget(),
              ),
            ],
          ),
          body: ZoomIn(
            key: const Key('bind-menu-with-store--greeting-page-zoomin-widget'),
            delay: const Duration(milliseconds: 500),
            child: PageBody(
              controller: state.scrollController,
              constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: media.size.height,
              ),
              padding: EdgeInsetsDirectional.only(
                top: topPadding,
                //bottom: bottomPadding,
                start: margins * 2.5,
                end: margins * 2.5,
              ),
              child: BlocBuilder<PermissionBloc, PermissionState>(
                bloc: context.read<PermissionBloc>(),
                buildWhen: (previous, current) => previous != current,
                builder: (context, permissionState) {
                  return Stack(
                    children: [
                      const Align(
                        alignment: AlignmentDirectional.topStart,
                        child: AppLogo(),
                      ),
                      ListView(
                        controller: state.scrollController,
                        padding: EdgeInsetsDirectional.only(
                          top: 50,
                        ),
                        children: [
                          // success logo
                          Lottie.asset(
                            'assets/lottie/success_check_mark.json',
                            height: 110,
                          ),
                          Center(
                            child: Text(
                              'Hurray!',
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                              textAlign: TextAlign.center,
                              style: context.headlineMedium!.copyWith(
                                color: const Color.fromRGBO(69, 201, 125, 1),
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ).translate(),
                          ),
                          const AnimatedGap(
                            50,
                            duration: Duration(
                              milliseconds: 300,
                            ),
                          ),
                          Center(
                            child: Wrap(
                              children: [
                                Text(
                                  '${widget.storeOwnDeliveryPartnersEntities.length} Drivers are successfully ${widget.isRemoved ? 'removed' : 'listed'} ${widget.isRemoved ? 'from' : 'with'} ${widget.storeEntities.length} stores',
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  textAlign: TextAlign.center,
                                  style: context.titleLarge!.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ).translate(),
                              ],
                            ),
                          ),

                          const AnimatedGap(
                            16,
                            duration: Duration(
                              milliseconds: 300,
                            ),
                          ),
                        ],
                      ),
                      PositionedDirectional(
                        bottom: kBottomNavigationBarHeight + bottomPadding + margins * 6.5,
                        start: 0,
                        end: 0,
                        child: Center(
                          child: Wrap(
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            children: [
                              Icon(Icons.share),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                'Share your store on social media',
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                textAlign: TextAlign.center,
                                style: context.titleMedium!.copyWith(
                                  fontSize: 18,
                                  color: Color.fromRGBO(127, 129, 132, 1),
                                ),
                              ).translate(),
                            ],
                          ),
                        ),
                      ),
                      PositionedDirectional(
                        bottom: bottomPadding,
                        start: 0,
                        end: 0,
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    side: const BorderSide(
                                      color: Color.fromRGBO(165, 166, 168, 1),
                                    ),
                                    backgroundColor: Colors.white,
                                  ),
                                  child: Text(
                                    'My Drivers',
                                    style: const TextStyle(color: Color.fromRGBO(42, 45, 50, 1)),
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  ).translate(),
                                  onPressed: () {
                                    context.pushReplacement(Routes.ALL_DRIVER_PAGE);
                                    return;
                                  },
                                ),
                              ),
                              const AnimatedGap(12, duration: Duration(milliseconds: 300)),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    side: const BorderSide(
                                      color: Color.fromRGBO(165, 166, 168, 1),
                                    ),
                                    backgroundColor: Colors.white,
                                  ),
                                  child: Text(
                                    'Dashboard',
                                    style: const TextStyle(color: Color.fromRGBO(42, 45, 50, 1)),
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  ).translate(),
                                  onPressed: () {
                                    context.pushReplacement(Routes.PRIMARY_DASHBOARD_PAGE);
                                    return;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      PositionedDirectional(
                        bottom: kBottomNavigationBarHeight - bottomPadding,
                        start: 0,
                        end: 0,
                        child: ElevatedButton(
                          child: Text(
                            'Add New Driver',
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          ).translate(),
                          onPressed: () {
                            context.pushReplacement(Routes.SAVE_DRIVER_PAGE, extra: {
                              'storeOwnDeliveryPartnersInfo': null,
                              'haveNewDriver': true,
                              'currentIndex': -1,
                            });
                            return;
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
