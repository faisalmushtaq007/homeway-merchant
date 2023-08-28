part of 'package:homemakers_merchant/app/features/menu/index.dart';

class SubCategoryPage extends StatefulWidget {
  const SubCategoryPage({super.key});
  @override
  _SubCategoryPageController createState() => _SubCategoryPageController();
}

class _SubCategoryPageController extends State<SubCategoryPage> {
  @override
  Widget build(BuildContext context) => _SubCategoryPageView(this);
}

class _SubCategoryPageView extends WidgetView<SubCategoryPage, _SubCategoryPageController> {
  const _SubCategoryPageView(super.state);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
