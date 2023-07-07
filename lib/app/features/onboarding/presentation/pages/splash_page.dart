import 'dart:ui' as ui;

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemakers_merchant/base/widget_view.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/extension/text_extension.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/shared/router/app_pages.dart';
import 'package:homemakers_merchant/shared/widgets/app/app_logo.dart';
import 'package:homemakers_merchant/shared/widgets/app/flutter_svg_provider.dart';
import 'package:homemakers_merchant/shared/widgets/app/page_body.dart';
import 'package:homemakers_merchant/shared/widgets/universal/animate_do/animate_do.dart';
import 'package:homemakers_merchant/shared/widgets/universal/animated_gap/gap.dart';
import 'package:homemakers_merchant/shared/widgets/universal/constrained_scrollable_views/constrained_scrollable_views.dart';

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
          child: PageBody(
            controller: state.scrollController,
            constraints: BoxConstraints(
              minWidth: double.infinity,
              minHeight: context.height,
            ),
            child: Container(
              height: context.height,
              alignment: AlignmentDirectional.topStart,
              constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: context.height,
              ),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image/splashBackground.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: SlideInLeft(
                key: const Key('splash-page-slideinleft-widget'),
                delay: const Duration(milliseconds: 500),
                from: context.width / 4,
                child: ScrollableColumn(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  controller: state.scrollController,
                  flexible: false,
                  padding: EdgeInsetsDirectional.only(
                    top: topPadding,
                    start: margins * 2.5,
                    end: margins * 2.5,
                    bottom: bottomPadding,
                  ),
                  children: [
                    const Align(
                      alignment: AlignmentDirectional.topStart,
                      child: AppLogo(changeColorModeOfText: true),
                    ),
                    const AnimatedGap(46, duration: Duration(milliseconds: 500)),
                    Wrap(
                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                      children: [
                        Text(
                          'Your Business,',
                          style: context.headlineMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            height: 0.9,
                            color: Colors.white,
                          ),
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                        ).translate(),
                      ],
                    ),
                    const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                    Wrap(
                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                      children: [
                        Text(
                          'Our Services,',
                          style: context.headlineMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            height: 0.9,
                            color: Colors.white,
                          ),
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                        ).translate(),
                      ],
                    ),
                    const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                    Wrap(
                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                      children: [
                        Text(
                          'Stays Forever',
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          style: context.headlineMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            height: 0.9,
                            color: Colors.white,
                          ),
                        ).translate(),
                      ],
                    ),
                    const AnimatedGap(10, duration: Duration(milliseconds: 500)),
                    Wrap(
                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                      children: [
                        Text(
                          'Thank you for selecting to start business with us.',
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          style: context.bodySmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            height: 0.9,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        ).translate(),
                      ],
                    ),
                    /*Center(
                                child: Text('New Screen'),
                              ),*/
                    const AnimatedGap(56, duration: Duration(milliseconds: 500)),
                    ElevatedButton(
                      onPressed: () {
                        context.go(Routes.AUTH_PHONE_NUMBER_VERIFICATION);
                      },
                      child: Text(
                        "Let's Get Started",
                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                      ).translate(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
