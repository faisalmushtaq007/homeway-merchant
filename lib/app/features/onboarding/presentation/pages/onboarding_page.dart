import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:homemakers_merchant/app/features/onboarding/presentation/widgets/onboarding_slider/flutter_onboarding_slider.dart';
import 'package:homemakers_merchant/base/widget_view.dart';
import 'package:homemakers_merchant/config/translation/extension/string_extension.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/gen/assets.gen.dart';
import 'package:homemakers_merchant/shared/router/app_pages.dart';
import 'package:homemakers_merchant/shared/widgets/app/page_body.dart';
import 'package:homemakers_merchant/shared/widgets/universal/double_tap_exit/double_tap_to_exit.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  _OnBoardingPageViewController createState() =>
      _OnBoardingPageViewController();
}

class _OnBoardingPageViewController extends State<OnBoardingPage> {
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

class _PageView
    extends WidgetView<OnBoardingPage, _OnBoardingPageViewController> {
  const _PageView(super.state);

  @override
  Widget build(BuildContext context) {
    final Color kDarkBlueColor =
        context.primaryColor; // const Color(0xFF053149);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        useDivider: false,
        opacity: 0.60,
      ),
      child: DoubleTapToExit(
        child: OnBoardingSlider(
          finishButtonText: 'Register',
          onFinish: () {
            context.go(Routes.LOGIN);
          },
          finishButtonStyle: FinishButtonStyle(
            backgroundColor: kDarkBlueColor,
          ),
          skipTextButton: Text(
            'Skip',
            style: TextStyle(
              fontSize: 16,
              color: kDarkBlueColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: Text(
            'Login',
            style: TextStyle(
              fontSize: 16,
              color: kDarkBlueColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailingFunction: () {
            context.go(Routes.LOGIN);
          },
          controllerColor: kDarkBlueColor,
          totalPage: 4,
          headerBackgroundColor: Colors.white,
          pageBackgroundColor: Colors.white,
          //centerBackground: true,
          background: [
            Assets.image.merchantOnboarding01.image(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
            ),
            Assets.image.merchantOnboarding02.image(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
            ),
            Assets.image.merchantOnboarding03.image(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
            ),
            Assets.image.merchantOnboarding04.image(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
            ),
          ],
          speed: 1.8,
          pageBodies: [
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 400,
                  ),
                  Text(
                    'On your way...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kDarkBlueColor,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'to find the perfect looking Onboarding for your app?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 400,
                  ),
                  Text(
                    'You’ve reached your destination.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kDarkBlueColor,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Sliding with animation',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 400,
                  ),
                  Text(
                    'Start now!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kDarkBlueColor,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Where everything is possible and customize your onboarding.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 400,
                  ),
                  Text(
                    'Grow up now!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kDarkBlueColor,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'We can grow together.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
