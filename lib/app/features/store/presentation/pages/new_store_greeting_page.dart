part of 'package:homemakers_merchant/app/features/store/index.dart';

class NewStoreGreetingPage extends StatelessWidget {
  const NewStoreGreetingPage({
    required this.storeEntity,
    super.key,
  });
  final StoreEntity storeEntity;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    final double bottomPadding = media.padding.bottom + margins;
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
          appBar: AppBar(
            actions: const [
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 14),
                child: LanguageSelectionWidget(),
              ),
            ],
          ),
          body: ZoomIn(
            key: const Key('new-store-greeting-page-zoomin-widget'),
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
                      ListView(
                        controller: scrollController,
                        padding: const EdgeInsetsDirectional.only(
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
                              'Congratulation!',
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
                              storeEntity.storeName,
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
                            80,
                            duration: Duration(
                              milliseconds: 300,
                            ),
                          ),
                          Center(
                            child: Wrap(
                              children: [
                                Text(
                                  'Store has been successfully added',
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
                                  'Your store is under verification process',
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
                                const Icon(Icons.store),
                                Text(
                                  'Store ID #HMW-STORE-${storeEntity.storeID}',
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  textAlign: TextAlign.center,
                                  style: context.titleMedium!.copyWith(
                                    fontSize: 18,
                                    color: const Color.fromRGBO(127, 129, 132, 1),
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
                        bottom: kBottomNavigationBarHeight + bottomPadding,
                        start: 0,
                        end: 0,
                        child: Center(
                          child: Wrap(
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            children: [
                              const Icon(Icons.share),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                'Share your store on social media',
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                textAlign: TextAlign.center,
                                style: context.titleMedium!.copyWith(
                                  fontSize: 18,
                                  color: const Color.fromRGBO(127, 129, 132, 1),
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
                                    'My Stores',
                                    style: const TextStyle(color: Color.fromRGBO(42, 45, 50, 1)),
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  ).translate(),
                                  onPressed: () {
                                    context.pushReplacement(Routes.ALL_STORES_PAGE);
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
                            'Add Food Menu',
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          ).translate(),
                          onPressed: () {
                            context.pushReplacement(Routes.ALL_MENU_PAGE);
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
