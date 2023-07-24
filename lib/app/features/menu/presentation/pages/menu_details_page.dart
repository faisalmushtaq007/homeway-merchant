part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuDetailsPage extends StatefulWidget {
  const MenuDetailsPage({super.key});

  @override
  _StoreDetailsPageController createState() => _StoreDetailsPageController();
}

class _StoreDetailsPageController extends State<MenuDetailsPage> {
  late final ScrollController scrollController;
  late final ScrollController innerScrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    innerScrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    innerScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<StoreBloc, StoreState>(
        bloc: context.watch<StoreBloc>(),
        key: const Key('menu-details-page-bloc-builder-widget'),
        builder: (context, storeState) {
          return _StoreDetailsPageView(this);
        },
      );
}

class _StoreDetailsPageView extends WidgetView<MenuDetailsPage, _StoreDetailsPageController> {
  const _StoreDetailsPageView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    final double bottomPadding = margins; //media.padding.bottom + margins;
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: FlexColorScheme.themedSystemNavigationBar(
          context,
          useDivider: false,
          opacity: 0.60,
          noAppBar: true,
        ),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text(
              'Your menu',
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
            ),
            actions: const [
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 14),
                child: LanguageSelectionWidget(),
              ),
            ],
          ),
          body: SlideInLeft(
            key: const Key('menu-details-slideinleft-widget'),
            delay: const Duration(milliseconds: 500),
            from: context.width - 40,
            child: PageBody(
              controller: state.scrollController,
              constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: media.size.height,
              ),
              padding: EdgeInsetsDirectional.only(
                top: topPadding,
                start: margins * 2.5,
                end: margins * 2.5,
              ),
              child: Stack(
                children: [
                  CustomScrollView(
                    controller: state.innerScrollController,
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [],
                          ),
                        ]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
