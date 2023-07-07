import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:homemakers_merchant/app/features/permission/presentation/bloc/permission_bloc.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/extension/text_extension.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/config/translation/widgets/language_selection_widget.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/shared/widgets/app/app_logo.dart';
import 'package:homemakers_merchant/shared/widgets/app/page_body.dart';
import 'package:homemakers_merchant/shared/widgets/universal/animate_do/animate_do.dart';
import 'package:homemakers_merchant/shared/widgets/universal/animated_gap/gap.dart';
import 'package:homemakers_merchant/shared/widgets/universal/constrained_scrollable_views/constrained_scrollable_views.dart';
import 'package:homemakers_merchant/shared/router/app_pages.dart';
import 'package:homemakers_merchant/shared/widgets/app/page_body.dart';
import 'package:go_router/go_router.dart';

class MainDashboardPage extends StatefulWidget {
  const MainDashboardPage({super.key});

  @override
  _MainDashboardPageState createState() => _MainDashboardPageState();
}

class _MainDashboardPageState extends State<MainDashboardPage> {
  final ScrollController scrollController = ScrollController();
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
        body: SlideInLeft(
          key: const Key('main-dashboard-page-slideinleft-widget'),
          from: context.width - 10,
          child: Directionality(
            textDirection: serviceLocator<LanguageController>().targetTextDirection,
            child: PageBody(
              controller: scrollController,
              constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: media.size.height,
              ),
              padding: EdgeInsetsDirectional.only(
                top: topPadding,
                bottom: bottomPadding,
                start: margins * 2.5,
                end: margins * 2.5,
              ),
              child: BlocBuilder<PermissionBloc, PermissionState>(
                bloc: context.read<PermissionBloc>(),
                buildWhen: (previous, current) => previous != current,
                builder: (context, state) {
                  return Stack(
                    children: [
                      const Align(
                        alignment: AlignmentDirectional.topStart,
                        child: AppLogo(),
                      ),
                      ScrollableColumn(
                        controller: scrollController,
                        padding: EdgeInsetsDirectional.only(
                          top: 100,
                        ),
                        flexible: false,
                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // success logo
                          Center(
                            child: Text(
                              'Welcome!',
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                              textAlign: TextAlign.center,
                              style: context.headlineMedium!.copyWith(
                                color: const Color.fromRGBO(69, 201, 125, 1),
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ).translate(),
                          ),
                          Center(
                            child: Text(
                              'Nura24X7',
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                              textAlign: TextAlign.center,
                              style: context.headlineMedium!.copyWith(
                                color: const Color.fromRGBO(69, 201, 125, 1),
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ).translate(),
                          ),
                          const AnimatedGap(
                            80,
                            duration: Duration(
                              milliseconds: 300,
                            ),
                          ),
                          Center(
                            child: Wrap(
                              children: [
                                Text(
                                  'Thank you for registering with us',
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  textAlign: TextAlign.center,
                                  style: context.titleLarge!.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ).translate(),
                              ],
                            ),
                          ),
                          const AnimatedGap(
                            16,
                            duration: Duration(
                              milliseconds: 300,
                            ),
                          ),
                          Center(
                            child: Wrap(
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                              children: [
                                Text(
                                  'We will contact you in Next 1-2 Working Days to physicals business verification',
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  textAlign: TextAlign.center,
                                  style: context.bodyMedium!.copyWith(
                                    fontSize: 16,
                                  ),
                                ).translate(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: SizedBox(
                          width: context.width - margins * 5,
                          child: ElevatedButton(
                            child: Text(
                              'Go to Dashboard',
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            ).translate(),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
