part of 'package:homemakers_merchant/app/features/dashboard/index.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this)
      ..value = 0.5
      ..addListener(() {
        setState(() {
          // Rebuild the widget at each frame to update the "progress" label.
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    final double bottomPadding = media.padding.bottom + margins;
    final double width = media.size.width;
    final ThemeData theme = Theme.of(context);
    final ScrollController scrollController = ScrollController();
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
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            actions: const [
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 14),
                child: LanguageSelectionWidget(),
              ),
            ],
          ),
          body: ZoomIn(
            key: const Key('welcome-page-zoomin-widget'),
            delay: const Duration(milliseconds: 500),
            child: PageBody(
              controller: scrollController,
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
                builder: (context, state) {
                  return Stack(
                    children: [
                      const Align(
                        alignment: AlignmentDirectional.topStart,
                        child: AppLogo(),
                      ),
                      Container(
                        constraints: BoxConstraints(
                          minWidth: double.infinity,
                          minHeight: media.size.height,
                        ),
                        child: ScrollableColumn(
                          controller: scrollController,
                          padding: EdgeInsetsDirectional.only(
                            top: 50,
                          ),
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // success logo
                            Lottie.asset(
                              'assets/lottie/success_check_mark.json',
                              height: 110,
                            ),
                            Center(
                              child: Text(
                                'Welcome!',
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                textAlign: TextAlign.center,
                                style: context.headlineMedium!.copyWith(
                                  color: const Color.fromRGBO(69, 201, 125, 1),
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ).translate(),
                            ),
                            Center(
                              child: Text(
                                'Nura24X7',
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
                              60,
                              duration: Duration(
                                milliseconds: 300,
                              ),
                            ),
                            Center(
                              child: Wrap(
                                children: [
                                  Text(
                                    'Thank you for registering with us',
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
                            Center(
                              child: Wrap(
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                children: [
                                  Text(
                                    'We will contact you in Next 1-2 Working Days to physicals business verification',
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    textAlign: TextAlign.center,
                                    style: context.bodyMedium!.copyWith(
                                      fontSize: 16,
                                    ),
                                  ).translate(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: SizedBox(
                          width: context.width - margins * 5,
                          child: ElevatedButton(
                            child: Text(
                              'Go to Dashboard',
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            ).translate(),
                            onPressed: () {
                              context.go(Routes.PRIMARY_DASHBOARD_PAGE);
                              return;
                            },
                          ),
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
