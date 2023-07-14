part of 'package:homemakers_merchant/app/features/menu/index.dart';

class NewMenuGreetingPage extends StatefulWidget {
  const NewMenuGreetingPage({super.key});
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
      child: PlatformScaffold(
        material: (context, platform) {
          return MaterialScaffoldData(
            resizeToAvoidBottomInset: false,
          );
        },
        cupertino: (context, platform) {
          return CupertinoPageScaffoldData(
            resizeToAvoidBottomInset: false,
          );
        },
        appBar: PlatformAppBar(
          trailingActions: const [
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 14),
              child: LanguageSelectionWidget(),
            ),
          ],
        ),
        body: Directionality(
          textDirection: serviceLocator<LanguageController>().targetTextDirection,
          child: PageBody(
            controller: state.scrollController,
            constraints: BoxConstraints(
              minWidth: double.infinity,
              minHeight: media.size.height,
            ),
            child: Container(
              padding: EdgeInsetsDirectional.only(top: topPadding, start: margins * 2.5, end: margins * 2.5, bottom: bottomPadding),
              constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: media.size.height,
              ),
              child: ScrollableColumn(
                controller: state.scrollController,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Center(
                    child: Text('New Screen'),
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
