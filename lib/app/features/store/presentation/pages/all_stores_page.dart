part of 'package:homemakers_merchant/app/features/store/index.dart';

class AllStoresPage extends StatefulWidget {
  const AllStoresPage({super.key});

  @override
  State<AllStoresPage> createState() => _AllStoresPageState();
}

class _AllStoresPageState extends State<AllStoresPage> {
  late final ScrollController scrollController;
  late final ScrollController innerScrollController;
  List<StoreEntity> storeEntities = [];
  late final ScrollController listViewBuilderScrollController;
  ResultState<StoreEntity> resultState = const ResultState.empty();
  WidgetState<StoreEntity> widgetState = const WidgetState<StoreEntity>.none();
  final TextEditingController searchTextEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    innerScrollController = ScrollController();
    listViewBuilderScrollController = ScrollController();
    storeEntities = [];
    storeEntities.clear();
    context.read<StoreBloc>().add(GetAllStore());
    initStoreList();
  }

  void initStoreList() {}

  @override
  void dispose() {
    scrollController.dispose();
    innerScrollController.dispose();
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
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text(
              'All stores',
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
            ),
            actions: const [
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
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: storeEntities.isEmpty ? MainAxisAlignment.center : MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                              children: [
                                AnimatedCrossFade(
                                  firstChild: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    children: [
                                      const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                                      IntrinsicHeight(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                          children: [
                                            Expanded(
                                              child: AppTextFieldWidget(
                                                controller: searchTextEditingController,
                                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                                textInputAction: TextInputAction.done,
                                                keyboardType: TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText: 'Search',
                                                  hintText: 'Search store',
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  isDense: true,
                                                ),
                                              ),
                                            ),
                                            const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                            SizedBox(
                                              height: 52,
                                              child: OutlinedButton(
                                                onPressed: () {},
                                                style: OutlinedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadiusDirectional.circular(10),
                                                  ),
                                                  side: const BorderSide(color: Color.fromRGBO(238, 238, 238, 1)),
                                                  backgroundColor: Colors.white,
                                                ),
                                                child: Icon(
                                                  Icons.filter_list,
                                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                                  color: context.primaryColor,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                                      ListTile(
                                        dense: true,
                                        title: IntrinsicHeight(
                                          child: Row(
                                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                            children: [
                                              Text(
                                                'Your Stores',
                                                style: context.labelLarge!.copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                              ),
                                              const AnimatedGap(3, duration: Duration(milliseconds: 500)),
                                              Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadiusDirectional.circular(20),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsetsDirectional.only(start: 12.0, end: 12, top: 4, bottom: 4),
                                                  child: Text(
                                                    '${storeEntities.length}',
                                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                                        horizontalTitleGap: 0,
                                        minLeadingWidth: 0,
                                        contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 2),
                                      ),
                                      const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                                    ],
                                  ),
                                  secondChild: const Offstage(),
                                  duration: const Duration(milliseconds: 500),
                                  crossFadeState: (storeEntities.isNotEmpty) ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                ),
                                Expanded(
                                  flex: 2,
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
                                      return ListView.separated(
                                        itemBuilder: (context, index) {
                                          return StoreCard(
                                            key: ValueKey(index),
                                            storeEntity: storeEntities[index],
                                            listOfAllStoreEntities: storeEntities.toList(),
                                            currentIndex: index,
                                          );
                                        },
                                        itemCount: storeEntities.length,
                                        separatorBuilder: (context, index) {
                                          return const Divider(thickness: 0.25, color: Color.fromRGBO(127, 129, 132, 1));
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
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          context.push(Routes.SAVE_STORE_PAGE);
                                          return;
                                        },
                                        child: Text(
                                          'Add Store',
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        ).translate(),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
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
    );
  }
}
