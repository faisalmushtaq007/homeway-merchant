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
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    innerScrollController = ScrollController();
    context.read<PermissionBloc>().add(const RequestLocationPermissionEvent());
  }

  @override
  void dispose() {
    scrollController.dispose();
    innerScrollController.dispose();
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
                    child: Form(
                      key: state.addressFormPageFormKey,
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
                                    const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                                    Align(
                                      alignment: AlignmentDirectional.topStart,
                                      child: Text(
                                        'Enter store details',
                                        style: context.titleLarge,
                                      ).translate(),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (state.addressFormPageFormKey.currentState!.validate()) {
                                          state.addressFormPageFormKey.currentState!.save();

                                          return;
                                        }
                                        return;
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(69, 201, 125, 1),
                                      ),
                                      child: Text(
                                        'Save Address',
                                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      ).translate(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
