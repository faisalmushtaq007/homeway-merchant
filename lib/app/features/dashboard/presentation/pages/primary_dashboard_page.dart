import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:homemakers_merchant/app/features/dashboard/domain/entities/primary_dashboard_menu_entity.dart';
import 'package:homemakers_merchant/app/features/dashboard/presentation/widgets/primary_dashboard_drawer.dart';
import 'package:homemakers_merchant/app/features/dashboard/presentation/widgets/primary_dashboard_menu_card.dart';
import 'package:homemakers_merchant/app/features/permission/presentation/bloc/permission_bloc.dart';
import 'package:homemakers_merchant/app/features/profile/domain/entities/user_entity.dart';
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
import 'package:homemakers_merchant/shared/widgets/universal/double_tap_exit/double_tap_to_exit.dart';

class PrimaryDashboardPage extends StatefulWidget {
  const PrimaryDashboardPage({
    super.key,
    this.primaryDashboardMenuEntities = const [],
  });

  final List<StoreEntity> primaryDashboardMenuEntities;

  @override
  _PrimaryDashboardPageState createState() => _PrimaryDashboardPageState();
}

class _PrimaryDashboardPageState extends State<PrimaryDashboardPage> {
  final ScrollController scrollController = ScrollController();
  List<StoreEntity> primaryDashboardMenuEntities = [];

  @override
  void initState() {
    super.initState();
    primaryDashboardMenuEntities.clear();
    primaryDashboardMenuEntities.add(
      StoreEntity(
        title: 'Upload Documents',
        titleID: 0,
        onPressed: () {},
        leading: const Icon(
          Icons.edit_document,
        ),
        hasEntityStored: false,
      ),
    );
    primaryDashboardMenuEntities.add(
      StoreEntity(
        title: 'Payment details',
        titleID: 1,
        onPressed: () {},
        leading: const Icon(
          Icons.payment,
        ),
        hasEntityStored: false,
      ),
    );
    primaryDashboardMenuEntities.add(
      StoreEntity(
        title: 'Store',
        titleID: 2,
        onPressed: () {
          context.go(Routes.ALL_STORES_PAGE);
        },
        leading: const Icon(
          Icons.store,
        ),
        hasEntityStored: false,
      ),
    );
    primaryDashboardMenuEntities.add(
      StoreEntity(
        title: 'Food Menu',
        titleID: 3,
        onPressed: () {},
        leading: const Icon(
          Icons.restaurant_menu,
        ),
        hasEntityStored: false,
      ),
    );
  }

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
      child: Directionality(
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
        child: DoubleTapToExit(
          child: Scaffold(
            appBar: AppBar(
              actions: const [
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 14),
                  child: LanguageSelectionWidget(),
                ),
              ],
            ),
            drawer: const PrimaryDashboardDrawer(),
            body: SlideInLeft(
              key: const Key('primary-dashboard-page-slideinleft-widget'),
              delay: const Duration(milliseconds: 500),
              from: 200,
              child: PageBody(
                controller: scrollController,
                constraints: BoxConstraints(
                  minWidth: double.infinity,
                  minHeight: context.height,
                ),
                padding: EdgeInsetsDirectional.only(
                  top: margins,
                  bottom: bottomPadding,
                  start: margins * 2.5,
                  end: margins * 2.5,
                ),
                child: BlocBuilder<PermissionBloc, PermissionState>(
                  bloc: context.read<PermissionBloc>(),
                  buildWhen: (previous, current) => previous != current,
                  builder: (context, state) {
                    return Container(
                      constraints: BoxConstraints(
                        minWidth: double.infinity,
                        minHeight: context.height,
                      ),
                      child: ScrollableColumn(
                        controller: scrollController,
                        physics: const ClampingScrollPhysics(),
                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        padding: EdgeInsetsDirectional.only(
                          top: topPadding,
                        ),
                        children: [
                          const Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              CircleAvatar(
                                maxRadius: 40,
                                backgroundImage: AssetImage(
                                  "assets/image/app_logo_light.jpg",
                                ),
                              ),
                            ],
                          ),
                          const AnimatedGap(
                            15,
                            duration: Duration(milliseconds: 500),
                          ),
                          Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              Text(
                                "${serviceLocator<AppUserEntity>().businessProfile?.userName ?? 'Thomas Shelby'}",
                                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                              ).translate(),
                            ],
                          ),
                          Wrap(
                            alignment: WrapAlignment.center,
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            children: [
                              Text("${serviceLocator<AppUserEntity>().businessProfile?.businessEmailAddress ?? 'thomashomeservice@gmail.com'}").translate(),
                            ],
                          ),
                          const AnimatedGap(
                            15,
                            duration: Duration(milliseconds: 500),
                          ),
                          Wrap(
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            alignment: WrapAlignment.center,
                            children: [
                              DecoratedBox(
                                decoration: BoxDecoration(color: Color.fromRGBO(252, 240, 218, 1)),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(top: 8, bottom: 8, start: 4, end: 4),
                                  child: Text(
                                    'Your business verification is under review process. Thank you so much for being our partner.',
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    textAlign: TextAlign.center,
                                    style: context.bodyMedium!.copyWith(color: Color.fromRGBO(207, 138, 10, 1)),
                                  ).translate(),
                                ),
                              ),
                            ],
                          ),
                          const AnimatedGap(
                            25,
                            duration: Duration(milliseconds: 500),
                          ),
                          Flexible(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: primaryDashboardMenuEntities.length,
                              itemBuilder: (context, index) {
                                return PrimaryDashboardMenuCard(
                                  key: ValueKey(index),
                                  primaryDashboardMenuEntity: primaryDashboardMenuEntities[index],
                                );
                              },
                            ),
                          ),
                          const AnimatedGap(
                            10,
                            duration: Duration(milliseconds: 500),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
