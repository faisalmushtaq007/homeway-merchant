import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:homemakers_merchant/app/features/permission/presentation/bloc/permission_bloc.dart';
import 'package:homemakers_merchant/app/features/store/domain/entities/store_entity.dart';
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
import 'package:lottie/lottie.dart';

class NewStoreGreetingPage extends StatelessWidget {
  const NewStoreGreetingPage({required this.storeEntity, super.key});
  final StoreEntity storeEntity;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    final double bottomPadding = media.padding.bottom + margins;
    final double width = media.size.width;
    final ThemeData theme = Theme.of(context);
    final ScrollController scrollController = ScrollController();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        useDivider: false,
        opacity: 0.60,
        noAppBar: true,
      ),
      child: Directionality(
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
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
          body: ZoomIn(
            key: const Key('new-store-greeting-page-zoomin-widget'),
            delay: const Duration(milliseconds: 500),
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
                      ListView(
                        controller: scrollController,
                        padding: EdgeInsetsDirectional.only(
                          top: 50,
                        ),
                        children: [
                          // success logo
                          Lottie.asset(
                            'assets/lottie/success_check_mark.json',
                            height: 110,
                          ),
                          Center(
                            child: Text(
                              'Congratulation!',
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
                              '${storeEntity.storeName ?? ''}',
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
                                  'Store has been successfully added',
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
                            4,
                            duration: Duration(
                              milliseconds: 300,
                            ),
                          ),
                          Center(
                            child: Wrap(
                              children: [
                                Text(
                                  'Your store is under verification process',
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  textAlign: TextAlign.center,
                                  style: context.bodyMedium!.copyWith(
                                    fontSize: 14,
                                  ),
                                ).translate(),
                              ],
                            ),
                          ),
                          const AnimatedGap(
                            24,
                            duration: Duration(
                              milliseconds: 300,
                            ),
                          ),
                          Center(
                            child: Wrap(
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                              children: [
                                Icon(Icons.store),
                                Text(
                                  'Store ID #HMW${storeEntity.storeID}',
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  textAlign: TextAlign.center,
                                  style: context.titleMedium!.copyWith(
                                    fontSize: 18,
                                    color: Color.fromRGBO(127, 129, 132, 1),
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
                        ],
                      ),
                      PositionedDirectional(
                        bottom: kBottomNavigationBarHeight + bottomPadding,
                        start: 0,
                        end: 0,
                        child: Center(
                          child: Wrap(
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            children: [
                              Icon(Icons.share),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                'Share your store on social media',
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                textAlign: TextAlign.center,
                                style: context.titleMedium!.copyWith(
                                  fontSize: 18,
                                  color: Color.fromRGBO(127, 129, 132, 1),
                                ),
                              ).translate(),
                            ],
                          ),
                        ),
                      ),
                      PositionedDirectional(
                        bottom: bottomPadding,
                        start: 0,
                        end: 0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(
                              color: Color.fromRGBO(165, 166, 168, 1),
                            ),
                            backgroundColor: Colors.white,
                          ),
                          child: Text(
                            'Go to Dashboard',
                            style: TextStyle(color: Color.fromRGBO(42, 45, 50, 1)),
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          ).translate(),
                          onPressed: () {
                            context.go(Routes.PRIMARY_DASHBOARD_PAGE);
                            return;
                          },
                        ),
                      ),
                      PositionedDirectional(
                        bottom: kBottomNavigationBarHeight - bottomPadding,
                        start: 0,
                        end: 0,
                        child: ElevatedButton(
                          child: Text(
                            'Add Food Menu',
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          ).translate(),
                          onPressed: () {
                            context.go(Routes.SAVE_MENU_PAGE);
                            return;
                          },
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
