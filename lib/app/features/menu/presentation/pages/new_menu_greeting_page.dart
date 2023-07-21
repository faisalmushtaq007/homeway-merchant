part of 'package:homemakers_merchant/app/features/menu/index.dart';

class NewMenuGreetingPage extends StatefulWidget {
  const NewMenuGreetingPage({
    super.key,
    required this.menuEntity,
  });
  final MenuEntity menuEntity;
  @override
  _NewMenuGreetingPageController createState() => _NewMenuGreetingPageController();
}

class _NewMenuGreetingPageController extends State<NewMenuGreetingPage> {
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
  Widget build(BuildContext context) => _NewMenuGreetingPageView(this);
}

class _NewMenuGreetingPageView extends WidgetView<NewMenuGreetingPage, _NewMenuGreetingPageController> {
  const _NewMenuGreetingPageView(super.state);

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
            key: const Key('new-addons-greeting-page-zoomin-widget'),
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
                              'Hurray! New Menu',
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
                            6,
                            duration: Duration(
                              milliseconds: 300,
                            ),
                          ),
                          Center(
                            child: Text(
                              'Briyani ${widget.menuEntity.menuName}',
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
                                  'Your menu has been created successfully',
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
                            4,
                            duration: Duration(
                              milliseconds: 300,
                            ),
                          ),
                          Center(
                            child: Wrap(
                              children: [
                                Text(
                                  'Your menu is under verification process',
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  textAlign: TextAlign.center,
                                  style: context.bodyMedium!.copyWith(
                                    fontSize: 14,
                                  ),
                                ).translate(),
                              ],
                            ),
                          ),
                          const AnimatedGap(
                            24,
                            duration: Duration(
                              milliseconds: 300,
                            ),
                          ),
                          Center(
                            child: Wrap(
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                              children: [
                                Icon(Icons.restaurant_menu),
                                Text(
                                  'Menu ID #HMW${widget.menuEntity.menuId}',
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
                        bottom: kBottomNavigationBarHeight + bottomPadding - margins,
                        start: 0,
                        end: 0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(
                              color: Color.fromRGBO(165, 166, 168, 1),
                            ),
                            backgroundColor: Colors.white,
                          ),
                          child: Text(
                            'Go to Dashboard',
                            style: TextStyle(color: Color.fromRGBO(42, 45, 50, 1)),
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          ).translate(),
                          onPressed: () {
                            context.go(Routes.PRIMARY_DASHBOARD_PAGE);
                            return;
                          },
                        ),
                      ),
                      PositionedDirectional(
                        bottom: bottomPadding,
                        start: 0,
                        end: 0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(
                              color: Color.fromRGBO(165, 166, 168, 1),
                            ),
                            backgroundColor: Colors.white,
                          ),
                          child: Text(
                            'All Menus',
                            style: TextStyle(color: Color.fromRGBO(42, 45, 50, 1)),
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          ).translate(),
                          onPressed: () {
                            context.go(Routes.ALL_MENU_PAGE);
                            return;
                          },
                        ),
                      ),
                      PositionedDirectional(
                        bottom: kBottomNavigationBarHeight - bottomPadding,
                        start: 0,
                        end: 0,
                        child: ElevatedButton(
                          child: Text(
                            'Add Food Menu',
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          ).translate(),
                          onPressed: () {
                            context.go(Routes.SAVE_MENU_PAGE);
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
