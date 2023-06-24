import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:homemakers_merchant/app/features/authentication/presentation/widgets/term_and_condition_text.dart';
import 'package:homemakers_merchant/config/translation/extension/string_extension.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/shared/widgets/app/page_body.dart';
import 'package:homemakers_merchant/shared/widgets/universal/willpopscope/cupertino_will_pop_scope/cupertino_will_pop_scope.dart';

class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({super.key});

  @override
  State<TermsAndConditionsPage> createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  late final ScrollController scrollController;
  // Terms and conditions
  var checkBoxValue = false;
  final ScrollController termsAndConditionListViewController =
      ScrollController();
  final staticAnchorKey = GlobalKey();
  var reachEnd = false;
  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
    termsAndConditionListViewController.addListener(listener);
  }

  @override
  void dispose() {
    scrollController.dispose();
    termsAndConditionListViewController.removeListener(listener);
    termsAndConditionListViewController.dispose();
    super.dispose();
  }

  String returnTermsAndConditionsText() {
    return termsAndConditionsText;
  }

  // Button pressed for arrow_downward to page
  void anchorContent() {
    final anchorContext =
        AnchorKey.forId(staticAnchorKey, "bottom")?.currentContext;
    if (anchorContext != null) {
      Scrollable.ensureVisible(anchorContext);
    }
  }

  void checkBoxOnChanged(bool? onChange) {
    checkBoxValue = onChange!;
    setState(() {});
  }

  void listener() {
    final maxScroll =
        termsAndConditionListViewController.position.maxScrollExtent;
    final minScroll =
        termsAndConditionListViewController.position.minScrollExtent;
    if (termsAndConditionListViewController.offset >= maxScroll) {
      reachEnd = true;
      setState(() {});
    }

    if (termsAndConditionListViewController.offset <= minScroll) {
      reachEnd = false;
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
                          "Terms & Conditions".tr(),
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
                                          termsAndConditionListViewController,
                                      padding: EdgeInsetsDirectional.symmetric(
                                          horizontal: 12, vertical: 6),
                                      child: Html(
                                        anchorKey: staticAnchorKey,
                                        data: returnTermsAndConditionsText(),
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
                              ListTileTheme(
                                contentPadding: EdgeInsetsDirectional.symmetric(
                                    horizontal: 15),
                                minVerticalPadding: 2,
                                horizontalTitleGap: 0,
                                child: CheckboxListTile(
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title: Text(
                                      'Accept the terms and conditions'.tr()),
                                  value: checkBoxValue,
                                  onChanged: checkBoxOnChanged,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                child: Text('Save and Continue'.tr()),
                                onPressed: () {
                                  /* if (controller.checkBoxValue == true) {
                                    Get.back();
                                    return;
                                  }*/
                                },
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
