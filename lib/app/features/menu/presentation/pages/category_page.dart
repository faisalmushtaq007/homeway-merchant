part of 'package:homemakers_merchant/app/features/menu/index.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  _CategoryPageController createState() => _CategoryPageController();
}

class _CategoryPageController extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) => _CategoryPageView(this);
}

class _CategoryPageView
    extends WidgetView<CategoryPage, _CategoryPageController> {
  const _CategoryPageView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = margins;
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: Offstage(),
    );
  }
}
