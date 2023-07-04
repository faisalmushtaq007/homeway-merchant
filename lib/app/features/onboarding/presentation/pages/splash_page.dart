import 'dart:ui' as ui;

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homemakers_merchant/base/widget_view.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/shared/widgets/app/flutter_svg_provider.dart';
import 'package:homemakers_merchant/shared/widgets/app/page_body.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageViewController createState() => _SplashPageViewController();
}

class _SplashPageViewController extends State<SplashPage> with SingleTickerProviderStateMixin {
  late final ScrollController scrollController;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: -1, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _PageView(this);
}

class _PageView extends WidgetView<SplashPage, _SplashPageViewController> {
  const _PageView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    final double bottomPadding = media.padding.bottom + margins;
    final double width = media.size.width;
    final ThemeData theme = Theme.of(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        useDivider: false,
        opacity: 0.6,
        noAppBar: true,
      ),
      child: PlatformScaffold(
        body: Directionality(
          textDirection: serviceLocator<LanguageController>().targetTextDirection,
          child: AnimatedBuilder(
            animation: state._animationController,
            builder: (BuildContext context, Widget? child) {
              return Transform(
                transform: Matrix4.translationValues(
                  state._animation.value * width,
                  0.0,
                  0.0,
                ),
                child: Directionality(
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                  child: PageBody(
                      controller: state.scrollController,
                      constraints: BoxConstraints(
                        minWidth: double.infinity,
                        minHeight: context.height,
                      ),
                      child: Container(
                        height: context.height,
                        constraints: BoxConstraints(
                          minWidth: double.infinity,
                          minHeight: context.height,
                        ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/image/appBackground.jpg'),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.70), BlendMode.darken),
                            //colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
                          ),
                        ),
                        child: ListView(
                          controller: state.scrollController,
                          shrinkWrap: true,
                          padding: EdgeInsetsDirectional.only(
                            top: topPadding,
                            start: margins * 2.5,
                            end: margins * 2.5,
                          ),
                          children: const [
                            Center(
                              child: Text('New Screen'),
                            ),
                          ],
                        ),
                      )),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
