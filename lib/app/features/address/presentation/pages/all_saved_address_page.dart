part of 'package:homemakers_merchant/app/features/address/index.dart';

class AllSavedAddressPage extends StatefulWidget {
  const AllSavedAddressPage({super.key});
  @override
  _AllSavedAddressPageController createState() => _AllSavedAddressPageController();
}

class _AllSavedAddressPageController extends State<AllSavedAddressPage> {
  late final ScrollController scrollController;
  late final ScrollController innerScrollController;
  final addressFormPageFormKey = GlobalKey<FormState>();
  WidgetState<AddressModel> widgetState = const WidgetState<AddressModel>.none();
  List<AddressModel> addressEntities = [];
  Future<List<sl.Result>> _results = Future.value([]);

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    innerScrollController = ScrollController();
    addressEntities = [];
    addressEntities.clear();
    context.read<PermissionBloc>().add(const RequestLocationPermissionEvent());
    if (mounted) {
      context.read<AddressBloc>().add(GetAllAddress());
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    innerScrollController.dispose();
    addressEntities = [];
    addressEntities.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _AllSavedAddressPageView(this);
}

class _AllSavedAddressPageView extends WidgetView<AllSavedAddressPage, _AllSavedAddressPageController> {
  const _AllSavedAddressPageView(super.state);

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
      child: Scaffold(
        appBar: AppBar(
          actions: const [
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 14),
              child: LanguageSelectionWidget(),
            ),
          ],
        ),
        body: Directionality(
          textDirection: serviceLocator<LanguageController>().targetTextDirection,
          child: SlideInLeft(
            key: const Key('all-saved-address-page-slideleft-widget'),
            delay: const Duration(milliseconds: 500),
            child: PageBody(
              controller: state.scrollController,
              constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: media.size.height,
              ),
              child: BlocBuilder<PermissionBloc, PermissionState>(
                bloc: context.read<PermissionBloc>(),
                buildWhen: (previous, current) => previous != current,
                builder: (context, permissionState) {
                  return Container(
                    constraints: BoxConstraints(
                      minWidth: double.infinity,
                      minHeight: media.size.height,
                    ),
                    child: CustomScrollView(
                      controller: state.innerScrollController,
                      physics: const ClampingScrollPhysics(),
                      slivers: [
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                                child: SherlockSearchBar(
                                                  isFullScreen: true,
                                                  sherlock: Sherlock(elements: state.addressEntities.map((e) => e.toMap()).toList()),
                                                  sherlockCompletion: SherlockCompletion(where: 'by', elements: state.addressEntities),
                                                  sherlockCompletionMinResults: 1,
                                                  onSearch: (input, sherlock) {
                                                    /*setState(() {
                                                      state._results = sherlock.search(input: input);
                                                    });*/
                                                  },
                                                  completionsBuilder: (context, completions) => SherlockCompletionsBuilder(
                                                    completions: completions,
                                                    buildCompletion: (completion) => Padding(
                                                      padding: const EdgeInsets.all(8),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            completion,
                                                            style: const TextStyle(fontSize: 14),
                                                          ),
                                                          const Spacer(),
                                                          const Icon(Icons.check),
                                                          const Icon(Icons.close)
                                                        ],
                                                      ),
                                                    ),
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
                                                  'Your Address',
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
                                                      '${state.addressEntities.length}',
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
                                    crossFadeState: (state.addressEntities.isNotEmpty) ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: state.widgetState.maybeWhen(
                                      empty: (context, child, message, data) => Center(
                                        key: const Key('get-all-address-empty-widget'),
                                        child: Text(
                                          'No address available or added by you',
                                          style: context.labelLarge,
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        ).translate(),
                                      ),
                                      loading: (context, child, message, isLoading) {
                                        return const Center(
                                          key: Key('get-all-address-center-widget'),
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
                                            return AddressCardWidget(
                                              key: ValueKey(index),
                                              addressEntity: state.addressEntities[index],
                                              listOfAllAddressEntities: state.addressEntities.toList(),
                                              currentIndex: index,
                                            );
                                          },
                                          itemCount: state.addressEntities.length,
                                          separatorBuilder: (context, index) {
                                            return const Divider(thickness: 0.25, color: Color.fromRGBO(127, 129, 132, 1));
                                          },
                                        );
                                      },
                                      none: () {
                                        return Center(
                                          child: Text(
                                            'No address available or added by you',
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
                                          onPressed: () async {
                                            final navigateToSaveStorePage = await context.push(
                                              Routes.PICKUP_LOCATION_FROM_MAP_PAGE,
                                              extra: {
                                                'addressEntity': null,
                                                'addressEntities': state.addressEntities.toList(),
                                                'haveNewAddress': true,
                                                'currentIndex': -1,
                                              },
                                            );
                                            if (!state.mounted) {
                                              return;
                                            }
                                            context.read<AddressBloc>().add(GetAllAddress());
                                            return;
                                          },
                                          child: Text(
                                            'Add New Address',
                                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                          ).translate(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
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
