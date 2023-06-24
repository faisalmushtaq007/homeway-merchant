import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/widgets/about_us_text.dart';
import 'package:homemakers_merchant/config/translation/extension/string_extension.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/shared/widgets/app/page_body.dart';
import 'package:homemakers_merchant/shared/widgets/universal/willpopscope/cupertino_will_pop_scope/cupertino_will_pop_scope.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  late final ScrollController scrollController;
  // About us
  final ScrollController aboutUsListViewController = ScrollController();
  final aboutUsStaticAnchorKey = GlobalKey();
  var aboutUsReachEnd = false;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
    aboutUsListViewController.addListener(aboutUsScrollListener);
  }

  @override
  void dispose() {
    scrollController.dispose();
    aboutUsListViewController.removeListener(aboutUsScrollListener);
    aboutUsListViewController.dispose();
    super.dispose();
  }

  String returnAboutUsText() {
    return aboutUsText;
  }

  // Button pressed for arrow_downward to page
  void aboutUsAnchorContent() {
    final anchorContext =
        AnchorKey.forId(aboutUsStaticAnchorKey, "bottom")?.currentContext;
    if (anchorContext != null) {
      Scrollable.ensureVisible(anchorContext);
    }
  }

  void aboutUsScrollListener() {
    final maxScroll = aboutUsListViewController.position.maxScrollExtent;
    final minScroll = aboutUsListViewController.position.minScrollExtent;
    if (aboutUsListViewController.offset >= maxScroll) {
      aboutUsReachEnd = true;
      setState(() {});
    }

    if (aboutUsListViewController.offset <= minScroll) {
      aboutUsReachEnd = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = 0; //media.padding.top + kToolbarHeight + margins;
    final double bottomPadding = media.padding.bottom + margins;

    return ConditionalWillPopScope(
      onWillPop: () async => true,
      shouldAddCallback: true,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: FlexColorScheme.themedSystemNavigationBar(
          context,
          useDivider: false,
          opacity: 0.60,
        ),
        child: PlatformScaffold(
          body: PageBody(
            controller: scrollController,
            constraints: BoxConstraints(
              minWidth: double.infinity,
              minHeight: media.size.height,
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: SizedBox(
                height: context.height,
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Positioned(
                      top: 0,
                      child: Container(
                        width: width,
                        height: height * 0.37,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                    Positioned(
                      top: height * 0.37 - 130,
                      child: SizedBox(
                        width: width * 0.84,
                        height: height * 0.37,
                        child: Text(
                          'About Us'.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    Positioned(
                      top: context.height * 0.37 - 80,
                      //height: Get.height - kBottomNavigationBarHeight,
                      width: context.width,
                      bottom: kBottomNavigationBarHeight - 40,
                      child: LayoutBuilder(builder: (context, constraints) {
                        return ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                            minWidth: constraints.maxWidth,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Container(
                                  width: context.width,
                                  height: constraints.maxHeight - 70,
                                  margin: const EdgeInsetsDirectional.symmetric(
                                      horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 50,
                                        color: Theme.of(context)
                                            .hintColor
                                            .withOpacity(0.2),
                                      )
                                    ],
                                  ),
                                  child: Scrollbar(
                                    child: SingleChildScrollView(
                                      controller: aboutUsListViewController,
                                      padding: EdgeInsetsDirectional.symmetric(
                                          horizontal: 12, vertical: 6),
                                      child: Html(
                                        anchorKey: aboutUsStaticAnchorKey,
                                        data: returnAboutUsText(),
                                        style: {
                                          "body": Style(
                                            fontSize: FontSize(15.0),
                                          ),
                                        },
                                        onCssParseError: (css, messages) {
                                          debugPrint("css that errored: $css");
                                          debugPrint("error messages:");
                                          for (var element in messages) {
                                            debugPrint(element.toString());
                                          }
                                          return '';
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                        );
                      }),
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
