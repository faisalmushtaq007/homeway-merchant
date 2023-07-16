import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:homemakers_merchant/app/features/permission/presentation/bloc/permission_bloc.dart';
import 'package:homemakers_merchant/app/features/store/domain/entities/store_entity.dart';
import 'package:homemakers_merchant/app/features/store/presentation/manager/store_bloc.dart';
import 'package:homemakers_merchant/app/features/store/presentation/widgets/store_card.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/app_translator.dart';
import 'package:homemakers_merchant/config/translation/extension/text_extension.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/config/translation/widgets/language_selection_widget.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/constants/store.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/shared/states/result_state.dart';
import 'package:homemakers_merchant/shared/states/widget_state.dart';
import 'package:homemakers_merchant/shared/widgets/app/app_logo.dart';
import 'package:homemakers_merchant/shared/widgets/app/page_body.dart';
import 'package:homemakers_merchant/shared/widgets/universal/animate_do/animate_do.dart';
import 'package:homemakers_merchant/shared/widgets/universal/animated_gap/gap.dart';
import 'package:homemakers_merchant/shared/widgets/universal/carousel_animation/carousel_animations.dart';
import 'package:homemakers_merchant/shared/widgets/universal/constrained_scrollable_views/constrained_scrollable_views.dart';
import 'package:homemakers_merchant/shared/router/app_pages.dart';
import 'package:homemakers_merchant/shared/widgets/app/page_body.dart';
import 'package:go_router/go_router.dart';
import 'package:homemakers_merchant/shared/widgets/universal/date_time_picker_platform/datetime_picker_field_platform.dart';
import 'package:homemakers_merchant/shared/widgets/universal/double_tap_exit/double_tap_to_exit.dart';
import 'package:homemakers_merchant/shared/widgets/universal/multi_stream_builder/multi_stream_builder.dart';
import 'package:homemakers_merchant/utils/app_log.dart';

class AllStoresPage extends StatefulWidget {
  const AllStoresPage({super.key});

  @override
  State<AllStoresPage> createState() => _AllStoresPageState();
}

class _AllStoresPageState extends State<AllStoresPage> {
  late final ScrollController scrollController;
  List<StoreEntity> storeEntities = [];
  late final ScrollController listViewBuilderScrollController;
  ResultState<StoreEntity> resultState = const ResultState.empty();
  WidgetState<StoreEntity> widgetState = const WidgetState<StoreEntity>.none();
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    listViewBuilderScrollController = ScrollController();
    storeEntities = [];
    storeEntities.clear();

    //context.read<StoreBloc>().add(GetAllStore());
    initStoreList();
  }

  void initStoreList() {}

  @override
  void dispose() {
    scrollController.dispose();
    listViewBuilderScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    final double bottomPadding = margins; //media.padding.bottom + margins;
    final double width = media.size.width;
    final ThemeData theme = Theme.of(context);

    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: FlexColorScheme.themedSystemNavigationBar(
          context,
          useDivider: false,
          opacity: 0.60,
          noAppBar: true,
        ),
        child: PlatformScaffold(
          appBar: PlatformAppBar(
            automaticallyImplyLeading: true,
            title: Text(
              'All stores',
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
            ),
            trailingActions: const [
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 14),
                child: LanguageSelectionWidget(),
              ),
            ],
          ),
          body: SlideInLeft(
            key: const Key('get-all-store-slideinleft-widget'),
            delay: const Duration(milliseconds: 500),
            from: context.width - 40,
            child: PageBody(
              controller: scrollController,
              constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: media.size.height,
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
                    width: double.infinity,
                    constraints: BoxConstraints(
                      minWidth: double.infinity,
                      minHeight: media.size.height,
                    ),
                    child: Stack(
                      children: [
                        BlocBuilder<StoreBloc, StoreState>(
                          key: const Key('get-all-store-blocbuilder-widget'),
                          bloc: context.watch<StoreBloc>(),
                          builder: (context, state) {
                            switch (state) {
                              case GetAllStoreState():
                                {
                                  storeEntities = List<StoreEntity>.from(state.storeEntities.toList());
                                  widgetState = WidgetState<StoreEntity>.allData(
                                    context: context,
                                  );
                                }
                              //case GetEmptyStoreState(:final error):
                              case GetEmptyStoreState():
                                {
                                  storeEntities = [];
                                  storeEntities.clear();
                                  widgetState = WidgetState<StoreEntity>.empty(
                                    context: context,
                                    message: state.message,
                                  );
                                }
                              case StoreLoadingState():
                                {
                                  widgetState = WidgetState<StoreEntity>.loading(
                                    context: context,
                                    isLoading: state.isLoading,
                                    message: state.message,
                                  );
                                }
                              case SaveStoreState():
                                {
                                  storeEntities.add(state.storeEntity);
                                  widgetState = WidgetState<StoreEntity>.allData(
                                    context: context,
                                  );
                                }
                              case _:
                                appLog.d('Default case: all store page');
                            }
                            return ScrollableColumn(
                              controller: scrollController,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: storeEntities.isEmpty ? MainAxisAlignment.center : MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                              flexible: true,
                              physics: const ClampingScrollPhysics(),
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: widgetState.maybeWhen(
                                    empty: (context, child, message, data) => Center(
                                      key: const Key('get-all-store-empty-widget'),
                                      child: Text(
                                        'No store available or added by you',
                                        style: context.labelLarge,
                                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      ).translate(),
                                    ),
                                    loading: (context, child, message, isLoading) {
                                      return const Center(
                                        key: Key('get-all-store-center-widget'),
                                        child: SizedBox(
                                          width: 48,
                                          height: 48,
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    },
                                    allData: (context, child, message, data) {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        key: const Key('get-all-store-listviewbuilder-widget'),
                                        controller: listViewBuilderScrollController,
                                        itemCount: storeEntities.length,
                                        itemBuilder: (context, index) {
                                          return StoreCard(
                                            key: ValueKey(index),
                                            storeEntity: storeEntities[index],
                                          );
                                        },
                                      );
                                    },
                                    none: () {
                                      return Center(
                                        child: Text(
                                          'No store available or added by you',
                                          style: context.labelLarge,
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        ).translate(),
                                      );
                                    },
                                    orElse: () {
                                      return const SizedBox();
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        PositionedDirectional(
                          bottom: kBottomNavigationBarHeight - 10,
                          start: 0,
                          end: 0,
                          child: ElevatedButton(
                            onPressed: () {
                              context.go(Routes.SAVE_STORE_PAGE);
                              return;
                            },
                            child: Text(
                              'Add Store',
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            ).translate(),
                          ),
                        )
                      ],
                    ),
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
