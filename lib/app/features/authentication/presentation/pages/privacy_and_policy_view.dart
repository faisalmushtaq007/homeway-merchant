import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/widgets/privacy_and_policy_text.dart';
import 'package:homemakers_merchant/config/translation/extension/string_extension.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/shared/widgets/app/page_body.dart';
import 'package:homemakers_merchant/shared/widgets/universal/willpopscope/cupertino_will_pop_scope/cupertino_will_pop_scope.dart';

class PrivacyAndPolicyPage extends StatefulWidget {
  const PrivacyAndPolicyPage({super.key});

  @override
  State<PrivacyAndPolicyPage> createState() => _PrivacyAndPolicyPageState();
}

class _PrivacyAndPolicyPageState extends State<PrivacyAndPolicyPage> {
  late final ScrollController scrollController;
  // privacy and policy
  var privacyCheckBoxValue = false;
  final ScrollController privacyAndPolicyListViewController =
      ScrollController();
  final privacyAndPolicyStaticAnchorKey = GlobalKey();
  var privacyAndPolicyReachEnd = false;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
    privacyAndPolicyListViewController.addListener(privacyAndPolicyListener);
  }

  @override
  void dispose() {
    scrollController.dispose();
    privacyAndPolicyListViewController.removeListener(privacyAndPolicyListener);
    privacyAndPolicyListViewController.dispose();
    super.dispose();
  }

  void privacyAndPolicyCheckBoxOnChanged(bool? onChange) {
    privacyCheckBoxValue = onChange!;
    setState(() {});
  }

// Button pressed for arrow_downward to page
  void privacyAndPolicyAnchorContent() {
    final anchorContext =
        AnchorKey.forId(privacyAndPolicyStaticAnchorKey, 'bottom')
            ?.currentContext;
    if (anchorContext != null) {
      Scrollable.ensureVisible(anchorContext);
    }
  }

  String returnPrivacyAndPolicyText() {
    return privacyAndPolicyText;
  }

  void privacyAndPolicyListener() {
    final maxScroll =
        privacyAndPolicyListViewController.position.maxScrollExtent;
    final minScroll =
        privacyAndPolicyListViewController.position.minScrollExtent;
    if (privacyAndPolicyListViewController.offset >= maxScroll) {
      privacyAndPolicyReachEnd = true;
      setState(() {});
    }

    if (privacyAndPolicyListViewController.offset <= minScroll) {
      privacyAndPolicyReachEnd = false;
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
                          'Privacy and Policy'.tr(),
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
                                      controller:
                                          privacyAndPolicyListViewController,
                                      padding: EdgeInsetsDirectional.symmetric(
                                          horizontal: 12, vertical: 6),
                                      child: Html(
                                        anchorKey:
                                            privacyAndPolicyStaticAnchorKey,
                                        data: returnPrivacyAndPolicyText(),
                                        style: {
                                          'body': Style(
                                            fontSize: FontSize(15.0),
                                          ),
                                        },
                                        onCssParseError: (css, messages) {
                                          debugPrint('css that errored: $css');
                                          debugPrint('error messages:');
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
                              ListTileTheme(
                                contentPadding: EdgeInsetsDirectional.symmetric(
                                    horizontal: 15),
                                minVerticalPadding: 2,
                                horizontalTitleGap: 0,
                                child: CheckboxListTile(
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title: Text(
                                      'Accept the privacy and policy'.tr()),
                                  value: privacyCheckBoxValue,
                                  onChanged: privacyAndPolicyCheckBoxOnChanged,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                child: Text('Save and Continue'.tr()),
                                onPressed: () {},
                              ),
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
