import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homemakers_merchant/base/widget_view.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/shared/widgets/app/page_body.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageViewController createState() => _SplashPageViewController();
}

class _SplashPageViewController extends State<SplashPage> {
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
  Widget build(BuildContext context) => _PageView(this);
}

class _PageView extends WidgetView<SplashPage, _SplashPageViewController> {
  const _PageView(super.state);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        useDivider: false,
        opacity: 0.60,
      ),
      child: PageBody(
        controller: state.scrollController,
        child: SizedBox(
          child: ListView(
            controller: state.scrollController,
            shrinkWrap: true,
            children: [],
          ),
        ),
      ),
    );
  }
}
